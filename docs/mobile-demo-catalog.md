# Customer mobile catalog: Egypt and Qatar

`GET /api/mobile-catalog?country=eg` (or `qa`) returns 15 academies and 45 training programs per country. It is a public, read-only endpoint independent of login, FCM updates, live partner tables and booking/payment records. Invalid countries return 422; POST is unsupported.

The source snapshot is `resources/catalog/mobile-demo.json`, copied from the reviewed admin catalog. To refresh it after editing the admin data, copy `hagzz_admin/resources/catalog/egypt-qatar-proposals.json` to this path, rerun MobileCatalogTest and deploy API. This endpoint deliberately returns a public field allowlist, excluding lead contacts, sales messages, source notes and verification metadata.

Every academy and training has `is_demo: true` and `bookable: false`, with string catalog keys rather than live academy/training IDs. The new customer mobile screen uses its own catalog view; it never passes these items to live booking, payment, favorite or follow flows. Generic Hagzz illustrations are separate from unverified official academy logos. Missing official logos remain null.

## What users see

Customer app 1.0.19+48 adds an entry below the home slider (also available in the home error state), opening a country selector and expandable academy cards. The screen displays each academy's three programs, package prices, fictional coaches, demo locations and schedules with local time zones, plus a visible demo/no-booking notice. It shows a retry action when the API is unavailable. The old academy/training lists remain dedicated to actual operational records.

**The currently installed Play version does not know this new screen. API deployment alone cannot add a new Flutter screen to an already installed app.** Deploy API first, then publish/install the new app version. Until users update, they will not see this catalog section. Check that version code 48 exceeds every version already uploaded in Play Console; use a higher code if necessary. Validate the signing certificate against the app's existing upload certificate before submitting to Play.

## API deployment

After fetching master in the server's hagzz_api checkout, build and restart the `api` compose service from `/home/hagzz/hagzz/infra`. Then refresh routes:

```bash
docker compose build api
docker compose up -d --no-deps api
docker compose exec -T -w /var/www/html api php artisan route:cache
```

No database migration or seed is required for this feature. APP_URL must point to the public HTTPS API origin so illustration URLs resolve. Existing brand image files under public/media/hagzz/brand-v1 must be present and served as images. Verify the JSON endpoint for both countries externally before releasing the app.

## Validation

API: MobileCatalogTest verifies the actual HTTP endpoint for guests, 15/45 counts per country, currency, no booking IDs or database queries, demo flags, and invalid-country/read-only handling. Existing banner/image/install tests remain applicable.

Customer Flutter: mobile_catalog_test verifies country switching, EGP/QAR prices, coach display, no checkout controls and error retry. The new screen is independent of legacy TrainingModel IDs. A successful debug APK build verifies compilation. Production deployment, Google Play submission and physical-device smoke testing are separate steps and must not be claimed from local tests alone.

## طريقة إظهار المحتوى للمستخدمين

العمل الحالي يربط كتالوج الجهات الثلاثين والتدريبات التسعين بتطبيق العملاء نفسه، عبر قسم «أكاديميات وتدريبات مصر وقطر» في الشاشة الرئيسية. يبقى الوصول إليه متاحًا عند تحميل بيانات الصفحة القديمة أو فشلها. اختيار الدولة يعرض جهاتها الخمس عشرة، وفتح بطاقة الجهة يعرض برامجها الثلاثة والأسعار والمدرب والموقع والمواعيد التجريبية.

يلزم نشر كود API أولًا، ثم نشر إصدار العميل الجديد في Google Play ووصول التحديث إلى المستخدمين. النسخة القديمة المثبتة لا تستطيع إظهار شاشة Flutter جديدة لمجرد تحديث السيرفر. الملف الجديد لا يحتاج seed أو migration، ولا ينشئ حجوزات أو مدفوعات أو حسابات شركاء أو فروعًا مصطنعة في جداول التشغيل.

ظهور هذا المحتوى للمستخدمين لا يعني تأكيد بيانات الأكاديميات؛ الشاشة تشرح أنها نسخة تجريبية، وتبقي الشعارات الرسمية غير المتحقق منها فارغة. الصور العامة موسومة بأنها صور توضيحية لحجّز وليست صور المنشآت. لا يوجد انتقال منها إلى الدفع أو الحجز أو المتابعة أو المفضلة.

## Verified release candidate

Local release build completed for version **1.0.19+48**, package `com.unlimitedhagzz.hagzz`, with minSdk **23** and armv7/arm64/x86_64 libraries. The signed AAB is 86,371,095 bytes; SHA-256:

```
d4f4a27305d4258e01bccac6ae77e4e51fce1024cdfd7ca4c3819a596bbc6e27
```

JAR signature verification and ZIP integrity checks passed. This proves local artifact integrity, not acceptance by Google Play or a match with its registered upload certificate.

The first release build stopped at `uploadCrashlyticsMappingFileRelease` because the external upload returned 403. The final local build used the existing Gradle wrapper with `bundleRelease`, three target platforms and `-x :app:uploadCrashlyticsMappingFileRelease`. Signing, minification and release lint remained enabled. The R8 mapping was retained at `/workspace/mobile-delivery/Hagzz-Customer-1.0.19-48-mapping.txt` for later upload from an environment with Firebase access.

Flutter's automatic build-file migration was undone before the final build so that `minSdk 23` was preserved. The final processed manifest was checked for versionName 1.0.19, versionCode 48 and minSdk 23. No source changes to Gradle were retained.


## Play Console version correction

The owner confirmed production code 200 (1.0.22) and draft code 201 (1.0.23). The 48 candidate cannot update these versions. The replacement uses **1.0.24+202**, preserving the same catalog feature and minSdk 23. Candidate 202 has been superseded and its release files removed; use the current candidate linked in [releases/README.md](releases/README.md). The historical 48 build details above remain a record of the first candidate only.

The production API 404 remains a separate deployment blocker. Resolve it and verify both country endpoints before rolling out this mobile release.


## Automatic Protection SDK requirement

Play Console rejected the API-23 candidate because Automatic Protection is enabled. The replacement **1.0.25+203** uses **minSdk 24**, supporting Android 7 and newer. Android 6/API 23 devices cannot install this new release. The existing signing configuration, package ID, catalog functionality and target SDK are unchanged. Candidate 203 has also been superseded and its release files removed; use version 204 linked in [releases/README.md](releases/README.md). Automatic Protection was not disabled.

A subsequent owner-provided server/browser screenshot confirmed API deployment: `/api/mobile-catalog?country=eg` returned status 200 with 15 academies and 45 programs, the route was listed inside the API container, and six brand banner records were created. This supersedes the earlier reported API 404 blocker; it is evidence from the owner's screenshot rather than a direct production request from this restricted environment.
