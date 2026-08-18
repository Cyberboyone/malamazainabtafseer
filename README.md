# Malama Zainab Jaafar Tafseer 1447

Offline audio app of the Tafseer 1447 series by **Malama Zainab Jaafar Mahmud**.
18 audio lessons (about 17 hours) bundled in-app — no internet needed to listen.

## Features

- 18 offline lessons (Opus, ~6 kbps mono 16 kHz — only ~50 MB total)
- Resume where you left off (position saved per lesson)
- Background playback with lock-screen / notification controls
- Course playlist: auto-plays the next part when one finishes
- Shuffle, loop and seek controls
- AdMob banner ads (requires internet at startup for ads to load)

## Tech

- Flutter (Dart)
- `just_audio` + `just_audio_background` for playback
- `shared_preferences` for progress persistence
- Native AdMob banner via Android platform view
- Neumorphic (soft UI) design

## Project structure

```
assets/
  audio/          # 18 bundled lessons (Tafsir_1447_001.ogg … 018.ogg)
  images/         # scholar photo + launcher icon source
lib/
  data/           # lesson catalogue (titles, durations, asset paths)
  models/         # Lesson model
  screens/        # Home + Player screens
  services/       # audio, ads, duration probe, progress persistence
  theme/          # neumorphic design tokens
  widgets/        # lesson cards, mini player
android/          # Android host (banner ad platform view, signing)
.github/workflows/build.yml   # CI: tests, analyze, debug APK, release AAB+APK
```

## Build

CI builds on every push to `main` (GitHub Actions, Flutter 3.44.8 stable):

- debug APK
- release APK (Play Store sideload)
- release AAB (Play Store upload)

Download artifacts from the **Actions** tab, or trigger a manual run and
enter a `release_tag` (e.g. `v1.0.0`) to also publish a GitHub Release with
the AAB + APK attached.

### Manual build

```sh
flutter pub get
flutter test
flutter analyze
flutter build appbundle --release   # Play Store AAB
flutter build apk --release         # sideload APK
```

## Release signing

The release keystore is **not** committed. CI reads it from GitHub secrets:

| Secret             | Purpose                                |
|--------------------|----------------------------------------|
| `KEYSTORE_BASE64`  | base64 of `keystore/malamazainabtafseer-release.jks` |
| `KEYSTORE_PASSWORD`| keystore password                      |
| `KEY_ALIAS`        | `malamazainab`                         |
| `KEY_PASSWORD`     | key password                           |

The original `.jks` file and passwords are stored locally in the
`keystore/` folder (gitignored). **Keep them safe forever** — you need the
same key to upload updates to Play Store. Do not lose it.

## Play Store

- Package name: `com.nakudin.malamazainabtafseer`
- Version: `1.0.0+1` (bump `version:` in `pubspec.yaml` per release)
- AdMob app ID: `ca-app-pub-9529770421530115~7281511607`
- Banner ad unit: `ca-app-pub-9529770421530115/5278164798`
- Privacy policy: see `PRIVACY_POLICY.md` (publish it at a public URL and
  paste the link in Play Console → App content → Privacy policy)

## License

Audio content belongs to Malama Zainab Jaafar Mahmud. App code is
provided for the app's distribution on Google Play.
