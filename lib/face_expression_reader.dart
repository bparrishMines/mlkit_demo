import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';

class FaceExpressionReader extends ValueNotifier<Face> {
  FaceExpressionReader._() : super(null);

  static CameraController _controller;
  static bool _isDetecting = false;

  static final FaceExpressionReader instance = FaceExpressionReader._();

  final FaceDetector detector = FirebaseVision.instance.faceDetector(
    FaceDetectorOptions(
      enableClassification: true,
      mode: FaceDetectorMode.accurate,
    ),
  );

  bool get isSmiling => (value?.smilingProbability ?? 0.0) > 0.1;
  bool get isLeftEyeOpen => (value?.leftEyeOpenProbability ?? 1.0) < 0.3;
  bool get isRightEyeOpen => (value?.rightEyeOpenProbability ?? 1.0) < 0.3;
  double get headAngleZ => (value?.headEulerAngleZ) ?? 0.0;

  void init() async {
    if (_controller != null) return;

    final List<CameraDescription> cameras = await availableCameras();

    CameraDescription frontCamera;
    for (CameraDescription camera in cameras) {
      if (camera.lensDirection == CameraLensDirection.front) {
        frontCamera = camera;
        break;
      }
    }

    if (frontCamera == null) throw ArgumentError("No front camera found.");

    _controller = new CameraController(frontCamera, ResolutionPreset.medium);
    _controller.initialize().then((_) {
      _controller.startByteStream((Uint8List bytes) {
        if (!_isDetecting) {
          _isDetecting = true;
          _runDetection(bytes);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    suspend();
  }

  void suspend() {
    _controller?.dispose();
    _controller = null;
    value = null;
  }

  void _runDetection(Uint8List bytes) async {
    final List<Face> faces = await detector.detectInImage(
      FirebaseVisionImage.fromBytes(
        bytes,
        FirebaseVisionImageMetadata(
          size: _controller.value.previewSize,
          rotation: ImageRotation.rotation_270,
        ),
      ),
    );

    if (faces.isNotEmpty) value = faces[0];

    _isDetecting = false;
  }
}