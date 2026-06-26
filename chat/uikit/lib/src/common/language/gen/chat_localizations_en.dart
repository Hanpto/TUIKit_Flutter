// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'chat_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ChatLocalizationsEn extends ChatLocalizations {
  ChatLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get voiceTranslate => 'Translate';

  @override
  String get voiceCancelTranslation => 'Undo Translation';

  @override
  String get voiceSwitchLanguage => 'Switch Language';

  @override
  String get voiceReadAloud => 'Read Aloud';

  @override
  String get voiceStopReadAloud => 'Stop';

  @override
  String get voiceSwitchLanguageSheetTitle => 'Switch Translation Language';

  @override
  String get voiceTranslateFailed => 'Translation failed';

  @override
  String get voiceTtsFailed => 'Playback failed';

  @override
  String get voiceMessageSettings => 'Voice Message Settings';

  @override
  String get voiceClone => 'Voice Clone';

  @override
  String get voiceSelect => 'Voice Selection';

  @override
  String get voiceCloneTip =>
      'Record a 10-18 second voice clip to clone your exclusive voice.';

  @override
  String get voiceCloneReadingTipTitle => 'Suggested text to read:';

  @override
  String get voiceCloneSampleText =>
      'Hello everyone, I am your exclusive voice assistant, glad to be at your service. The weather is really nice today, hope you have a pleasant mood.';

  @override
  String get voiceCloneStartRecord => 'Tap to start recording';

  @override
  String get voiceCloneStopRecord => 'Tap to stop recording';

  @override
  String get voiceCloneRecordDone => 'Recording complete';

  @override
  String get voiceCloneNameHint => 'Enter a voice name (optional)';

  @override
  String get voiceCloneSubmit => 'Submit Clone';

  @override
  String get voiceCloneAuthTip =>
      'Creating a voice requires capturing your human voice audio. This sensitive information is only used for the current feature. If you do not agree to the authorization, you may not be able to use voice cloning. Recording implies consent to the authorization.';

  @override
  String get voiceCloneSuccessTitle => 'Clone Succeeded';

  @override
  String get voiceCloneSuccessMessage =>
      'Your exclusive voice has been created successfully!';

  @override
  String get voiceCloneFailed => 'Voice clone failed';

  @override
  String get voiceCloneEmptyRecord => 'Please record a voice clip first';

  @override
  String get voiceCloneTooShortTitle => 'Recording too short';

  @override
  String get voiceCloneTooShortMessage => 'Please record at least 3 seconds';

  @override
  String get voiceCloneDefaultName => 'My Voice';

  @override
  String get voiceSelectDefaultGroup => 'Default Voices';

  @override
  String get voiceSelectCustomGroup => 'Custom Voices';

  @override
  String get voiceSelectEmptyCustom => 'No custom voices yet';

  @override
  String get voiceCustomBadge => 'Custom';

  @override
  String get voiceDelete => 'Delete';

  @override
  String get voiceConfirm => 'OK';

  @override
  String get voiceDeleteFailed => 'Delete failed';

  @override
  String get voiceDefault => 'Default';

  @override
  String get voiceXiaoxuMale => 'Xiaoxu (Male)';

  @override
  String get voiceXiaomeiFemale => 'Xiaomei (Female)';

  @override
  String get voiceXiaoxinFemale => 'Xiaoxin (Female)';

  @override
  String get voiceXiaoyueFemale => 'Xiaoyue (Female)';

  @override
  String get listenFromHere => 'Listen From Here';

  @override
  String get listenSelfSpeaker => 'I';

  @override
  String listenSays(String speaker) {
    return '$speaker said: ';
  }

  @override
  String listenSentImage(String speaker) {
    return '$speaker sent an image';
  }

  @override
  String listenSentVideo(String speaker) {
    return '$speaker sent a video';
  }

  @override
  String listenSentFile(String speaker) {
    return '$speaker sent a file';
  }

  @override
  String listenSentMerged(String speaker, String title) {
    return '$speaker sent: $title';
  }
}
