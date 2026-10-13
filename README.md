# PayDay

PayDay is a personal offline-first Flutter app built for tracking workdays, earnings, advances, and balances without needing an online backend.

Features:
- Track individual workdays with start/end time, hours and rate.
- Automatically calculate earned amounts.
- Track advances and pending approvals.
- Keep everything stored locally with Hive.
- Modern dark UI with a premium, mobile-first design.
- Works fully offline.

## Run locally

1. Install Flutter.
2. Run:
   flutter pub get
   flutter run

## Build APK

flutter build apk --release

## Notes

This version is a single-user app for personal use only, with no admin mode and no online sync by default.
