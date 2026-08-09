# Sawasdee

iOS app for learning everyday Thai — greetings, tones, digits, currency, clock phrases, and themed vocabulary.

## Features

- Phrase search with Thai meaning and karaoke-style romanization
- Category browsing backed by `words.json` / `categories.json`
- Alphabet and tone practice views
- Digit, currency, and clock helpers
- Themeable UI (blue / green / pink / orange)

## Project layout

| Path | Role |
|------|------|
| `Sawasdee/` | App sources, assets, and JSON content |
| `Sawasdee.xcodeproj` | Xcode project |
| `SawasdeeTests/` | Unit test target |
| `Crashlytics.framework` | Bundled Crashlytics SDK |

## Content data

Phrase catalogs live as strict JSON under `Sawasdee/`:

- `words.json` — `ITEMS`
- `categories.json` — `CATEGORIES`
- `currencies.json` — `CURRENCIES`
- `holiday.json` — `HOLIDAYS`

`SawasdeeTests` asserts these files parse with `NSJSONSerialization` (no trailing commas), that every row has the required fields (`WORD`/`TAG`/`MEANING`/`KARAOKE` for phrases, and the matching keys for categories, currencies, and holidays), that each holiday `DATE` is `YYYYMMDD` and matches its `YEAR`/`MONTH`/`DAY` fields, and that `WORD`, category `NAME`, and currency `VALUE` entries are unique within their catalogs.

## Build

Open `Sawasdee.xcodeproj` in Xcode and run the **Sawasdee** scheme on an iOS Simulator or device.

API keys in `Sawasdee/Classes/Constant.h` are intentionally blank for the public tree — fill them locally if you enable ads, analytics, or cloud services.
