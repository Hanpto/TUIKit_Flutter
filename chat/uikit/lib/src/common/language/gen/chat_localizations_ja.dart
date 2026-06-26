// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'chat_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class ChatLocalizationsJa extends ChatLocalizations {
  ChatLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get voiceTranslate => '翻訳';

  @override
  String get voiceCancelTranslation => '翻訳を取り消す';

  @override
  String get voiceSwitchLanguage => '言語を切り替え';

  @override
  String get voiceReadAloud => '読み上げ';

  @override
  String get voiceStopReadAloud => '停止';

  @override
  String get voiceSwitchLanguageSheetTitle => '翻訳言語を切り替え';

  @override
  String get voiceTranslateFailed => '翻訳に失敗しました';

  @override
  String get voiceTtsFailed => '再生に失敗しました';

  @override
  String get voiceMessageSettings => '音声メッセージ設定';

  @override
  String get voiceClone => '声のクローン';

  @override
  String get voiceSelect => '声の選択';

  @override
  String get voiceCloneTip => 'あなた専用の声をクローンするために、10〜18秒の音声を録音してください';

  @override
  String get voiceCloneReadingTipTitle => '以下の文章を読み上げることをおすすめします：';

  @override
  String get voiceCloneSampleText =>
      '皆さんこんにちは、私はあなた専用の音声アシスタントです。お役に立てて嬉しいです。今日はとても良い天気ですね。楽しい気分で過ごせますように。';

  @override
  String get voiceCloneStartRecord => 'タップして録音開始';

  @override
  String get voiceCloneStopRecord => 'タップして録音停止';

  @override
  String get voiceCloneRecordDone => '録音完了';

  @override
  String get voiceCloneNameHint => '声の名前を入力（任意）';

  @override
  String get voiceCloneSubmit => 'クローンを送信';

  @override
  String get voiceCloneAuthTip =>
      '声を作成するには、あなたの音声を取得する必要があります。この機密情報は本機能でのみ使用されます。許可に同意しない場合、声のクローン機能を使用できないことがあります。録音は許可への同意を意味します。';

  @override
  String get voiceCloneSuccessTitle => 'クローン成功';

  @override
  String get voiceCloneSuccessMessage => 'あなた専用の声が作成されました！';

  @override
  String get voiceCloneFailed => '声のクローンに失敗しました';

  @override
  String get voiceCloneEmptyRecord => '先に音声を録音してください';

  @override
  String get voiceCloneTooShortTitle => '録音時間が短すぎます';

  @override
  String get voiceCloneTooShortMessage => '3秒以上録音してください';

  @override
  String get voiceCloneDefaultName => 'マイボイス';

  @override
  String get voiceSelectDefaultGroup => 'デフォルトの声';

  @override
  String get voiceSelectCustomGroup => 'カスタムの声';

  @override
  String get voiceSelectEmptyCustom => 'カスタムの声はまだありません';

  @override
  String get voiceCustomBadge => 'カスタム';

  @override
  String get voiceDelete => '削除';

  @override
  String get voiceConfirm => 'OK';

  @override
  String get voiceDeleteFailed => '削除に失敗しました';

  @override
  String get voiceDefault => 'デフォルト';

  @override
  String get voiceXiaoxuMale => 'シャオシュー（男性）';

  @override
  String get voiceXiaomeiFemale => 'シャオメイ（女性）';

  @override
  String get voiceXiaoxinFemale => 'シャオシン（女性）';

  @override
  String get voiceXiaoyueFemale => 'シャオユエ（女性）';

  @override
  String get listenFromHere => 'ここから聴く';

  @override
  String get listenSelfSpeaker => '私';

  @override
  String listenSays(String speaker) {
    return '$speakerさんが言いました：';
  }

  @override
  String listenSentImage(String speaker) {
    return '$speakerさんが画像を送信しました';
  }

  @override
  String listenSentVideo(String speaker) {
    return '$speakerさんが動画を送信しました';
  }

  @override
  String listenSentFile(String speaker) {
    return '$speakerさんがファイルを送信しました';
  }

  @override
  String listenSentMerged(String speaker, String title) {
    return '$speakerさんが送信しました：$title';
  }
}
