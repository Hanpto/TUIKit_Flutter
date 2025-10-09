import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AlbumPickerResult {
  static const int albumImage = 1;
  static const int albumVideo = 2;

  final int albumType;
  final String filePath;
  final String fileName;
  final int fileSize;
  final String extension;

  AlbumPickerResult({
    required this.albumType,
    required this.filePath,
    required this.fileName,
    required this.fileSize,
    required this.extension,
  });

  @override
  String toString() {
    return 'AlbumPickerResult(albumType: $albumType, filePath: $filePath, fileName: $fileName, fileSize: $fileSize, extension: $extension)';
  }
}

class AlbumPickerConfig {
  static const int pickModeAll = 1;
  static const int pickModeImage = 2;
  static const int pickModeVideo = 3;

  final int pickMode;
  final int? maxCount;
  final int? gridCount;
  final Color? primaryColor;

  AlbumPickerConfig({
    this.pickMode = pickModeAll,
    this.maxCount,
    this.gridCount,
    this.primaryColor,
  });
}

class AlbumPicker {
  static const int defaultMaxCount = 9;
  static const int defaultGridCount = 4;

  static final AlbumPicker instance = AlbumPicker._internal();

  AlbumPicker._internal();

  static Future<List<AlbumPickerResult>> pickMedia({
    required BuildContext context,
    AlbumPickerConfig? config,
  }) async {
    RequestType requestType = RequestType.common;
    if (config?.pickMode == AlbumPickerConfig.pickModeImage) {
      requestType = RequestType.image;
    } else if (config?.pickMode == AlbumPickerConfig.pickModeVideo) {
      requestType = RequestType.video;
    } else {
      requestType = RequestType.common;
    }

    try {
      final List<AssetEntity>? result = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          requestType: requestType,
          maxAssets: config?.maxCount ?? defaultMaxCount,
          gridCount: config?.gridCount ?? defaultGridCount,
          themeColor: config?.primaryColor,
        ),
      );

      if (result == null || result.isEmpty) {
        return [];
      }

      List<AlbumPickerResult> results = [];

      for (final assetEntity in result) {
        final File? file = await assetEntity.file;
        if (file == null) {
          continue;
        }

        String finalPath = file.path;
        String fileName = path.basename(file.path);
        String extension = path.extension(file.path).toLowerCase().replaceFirst('.', '');

        results.add(AlbumPickerResult(
          albumType: assetEntity.type == AssetType.image ? AlbumPickerResult.albumImage : AlbumPickerResult.albumVideo,
          filePath: finalPath,
          fileName: fileName,
          fileSize: await file.length(),
          extension: extension,
        ));
      }

      return results;
    } catch (e) {
      debugPrint('AlbumPickerService.pickMultipleImages error: $e');
      return [];
    }
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
      debugPrint('_copyFileToSandbox failed: $e');
      return file.path;
    }
  }
}
