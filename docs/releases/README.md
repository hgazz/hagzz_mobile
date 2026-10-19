# Customer app 1.0.24+202

[Download the signed Google Play AAB](Hagzz-Customer-1.0.24-202.aab).

Use **versionCode 202**, versionName **1.0.24**. The owner confirmed Play Console already contains production versionCode 200 (1.0.22) and draft 201 (1.0.23). The earlier 48 bundle is obsolete and must not be uploaded as an update.

Package: `com.unlimitedhagzz.hagzz`. This is the customer app, not the partner app. Deploy API commit a45373e or later before releasing it. The new Egypt/Qatar catalog is marked as demo and enables no bookings or payments. The production `/api/mobile-catalog` 404 must be resolved before rollout.

The AAB is a Google Play upload artifact, not an APK for direct installation. Local signature and ZIP integrity checks passed; see the version-specific verification JSON for SHA-256 and manifest details. Confirm the signing certificate matches the registered Play upload certificate before submitting. Firebase Crashlytics mapping upload was blocked by the build environment; the mapping was retained separately.

The binary is stored here because GitHub Release asset upload returned 403. No Google Play submission has been performed.
