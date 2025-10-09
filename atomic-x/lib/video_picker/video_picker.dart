import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../base_component/localizations/atomic_localizations.dart';

class VideoPickerResult {
  final String filePath;
  final String fileName;
  final int fileSize;
  final String extension;

  VideoPickerResult({
    required this.filePath,
    required this.fileName,
    required this.fileSize,
    required this.extension,
  });

  @override
  String toString() {
    return 'VideoPickerResult(filePath: $filePath, fileName: $fileName, fileSize: $fileSize, extension: $extension)';
  }
}

class VideoPickerConfig {
  final int? maxCount;
  final int? gridCount;
  final Color? primaryColor;

  VideoPickerConfig({
    this.maxCount,
    this.gridCount,
    this.primaryColor,
  });
}

class VideoPicker {
  static const int defaultMaxCount = 9;
  static const int defaultGridCount = 4;

  static final VideoPicker instance = VideoPicker._internal();

  VideoPicker._internal();

  static Future<List<VideoPickerResult>> pickVideos({
    required BuildContext context,
    VideoPickerConfig? config,
  }) async {
    try {
      final List<AssetEntity>? result = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          requestType: RequestType.video,
          maxAssets: config?.maxCount ?? defaultMaxCount,
          gridCount: config?.gridCount ?? defaultGridCount,
          themeColor: config?.primaryColor,
        ),
      );

      if (result == null || result.isEmpty) {
        return [];
      }

      List<VideoPickerResult> results = [];

      for (final assetEntity in result) {
        final File? file = await assetEntity.file;
        if (file == null) {
          continue;
        }

        String finalPath = file.path;

        String fileName = path.basename(file.path);
        String extension = path.extension(file.path).toLowerCase().replaceFirst('.', '');

        results.add(VideoPickerResult(
          filePath: finalPath,
          fileName: fileName,
          fileSize: await file.length(),
          extension: extension,
        ));
      }

      return results;
    } catch (e) {
      debugPrint('VideoPickerService.pickMultipleAssets error: $e');
      if (context.mounted) {
        _showErrorDialog(context, 'Failed：$e');
      }
      return [];
    }
  }

  static void _showErrorDialog(BuildContext context, String message) {
    AtomicLocalizations atomicLocal = AtomicLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(atomicLocal.error),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(atomicLocal.confirm),
          ),
        ],
      ),
    );
  }

  static Future<String> _copyFileToSandbox(File file, AssetEntity asset) async {
    try {
      final appDir = await getApplicationCacheDirectory();
      var targetDir = Directory('${appDir.path}/images');
      if (asset.type == AssetType.video) {
        targetDir = Directory('${appDir.path}/videos');
      }

      if (!await targetDir.exists()) {
        await targetDir.create(recursive: true);
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final originalExt = path.extension(file.path);
      final fileName = 'image_$timestamp$originalExt';
      final targetPath = '${targetDir.path}/$fileName';

      final newFile = await file.copy(targetPath);
      return newFile.path;
    } catch (e) {
      debugPrint('_copyFileToSandbox faield: $e');
      return file.path;
    }
  }
}
