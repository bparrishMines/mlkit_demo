# Flutter Live Camera with ML Kit Example Project

This project displays a live camera preview that highlights detected barcodes/faces/labels/text
using ML Kit for Firebase.

## How to use with your own project ##

1. Add Firebase to your app. You can follow instruction here for
[iOS](https://firebase.google.com/docs/ios/setup) and
[android](https://firebase.google.com/docs/android/setup). You only need to follow the instructions
to the point of including the config file. The `firebase_ml_vision` plugin will have the sdk already
included.

3. Include latest versions of the [camera](https://pub.dartlang.org/packages/camera) and
[firebase_ml_vision](https://pub.dartlang.org/packages/firebase_ml_vision) plugins in your project
and follow instructions on including camera access permissions. Pay close attention to the
`README.md` of both plugins to make sure everything is properly setup.

3. Include `main.dart`, `utils.dart`, and `detector_painters.dart` in your project's lib folder.
