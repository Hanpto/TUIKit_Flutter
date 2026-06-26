// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'chat_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class ChatLocalizationsKo extends ChatLocalizations {
  ChatLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get voiceTranslate => '번역';

  @override
  String get voiceCancelTranslation => '번역 취소';

  @override
  String get voiceSwitchLanguage => '언어 전환';

  @override
  String get voiceReadAloud => '읽어주기';

  @override
  String get voiceStopReadAloud => '정지';

  @override
  String get voiceSwitchLanguageSheetTitle => '번역 언어 전환';

  @override
  String get voiceTranslateFailed => '번역에 실패했습니다';

  @override
  String get voiceTtsFailed => '재생에 실패했습니다';

  @override
  String get voiceMessageSettings => '음성 메시지 설정';

  @override
  String get voiceClone => '음색 복제';

  @override
  String get voiceSelect => '음색 선택';

  @override
  String get voiceCloneTip => '전용 음색을 복제하기 위해 10~18초 분량의 음성을 녹음하세요';

  @override
  String get voiceCloneReadingTipTitle => '다음 문장을 읽는 것을 권장합니다:';

  @override
  String get voiceCloneSampleText =>
      '안녕하세요, 저는 여러분의 전용 음성 비서입니다. 도움을 드리게 되어 기쁩니다. 오늘 날씨가 정말 좋네요. 즐거운 하루 보내시길 바랍니다.';

  @override
  String get voiceCloneStartRecord => '탭하여 녹음 시작';

  @override
  String get voiceCloneStopRecord => '탭하여 녹음 정지';

  @override
  String get voiceCloneRecordDone => '녹음 완료';

  @override
  String get voiceCloneNameHint => '음색 이름 입력 (선택 사항)';

  @override
  String get voiceCloneSubmit => '복제 제출';

  @override
  String get voiceCloneAuthTip =>
      '음성을 생성하려면 사용자의 음성 오디오를 수집해야 합니다. 이 민감한 정보는 현재 기능에만 사용됩니다. 권한에 동의하지 않으면 음색 복제 기능을 사용할 수 없습니다. 녹음은 권한 동의를 의미합니다.';

  @override
  String get voiceCloneSuccessTitle => '복제 성공';

  @override
  String get voiceCloneSuccessMessage => '전용 음색이 성공적으로 생성되었습니다!';

  @override
  String get voiceCloneFailed => '음색 복제에 실패했습니다';

  @override
  String get voiceCloneEmptyRecord => '먼저 음성을 녹음하세요';

  @override
  String get voiceCloneTooShortTitle => '녹음 시간이 너무 짧습니다';

  @override
  String get voiceCloneTooShortMessage => '3초 이상 녹음하세요';

  @override
  String get voiceCloneDefaultName => '내 음색';

  @override
  String get voiceSelectDefaultGroup => '기본 음색';

  @override
  String get voiceSelectCustomGroup => '사용자 지정 음색';

  @override
  String get voiceSelectEmptyCustom => '사용자 지정 음색이 없습니다';

  @override
  String get voiceCustomBadge => '사용자 지정';

  @override
  String get voiceDelete => '삭제';

  @override
  String get voiceConfirm => '확인';

  @override
  String get voiceDeleteFailed => '삭제에 실패했습니다';

  @override
  String get voiceDefault => '기본';

  @override
  String get voiceXiaoxuMale => '샤오쉬 (남)';

  @override
  String get voiceXiaomeiFemale => '샤오메이 (여)';

  @override
  String get voiceXiaoxinFemale => '샤오신 (여)';

  @override
  String get voiceXiaoyueFemale => '샤오위에 (여)';

  @override
  String get listenFromHere => '여기부터 듣기';

  @override
  String get listenSelfSpeaker => '나';

  @override
  String listenSays(String speaker) {
    return '$speaker님이 말했습니다: ';
  }

  @override
  String listenSentImage(String speaker) {
    return '$speaker님이 이미지를 보냈습니다';
  }

  @override
  String listenSentVideo(String speaker) {
    return '$speaker님이 동영상을 보냈습니다';
  }

  @override
  String listenSentFile(String speaker) {
    return '$speaker님이 파일을 보냈습니다';
  }

  @override
  String listenSentMerged(String speaker, String title) {
    return '$speaker님이 보냈습니다: $title';
  }
}
