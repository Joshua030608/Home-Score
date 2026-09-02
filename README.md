# Home Score

Home Score is an iOS app for comparing prospective homes with a customizable,
weighted scorecard. Users can add homes, attach photos and notes, rate each
category, adjust category weights, and compare saved homes side by side.

## Features

- Create, edit, and delete home records with prices, notes, addresses, and
  photo galleries.
- Score homes across default and custom categories.
- Set a relative weight for each category and calculate a weighted overall
  Home Score.
- Compare saved homes and category-level scores.
- Persist home and category data locally in the app's Documents directory.

## Run locally

1. Open `Home Score.xcodeproj` in Xcode.
2. Select an iOS simulator or connected device.
3. Build and run the `Home Score` target.

The repository does not include saved homes, user photos, or other personal
app data. Those items are created and stored only on the local device.

## Project structure

```text
Home Score/Controller/  View-controller behavior and editing flows
Home Score/Model/       Home/category models and local persistence
Home Score/View/        Table, collection, and score-picker views
Home ScoreTests/        Unit tests
Home ScoreUITests/      UI-test target
```

## Status

This is a UIKit learning project originally built for iOS. It is preserved as
an example of model-driven UIKit development and local persistence; use a
current Xcode version to verify deployment-target compatibility before
shipping it to the App Store.
