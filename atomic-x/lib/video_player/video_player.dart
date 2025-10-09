import 'package:flutter/material.dart';
import 'video_player_widget.dart';

class VideoPlayer {
  static Future<void> play(
    BuildContext context, {
    required VideoData video,
  }) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoPlayerWidget(
          video: video,
        ),
      ),
    );
  }
}
