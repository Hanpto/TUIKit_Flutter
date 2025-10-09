import 'package:flutter/material.dart';
import 'image_element.dart';
import 'image_viewer_widget.dart';

class ImageViewer {
  static Future<void> view(
    BuildContext context, {
    required List<ImageElement> imageElements,
    required int initialIndex,
    required EventHandler onEventTriggered,
  }) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageViewerWidget(
          imageElements: imageElements,
          initialIndex: initialIndex,
          onEventTriggered: onEventTriggered,
        ),
      ),
    );
  }
}
