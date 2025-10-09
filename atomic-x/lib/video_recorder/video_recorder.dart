import 'package:image_picker/image_picker.dart';

class VideoRecorderResult {
  final String filePath;

  VideoRecorderResult({
    required this.filePath,
  });

  @override
  String toString() {
    return 'VideoRecorderResult(filePath: $filePath)';
  }
}

class VideoConfig {
  bool defaultFrontCamera;
  int? maxVideoDuration;

  VideoConfig({
    this.defaultFrontCamera = false,
    this.maxVideoDuration,
  });
}

class PhotoConfig {
  bool defaultFrontCamera;
  double? maxWidth;
  double? maxHeight;

  /// quality: 0 ~ 100
  int? imageQuality;

  PhotoConfig({
    this.defaultFrontCamera = false,
    this.maxWidth,
    this.maxHeight,
    this.imageQuality,
  });
}

class VideoRecorder {
  static const String videoRecorderServiceName = "VideoRecorderService";

  static final VideoRecorder instance = VideoRecorder._internal();

  VideoRecorder._internal();

  Future<VideoRecorderResult> takeVideo({VideoConfig? config}) async {
    final ImagePicker picker = ImagePicker();
    CameraDevice cameraDevice = CameraDevice.rear;
    if (config?.defaultFrontCamera == true) {
      cameraDevice = CameraDevice.front;
    }

    Duration? duration;
    if (config != null && config.maxVideoDuration != null && config.maxVideoDuration! > 0) {
      duration = Duration(seconds: config.maxVideoDuration!);
    }

    final file =
        await picker.pickVideo(source: ImageSource.camera, preferredCameraDevice: cameraDevice, maxDuration: duration);
    return VideoRecorderResult(filePath: file?.path ?? '');
  }

  Future<VideoRecorderResult> takePhoto({PhotoConfig? config}) async {
    final ImagePicker picker = ImagePicker();
    CameraDevice cameraDevice = CameraDevice.rear;
    if (config?.defaultFrontCamera == true) {
      cameraDevice = CameraDevice.front;
    }

    final file = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: cameraDevice,
      maxWidth: config?.maxWidth,
      maxHeight: config?.maxHeight,
      imageQuality: config?.imageQuality,
    );
    return VideoRecorderResult(filePath: file?.path ?? '');
  }
}
