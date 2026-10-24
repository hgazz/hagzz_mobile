# Customer app 1.0.28+206 — internal-test candidate

[Download the signed 206 AAB](Hagzz-Customer-1.0.28-206.aab).

Package `com.unlimitedhagzz.hagzz`, target/compile SDK **36**, min SDK **24**. Bundle structure and signature verified; signing certificate matches 205. Seven startup/catalog widget tests passed, with no issues in targeted startup analysis.

This candidate retains the notification startup fix from 205 and fixes first-frame initialization and timeout/retry state handling. See the [startup investigation and Play testing checklist](1.0.28-206.md), [verification metadata](Hagzz-Customer-1.0.28-206-verification.json), and [SHA-256](Hagzz-Customer-1.0.28-206.aab.sha256).

Install from Google Play internal testing before production submission. Device startup and the reviewer ANR are not verified here. Crashlytics mapping upload was blocked by HTTP 403; the mapping is retained in the build workspace. No Google Play submission or publication was performed.

---

## Previous candidate: 1.0.27+205

[Download the signed Google Play AAB](Hagzz-Customer-1.0.27-205.aab).

Package: `com.unlimitedhagzz.hagzz`. Version code **205**, version name **1.0.27**; minSdk **24**, target/compile SDK **36**. Only the latest candidate and its verification metadata are retained in this directory.

## Startup fixes after the version 204 review rejection

Version 204 was rejected for loading/broken functionality. The exact reviewer failure has not been reproduced: no reviewer video, Android device/emulator, or production endpoint access was available here. These changes address concrete startup failure paths found in source:

- Paint a startup screen immediately, before asynchronous initialization.
- Bound initialization to 20 seconds and show an Arabic/English retry screen on timeout or failure.
- Retrieve the optional Firebase notification token after startup, with a 10-second timeout. Token retrieval or notification denial must not prevent app access. Do not automatically open Android settings after notification denial.
- Read cached routing state before the splash decides where to navigate; check mounted state before delayed navigation.
- Bound API connections to 15 seconds and send/receive waits to 20 seconds.
- Guard the connectivity alert until a navigator exists, and cancel its subscription on disposal.
- Preserve the Firebase background handler in release compilation.

Validation: five widget tests passed (startup first frame, failure/retry, timeout/late completion, catalog country switching, catalog failure/retry). Targeted startup analysis reported no issues. Broader analysis of touched storage/splash files retains four pre-existing informational lints. See the verification JSON for signed-AAB build validation.

## Before production review

Upload 205 to internal testing and install **from Google Play**. Verify a clean installation reaches onboarding, guest access reaches home, authenticated access works, denial of notifications does not block opening, offline launch has usable recovery, and connectivity restoration loads actual data. Test API 24 and a current Android device, then review Play's pre-launch report and Android vitals. Device testing and production API availability are **not verified by the cloud build**; the environment proxy denied API access with CONNECT 403.

Retain old bundle 40 only if Play still needs it to cover older devices; exclude bundle 100 when Play reports it is fully covered by the new candidate. Recheck device coverage rather than assuming it is unchanged.

No Google Play submission or publication has been performed by this environment. The existing API catalog remains demo data, with no booking/payment capability. Firebase Crashlytics mapping upload is excluded because the environment blocks that upload; the release remains signed and minified with release lint enabled. Preserve the mapping separately for upload from an authorized environment.
