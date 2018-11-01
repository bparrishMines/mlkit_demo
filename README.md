# How to use with your own project

* Note: This currently only works with android in the default screen position for your device. (e.g. portrait on a phone or landscape for a tablet)

1. Add dependencies in your `pubspec.yaml` and run `flutter packages get`.

```yaml
firebase_ml_vision:
  git:
    url: git://github.com/bparrishMines/plugins.git
    path: packages/firebase_ml_vision
    ref: demo_all

camera:
  git:
    url: git://github.com/bparrishMines/plugins.git
    path: packages/camera
    ref: demo_all
```

This plugin uses a forked repository of the `camera` and `firebase_ml_vision` plugins to incorporate
ML Kit with an android camera.

2. Copy and paste `face_expression_reader.dart` into your project `lib/` folder.

The `FaceExpressionReader` class handles initializing the camera and setting up the `FaceDetector`.
An example using the `FaceExpressionReader` by displaying an emoji matching the user's face in `lib/main.dart`.
