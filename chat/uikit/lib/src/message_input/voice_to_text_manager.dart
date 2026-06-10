// VoiceToTextManager — encapsulates two SDK experimental APIs that together
// upload a local audio file and convert it to text.
//
// Architecture note (technical debt):
// This file directly depends on `tencent_cloud_chat_sdk` because AtomicXCore
// does not yet expose a "convert local audio file → text" API. Once
// `MessageInputStore.convertVoiceToTextFromFile(filePath)` (or equivalent)
// is available in AtomicXCore, this manager should migrate to use it and
// the direct SDK dependency removed.
// TODO(voice-to-text-input): migrate to AtomicXCore once available.

import 'dart:async';

import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';

/// Result of a voice-to-text conversion.
///
/// Sealed-style hierarchy (Dart 2 compatible): callers should switch on
/// the runtime type via `is VoiceToTextSuccess` / `is VoiceToTextFailure`.
abstract class VoiceToTextResult {
  const VoiceToTextResult();
}

/// Conversion succeeded with non-empty text.
class VoiceToTextSuccess extends VoiceToTextResult {
  const VoiceToTextSuccess(this.text);
  final String text;
}

/// Conversion failed (upload error, convert error, empty result, or timeout).
class VoiceToTextFailure extends VoiceToTextResult {
  const VoiceToTextFailure({
    required this.code,
    this.message,
    this.isTimeout = false,
  });

  final int code;
  final String? message;
  final bool isTimeout;
}

/// Function signature compatible with
/// `TencentImSDKPlugin.v2TIMManager.callExperimentalAPI`. Injectable for tests.
typedef CallExperimentalApi = Future<V2TimValueCallback<dynamic>> Function({
  required String api,
  required Map<String, dynamic> param,
});

const String _apiUploadFile = 'internal_operation_upload_file';
const String _apiConvertVoiceToText =
    'internal_operation_convert_voice_to_text';

const String _paramUploadFilePath = 'request_upload_file_file_path';
const String _paramUploadFileType = 'request_upload_file_file_type';
const String _paramConvertUrl = 'request_convert_voice_to_text_url';
const String _paramConvertLanguage = 'request_convert_voice_to_text_language';

const String _respUploadUrl = 'response_upload_file_url';
const String _respConvertText = 'response_convert_voice_to_text_result';

/// File type 3 = audio (matches SDK enum index used in tui_ai_media_process_manager).
const int _fileTypeAudio = 3;

const Duration _defaultTimeout = Duration(seconds: 30);

/// Stateless manager: build once, call [convert] on demand.
class VoiceToTextManager {
  VoiceToTextManager({
    CallExperimentalApi? callExperimentalApi,
    Duration timeout = _defaultTimeout,
  })  : _callExperimentalApi = callExperimentalApi ?? _defaultCallExperimentalApi,
        _timeout = timeout;

  final CallExperimentalApi _callExperimentalApi;
  final Duration _timeout;

  /// Upload [filePath] then convert the uploaded URL to text.
  ///
  /// Returns [VoiceToTextSuccess] when both steps succeed and the converted
  /// text is non-empty. Returns [VoiceToTextFailure] on any error, empty
  /// text, or overall timeout (defaults to 30 seconds).
  Future<VoiceToTextResult> convert(String filePath) async {
    try {
      return await _runPipeline(filePath).timeout(
        _timeout,
        onTimeout: () => const VoiceToTextFailure(
          code: -1,
          message: 'voice-to-text timeout',
          isTimeout: true,
        ),
      );
    } catch (e) {
      return VoiceToTextFailure(code: -1, message: e.toString());
    }
  }

  Future<VoiceToTextResult> _runPipeline(String filePath) async {
    // Step 1: upload local audio file.
    final uploadResult = await _callExperimentalApi(
      api: _apiUploadFile,
      param: <String, dynamic>{
        _paramUploadFilePath: filePath,
        _paramUploadFileType: _fileTypeAudio,
      },
    );
    final uploadUrl = _readStringField(uploadResult, _respUploadUrl);
    if (uploadUrl == null || uploadUrl.isEmpty) {
      return VoiceToTextFailure(
        code: uploadResult.code,
        message: uploadResult.desc.isNotEmpty ? uploadResult.desc : 'upload failed',
      );
    }

    // Step 2: convert uploaded URL to text. Empty `language` means SDK auto-detect.
    final convertResult = await _callExperimentalApi(
      api: _apiConvertVoiceToText,
      param: <String, dynamic>{
        _paramConvertUrl: uploadUrl,
        _paramConvertLanguage: '',
      },
    );
    final text = _readStringField(convertResult, _respConvertText);
    if (text == null || text.isEmpty) {
      return VoiceToTextFailure(
        code: convertResult.code,
        message: convertResult.desc.isNotEmpty
            ? convertResult.desc
            : 'voice-to-text empty or failed',
      );
    }
    return VoiceToTextSuccess(text);
  }

  /// Read a String field from a successful V2TimValueCallback's data map.
  /// Returns null when the call failed (code != 0), data is missing, or the
  /// requested field is absent / not a String.
  String? _readStringField(V2TimValueCallback<dynamic> result, String key) {
    if (result.code != 0 || result.data == null) return null;
    final data = result.data;
    if (data is Map) {
      final value = data[key];
      return value is String ? value : null;
    }
    return null;
  }
}

Future<V2TimValueCallback<dynamic>> _defaultCallExperimentalApi({
  required String api,
  required Map<String, dynamic> param,
}) {
  return TencentImSDKPlugin.v2TIMManager.callExperimentalAPI(
    api: api,
    param: param,
  );
}
