// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'chat_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class ChatLocalizationsZh extends ChatLocalizations {
  ChatLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get voiceTranslate => '翻译';

  @override
  String get voiceCancelTranslation => '取消翻译';

  @override
  String get voiceSwitchLanguage => '切换语言';

  @override
  String get voiceReadAloud => '朗读';

  @override
  String get voiceStopReadAloud => '停止';

  @override
  String get voiceSwitchLanguageSheetTitle => '切换翻译语言';

  @override
  String get voiceTranslateFailed => '翻译失败';

  @override
  String get voiceTtsFailed => '朗读失败';

  @override
  String get voiceMessageSettings => '语音消息设置';

  @override
  String get voiceClone => '音色克隆';

  @override
  String get voiceSelect => '音色选择';

  @override
  String get voiceCloneTip => '请录制一段 10-18 秒的语音，用于克隆您的专属音色';

  @override
  String get voiceCloneReadingTipTitle => '建议朗读以下文字：';

  @override
  String get voiceCloneSampleText =>
      '大家好，我是您的专属语音助手，很高兴为您服务。今天天气真不错，希望您有一个愉快的心情。';

  @override
  String get voiceCloneStartRecord => '点击开始录音';

  @override
  String get voiceCloneStopRecord => '点击停止录音';

  @override
  String get voiceCloneRecordDone => '录音完成';

  @override
  String get voiceCloneNameHint => '请输入音色名称（可选）';

  @override
  String get voiceCloneSubmit => '提交克隆';

  @override
  String get voiceCloneAuthTip =>
      '创建声音需要获取您的人声音频。该敏感信息仅用于当前玩法使用，如不同意授权，可能无法使用音色克隆功能。点击录制代表同意授权。';

  @override
  String get voiceCloneSuccessTitle => '克隆成功';

  @override
  String get voiceCloneSuccessMessage => '您的专属音色已创建成功！';

  @override
  String get voiceCloneFailed => '克隆失败';

  @override
  String get voiceCloneEmptyRecord => '请先录制一段语音';

  @override
  String get voiceCloneTooShortTitle => '录音时间太短';

  @override
  String get voiceCloneTooShortMessage => '请录制至少3秒的语音';

  @override
  String get voiceCloneDefaultName => '我的音色';

  @override
  String get voiceSelectDefaultGroup => '默认音色';

  @override
  String get voiceSelectCustomGroup => '自定义音色';

  @override
  String get voiceSelectEmptyCustom => '暂无自定义音色';

  @override
  String get voiceCustomBadge => '自定义';

  @override
  String get voiceDelete => '删除';

  @override
  String get voiceConfirm => '确定';

  @override
  String get voiceDeleteFailed => '删除失败';

  @override
  String get voiceDefault => '默认';

  @override
  String get voiceXiaoxuMale => '小旭（男）';

  @override
  String get voiceXiaomeiFemale => '小美（女）';

  @override
  String get voiceXiaoxinFemale => '小新（女）';

  @override
  String get voiceXiaoyueFemale => '小月（女）';

  @override
  String get listenFromHere => '从当前听';

  @override
  String get listenSelfSpeaker => '我';

  @override
  String listenSays(String speaker) {
    return '$speaker说：';
  }

  @override
  String listenSentImage(String speaker) {
    return '$speaker发送了图片';
  }

  @override
  String listenSentVideo(String speaker) {
    return '$speaker发送了视频';
  }

  @override
  String listenSentFile(String speaker) {
    return '$speaker发送了文件';
  }

  @override
  String listenSentMerged(String speaker, String title) {
    return '$speaker发送了$title';
  }
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class ChatLocalizationsZhHans extends ChatLocalizationsZh {
  ChatLocalizationsZhHans() : super('zh_Hans');

  @override
  String get voiceTranslate => '翻译';

  @override
  String get voiceCancelTranslation => '取消翻译';

  @override
  String get voiceSwitchLanguage => '切换语言';

  @override
  String get voiceReadAloud => '朗读';

  @override
  String get voiceStopReadAloud => '停止';

  @override
  String get voiceSwitchLanguageSheetTitle => '切换翻译语言';

  @override
  String get voiceTranslateFailed => '翻译失败';

  @override
  String get voiceTtsFailed => '朗读失败';

  @override
  String get voiceMessageSettings => '语音消息设置';

  @override
  String get voiceClone => '音色克隆';

  @override
  String get voiceSelect => '音色选择';

  @override
  String get voiceCloneTip => '请录制一段 10-18 秒的语音，用于克隆您的专属音色';

  @override
  String get voiceCloneReadingTipTitle => '建议朗读以下文字：';

  @override
  String get voiceCloneSampleText =>
      '大家好，我是您的专属语音助手，很高兴为您服务。今天天气真不错，希望您有一个愉快的心情。';

  @override
  String get voiceCloneStartRecord => '点击开始录音';

  @override
  String get voiceCloneStopRecord => '点击停止录音';

  @override
  String get voiceCloneRecordDone => '录音完成';

  @override
  String get voiceCloneNameHint => '请输入音色名称（可选）';

  @override
  String get voiceCloneSubmit => '提交克隆';

  @override
  String get voiceCloneAuthTip =>
      '创建声音需要获取您的人声音频。该敏感信息仅用于当前玩法使用，如不同意授权，可能无法使用音色克隆功能。点击录制代表同意授权。';

  @override
  String get voiceCloneSuccessTitle => '克隆成功';

  @override
  String get voiceCloneSuccessMessage => '您的专属音色已创建成功！';

  @override
  String get voiceCloneFailed => '克隆失败';

  @override
  String get voiceCloneEmptyRecord => '请先录制一段语音';

  @override
  String get voiceCloneTooShortTitle => '录音时间太短';

  @override
  String get voiceCloneTooShortMessage => '请录制至少3秒的语音';

  @override
  String get voiceCloneDefaultName => '我的音色';

  @override
  String get voiceSelectDefaultGroup => '默认音色';

  @override
  String get voiceSelectCustomGroup => '自定义音色';

  @override
  String get voiceSelectEmptyCustom => '暂无自定义音色';

  @override
  String get voiceCustomBadge => '自定义';

  @override
  String get voiceDelete => '删除';

  @override
  String get voiceConfirm => '确定';

  @override
  String get voiceDeleteFailed => '删除失败';

  @override
  String get voiceDefault => '默认';

  @override
  String get voiceXiaoxuMale => '小旭（男）';

  @override
  String get voiceXiaomeiFemale => '小美（女）';

  @override
  String get voiceXiaoxinFemale => '小新（女）';

  @override
  String get voiceXiaoyueFemale => '小月（女）';

  @override
  String get listenFromHere => '从当前听';

  @override
  String get listenSelfSpeaker => '我';

  @override
  String listenSays(String speaker) {
    return '$speaker说：';
  }

  @override
  String listenSentImage(String speaker) {
    return '$speaker发送了图片';
  }

  @override
  String listenSentVideo(String speaker) {
    return '$speaker发送了视频';
  }

  @override
  String listenSentFile(String speaker) {
    return '$speaker发送了文件';
  }

  @override
  String listenSentMerged(String speaker, String title) {
    return '$speaker发送了$title';
  }
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class ChatLocalizationsZhHant extends ChatLocalizationsZh {
  ChatLocalizationsZhHant() : super('zh_Hant');

  @override
  String get voiceTranslate => '翻譯';

  @override
  String get voiceCancelTranslation => '取消翻譯';

  @override
  String get voiceSwitchLanguage => '切換語言';

  @override
  String get voiceReadAloud => '朗讀';

  @override
  String get voiceStopReadAloud => '停止';

  @override
  String get voiceSwitchLanguageSheetTitle => '切換翻譯語言';

  @override
  String get voiceTranslateFailed => '翻譯失敗';

  @override
  String get voiceTtsFailed => '朗讀失敗';

  @override
  String get voiceMessageSettings => '語音訊息設定';

  @override
  String get voiceClone => '音色複製';

  @override
  String get voiceSelect => '音色選擇';

  @override
  String get voiceCloneTip => '請錄製一段 10-18 秒的語音，用於複製您的專屬音色';

  @override
  String get voiceCloneReadingTipTitle => '建議朗讀以下文字：';

  @override
  String get voiceCloneSampleText =>
      '大家好，我是您的專屬語音助手，很高興為您服務。今天天氣真不錯，希望您有一個愉快的心情。';

  @override
  String get voiceCloneStartRecord => '點擊開始錄音';

  @override
  String get voiceCloneStopRecord => '點擊停止錄音';

  @override
  String get voiceCloneRecordDone => '錄音完成';

  @override
  String get voiceCloneNameHint => '請輸入音色名稱（可選）';

  @override
  String get voiceCloneSubmit => '提交複製';

  @override
  String get voiceCloneAuthTip =>
      '建立聲音需要取得您的人聲音訊。該敏感資訊僅用於目前玩法使用，如不同意授權，可能無法使用音色複製功能。點擊錄製代表同意授權。';

  @override
  String get voiceCloneSuccessTitle => '複製成功';

  @override
  String get voiceCloneSuccessMessage => '您的專屬音色已建立成功！';

  @override
  String get voiceCloneFailed => '音色複製失敗';

  @override
  String get voiceCloneEmptyRecord => '請先錄製一段語音';

  @override
  String get voiceCloneTooShortTitle => '錄音時間太短';

  @override
  String get voiceCloneTooShortMessage => '請錄製至少3秒的語音';

  @override
  String get voiceCloneDefaultName => '我的音色';

  @override
  String get voiceSelectDefaultGroup => '預設音色';

  @override
  String get voiceSelectCustomGroup => '自訂音色';

  @override
  String get voiceSelectEmptyCustom => '暫無自訂音色';

  @override
  String get voiceCustomBadge => '自訂';

  @override
  String get voiceDelete => '刪除';

  @override
  String get voiceConfirm => '確定';

  @override
  String get voiceDeleteFailed => '刪除失敗';

  @override
  String get voiceDefault => '預設';

  @override
  String get voiceXiaoxuMale => '小旭（男）';

  @override
  String get voiceXiaomeiFemale => '小美（女）';

  @override
  String get voiceXiaoxinFemale => '小新（女）';

  @override
  String get voiceXiaoyueFemale => '小月（女）';

  @override
  String get listenFromHere => '從目前聽';

  @override
  String get listenSelfSpeaker => '我';

  @override
  String listenSays(String speaker) {
    return '$speaker說：';
  }

  @override
  String listenSentImage(String speaker) {
    return '$speaker傳送了圖片';
  }

  @override
  String listenSentVideo(String speaker) {
    return '$speaker傳送了影片';
  }

  @override
  String listenSentFile(String speaker) {
    return '$speaker傳送了檔案';
  }

  @override
  String listenSentMerged(String speaker, String title) {
    return '$speaker傳送了$title';
  }
}
