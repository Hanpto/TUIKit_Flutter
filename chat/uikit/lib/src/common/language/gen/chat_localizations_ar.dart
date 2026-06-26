// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'chat_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class ChatLocalizationsAr extends ChatLocalizations {
  ChatLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get voiceTranslate => 'ترجمة';

  @override
  String get voiceCancelTranslation => 'إلغاء الترجمة';

  @override
  String get voiceSwitchLanguage => 'تبديل اللغة';

  @override
  String get voiceReadAloud => 'قراءة بصوت عالٍ';

  @override
  String get voiceStopReadAloud => 'إيقاف';

  @override
  String get voiceSwitchLanguageSheetTitle => 'تبديل لغة الترجمة';

  @override
  String get voiceTranslateFailed => 'فشلت الترجمة';

  @override
  String get voiceTtsFailed => 'فشل التشغيل';

  @override
  String get voiceMessageSettings => 'إعدادات الرسائل الصوتية';

  @override
  String get voiceClone => 'استنساخ الصوت';

  @override
  String get voiceSelect => 'اختيار الصوت';

  @override
  String get voiceCloneTip =>
      'سجّل مقطعًا صوتيًا مدته 10-18 ثانية لاستنساخ صوتك الخاص';

  @override
  String get voiceCloneReadingTipTitle => 'يُنصح بقراءة النص التالي:';

  @override
  String get voiceCloneSampleText =>
      'مرحبًا بالجميع، أنا مساعدك الصوتي الخاص، يسعدني خدمتك. الطقس جميل حقًا اليوم، أتمنى أن تكون في مزاج رائع.';

  @override
  String get voiceCloneStartRecord => 'اضغط لبدء التسجيل';

  @override
  String get voiceCloneStopRecord => 'اضغط لإيقاف التسجيل';

  @override
  String get voiceCloneRecordDone => 'اكتمل التسجيل';

  @override
  String get voiceCloneNameHint => 'أدخل اسم الصوت (اختياري)';

  @override
  String get voiceCloneSubmit => 'إرسال الاستنساخ';

  @override
  String get voiceCloneAuthTip =>
      'يتطلب إنشاء صوت الحصول على تسجيل صوتك. تُستخدم هذه المعلومات الحساسة فقط لهذه الميزة. إذا لم توافق على التفويض، فقد لا تتمكن من استخدام استنساخ الصوت. التسجيل يعني الموافقة على التفويض.';

  @override
  String get voiceCloneSuccessTitle => 'نجح الاستنساخ';

  @override
  String get voiceCloneSuccessMessage => 'تم إنشاء صوتك الخاص بنجاح!';

  @override
  String get voiceCloneFailed => 'فشل استنساخ الصوت';

  @override
  String get voiceCloneEmptyRecord => 'يرجى تسجيل مقطع صوتي أولاً';

  @override
  String get voiceCloneTooShortTitle => 'التسجيل قصير جدًا';

  @override
  String get voiceCloneTooShortMessage => 'يرجى التسجيل لمدة 3 ثوانٍ على الأقل';

  @override
  String get voiceCloneDefaultName => 'صوتي';

  @override
  String get voiceSelectDefaultGroup => 'الأصوات الافتراضية';

  @override
  String get voiceSelectCustomGroup => 'الأصوات المخصصة';

  @override
  String get voiceSelectEmptyCustom => 'لا توجد أصوات مخصصة بعد';

  @override
  String get voiceCustomBadge => 'مخصص';

  @override
  String get voiceDelete => 'حذف';

  @override
  String get voiceConfirm => 'موافق';

  @override
  String get voiceDeleteFailed => 'فشل الحذف';

  @override
  String get voiceDefault => 'افتراضي';

  @override
  String get voiceXiaoxuMale => 'شياوشو (ذكر)';

  @override
  String get voiceXiaomeiFemale => 'شياومي (أنثى)';

  @override
  String get voiceXiaoxinFemale => 'شياوشين (أنثى)';

  @override
  String get voiceXiaoyueFemale => 'شياويوي (أنثى)';

  @override
  String get listenFromHere => 'استمع من هنا';

  @override
  String get listenSelfSpeaker => 'أنا';

  @override
  String listenSays(String speaker) {
    return '$speaker قال: ';
  }

  @override
  String listenSentImage(String speaker) {
    return '$speaker أرسل صورة';
  }

  @override
  String listenSentVideo(String speaker) {
    return '$speaker أرسل فيديو';
  }

  @override
  String listenSentFile(String speaker) {
    return '$speaker أرسل ملفًا';
  }

  @override
  String listenSentMerged(String speaker, String title) {
    return '$speaker أرسل: $title';
  }
}
