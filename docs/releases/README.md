# Customer app 1.0.25+203

[Download the signed Google Play AAB](Hagzz-Customer-1.0.25-203.aab).

Use **versionCode 203**, versionName **1.0.25**, **minSdk 24 (Android 7+)**. Google Play Automatic Protection rejected the previous API-23 candidate. This replacement raises the minimum SDK to 24 without disabling Automatic Protection. Codes 48 and 202 are obsolete; do not upload them for this release.

Package: `com.unlimitedhagzz.hagzz`. This is the customer app, not the partner app. Deploy API commit a45373e or later before releasing it. The new Egypt/Qatar catalog is marked as demo and enables no bookings or payments. Resolve any production `/api/mobile-catalog` 404 before rollout.

The AAB is a Google Play upload artifact, not an APK for direct installation. See the version-specific verification JSON for artifact hash, SDK and signing verification. The registered Play upload certificate must match. Firebase Crashlytics mapping upload was blocked by the build environment; the mapping was retained separately.

The binary is stored here because GitHub Release asset upload returned 403. No Google Play submission has been performed by this environment.
