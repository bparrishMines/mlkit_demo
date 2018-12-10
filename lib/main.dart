import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';
import 'face_expression_reader.dart';

Future<void> main() async {
  runApp(new MaterialApp(
    home: CameraApp(),
  ));
}

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => new _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  final FaceExpressionReader reader = FaceExpressionReader.instance;

  @override
  void initState() {
    super.initState();
    reader.addListener(() {
      setState(() {});
    });
    reader.init();
  }

  @override
  void dispose() {
    reader.dispose();
    super.dispose();
  }

  String _expressionToEmoji() {
    if (!reader.isLeftEyeOpen && reader.isRightEyeOpen) {
      return "😉";
    } else if (reader.isSmiling) {
      return "😀";
    } else {
      return "😐";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Center(
        child: Transform.rotate(
          angle: radians(reader.headAngleZ),
          child: new Text(
            _expressionToEmoji(),
            style: TextStyle(fontSize: 120.0),
          ),
        ),
      ),
    );
  }
}
