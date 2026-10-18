# Who's My Baby

**Baby Predictor** is a light-hearted iOS app for expecting parents. It predicts a baby's gender with several traditional and folklore methods, and estimates a baby's childhood obesity risk from a short questionnaire.

> The predictions are for fun. They are based on folklore and traditional charts, not medical science.

## Features

**Gender predictor:** four methods, each giving its own boy or girl answer.

| Method | Based on |
|---|---|
| Chinese gender chart | The mother's lunar age and the lunar month of conception (or the due date). |
| Mayan method | The mother's age at conception and the year of conception. |
| Old wives' tales | A yes/no questionnaire about symptoms and changes during pregnancy. |
| Statistical factors | Questions about the mother's age, existing children, marriage length, morning sickness and fertility treatment. |

**Obesity risk:** a questionnaire covering birth weight, smoking during pregnancy, household size and the parents' background, with an explanation of the risk factors.

The **appearance** and **mate match** predictors appear on the home screen as "coming soon" and aren't implemented yet.

## Tech stack

- Swift 5 with UIKit and storyboards; Objective-C helpers for the lunar calendar, solar terms and the obesity calculator, through a bridging header
- iPhone and iPad, iOS 12.4+
- [Google Mobile Ads SDK](https://developers.google.com/admob/ios) for banner and interstitial ads, installed with CocoaPods

## Project layout

```
baby-predictor-ios/
├── Podfile
├── baby-predictor-ios.xcworkspace      # open this one (includes Pods)
└── baby-predictor-ios/
    ├── viewcontroller/                 # one controller per screen and predictor
    ├── util/                           # prediction logic, lunar calendar, storage, colors
    ├── widget/                         # Material-style buttons, radio buttons, text fields
    ├── images/                         # artwork for titles and tiles
    └── Base.lproj/                     # Main and LaunchScreen storyboards
```

## Building

You need Xcode and [CocoaPods](https://cocoapods.org).

```bash
cd baby-predictor-ios
```

```bash
pod install
```

```bash
open baby-predictor-ios.xcworkspace
```

Open the `.xcworkspace`, not the `.xcodeproj`, so the Pods are included. Then select a simulator or device and run. The ad unit IDs are set in `util/WidgetUtil.swift`; for development, use Google's [test ad units](https://developers.google.com/admob/ios/test-ads) instead of the live ones.

## History

Version 1.1.0 is the latest release. The project was developed on Bitbucket from 2019 to 2020 and moved to GitHub with its full commit history.

## License

[MIT](LICENSE)
