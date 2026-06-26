import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'chat_localizations_ar.dart';
import 'chat_localizations_en.dart';
import 'chat_localizations_ja.dart';
import 'chat_localizations_ko.dart';
import 'chat_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ChatLocalizations
/// returned by `ChatLocalizations.of(context)`.
///
/// Applications need to include `ChatLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/chat_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ChatLocalizations.localizationsDelegates,
///   supportedLocales: ChatLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ChatLocalizations.supportedLocales
/// property.
abstract class ChatLocalizations {
  ChatLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ChatLocalizations? of(BuildContext context) {
    return Localizations.of<ChatLocalizations>(context, ChatLocalizations);
  }

  static const LocalizationsDelegate<ChatLocalizations> delegate =
      _ChatLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('ja'),
    Locale('ko'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant')
  ];

  /// No description provided for @voiceTranslate.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get voiceTranslate;

  /// No description provided for @voiceCancelTranslation.
  ///
  /// In en, this message translates to:
  /// **'Undo Translation'**
  String get voiceCancelTranslation;

  /// No description provided for @voiceSwitchLanguage.
  ///
  /// In en, this message translates to:
  /// **'Switch Language'**
  String get voiceSwitchLanguage;

  /// No description provided for @voiceReadAloud.
  ///
  /// In en, this message translates to:
  /// **'Read Aloud'**
  String get voiceReadAloud;

  /// No description provided for @voiceStopReadAloud.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get voiceStopReadAloud;

  /// No description provided for @voiceSwitchLanguageSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Switch Translation Language'**
  String get voiceSwitchLanguageSheetTitle;

  /// No description provided for @voiceTranslateFailed.
  ///
  /// In en, this message translates to:
  /// **'Translation failed'**
  String get voiceTranslateFailed;

  /// No description provided for @voiceTtsFailed.
  ///
  /// In en, this message translates to:
  /// **'Playback failed'**
  String get voiceTtsFailed;

  /// No description provided for @voiceMessageSettings.
  ///
  /// In en, this message translates to:
  /// **'Voice Message Settings'**
  String get voiceMessageSettings;

  /// No description provided for @voiceClone.
  ///
  /// In en, this message translates to:
  /// **'Voice Clone'**
  String get voiceClone;

  /// No description provided for @voiceSelect.
  ///
  /// In en, this message translates to:
  /// **'Voice Selection'**
  String get voiceSelect;

  /// No description provided for @voiceCloneTip.
  ///
  /// In en, this message translates to:
  /// **'Record a 10-18 second voice clip to clone your exclusive voice.'**
  String get voiceCloneTip;

  /// No description provided for @voiceCloneReadingTipTitle.
  ///
  /// In en, this message translates to:
  /// **'Suggested text to read:'**
  String get voiceCloneReadingTipTitle;

  /// No description provided for @voiceCloneSampleText.
  ///
  /// In en, this message translates to:
  /// **'Hello everyone, I am your exclusive voice assistant, glad to be at your service. The weather is really nice today, hope you have a pleasant mood.'**
  String get voiceCloneSampleText;

  /// No description provided for @voiceCloneStartRecord.
  ///
  /// In en, this message translates to:
  /// **'Tap to start recording'**
  String get voiceCloneStartRecord;

  /// No description provided for @voiceCloneStopRecord.
  ///
  /// In en, this message translates to:
  /// **'Tap to stop recording'**
  String get voiceCloneStopRecord;

  /// No description provided for @voiceCloneRecordDone.
  ///
  /// In en, this message translates to:
  /// **'Recording complete'**
  String get voiceCloneRecordDone;

  /// No description provided for @voiceCloneNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a voice name (optional)'**
  String get voiceCloneNameHint;

  /// No description provided for @voiceCloneSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit Clone'**
  String get voiceCloneSubmit;

  /// No description provided for @voiceCloneAuthTip.
  ///
  /// In en, this message translates to:
  /// **'Creating a voice requires capturing your human voice audio. This sensitive information is only used for the current feature. If you do not agree to the authorization, you may not be able to use voice cloning. Recording implies consent to the authorization.'**
  String get voiceCloneAuthTip;

  /// No description provided for @voiceCloneSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Clone Succeeded'**
  String get voiceCloneSuccessTitle;

  /// No description provided for @voiceCloneSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your exclusive voice has been created successfully!'**
  String get voiceCloneSuccessMessage;

  /// No description provided for @voiceCloneFailed.
  ///
  /// In en, this message translates to:
  /// **'Voice clone failed'**
  String get voiceCloneFailed;

  /// No description provided for @voiceCloneEmptyRecord.
  ///
  /// In en, this message translates to:
  /// **'Please record a voice clip first'**
  String get voiceCloneEmptyRecord;

  /// No description provided for @voiceCloneTooShortTitle.
  ///
  /// In en, this message translates to:
  /// **'Recording too short'**
  String get voiceCloneTooShortTitle;

  /// No description provided for @voiceCloneTooShortMessage.
  ///
  /// In en, this message translates to:
  /// **'Please record at least 3 seconds'**
  String get voiceCloneTooShortMessage;

  /// No description provided for @voiceCloneDefaultName.
  ///
  /// In en, this message translates to:
  /// **'My Voice'**
  String get voiceCloneDefaultName;

  /// No description provided for @voiceSelectDefaultGroup.
  ///
  /// In en, this message translates to:
  /// **'Default Voices'**
  String get voiceSelectDefaultGroup;

  /// No description provided for @voiceSelectCustomGroup.
  ///
  /// In en, this message translates to:
  /// **'Custom Voices'**
  String get voiceSelectCustomGroup;

  /// No description provided for @voiceSelectEmptyCustom.
  ///
  /// In en, this message translates to:
  /// **'No custom voices yet'**
  String get voiceSelectEmptyCustom;

  /// No description provided for @voiceCustomBadge.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get voiceCustomBadge;

  /// No description provided for @voiceDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get voiceDelete;

  /// No description provided for @voiceConfirm.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get voiceConfirm;

  /// No description provided for @voiceDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Delete failed'**
  String get voiceDeleteFailed;

  /// No description provided for @voiceDefault.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get voiceDefault;

  /// No description provided for @voiceXiaoxuMale.
  ///
  /// In en, this message translates to:
  /// **'Xiaoxu (Male)'**
  String get voiceXiaoxuMale;

  /// No description provided for @voiceXiaomeiFemale.
  ///
  /// In en, this message translates to:
  /// **'Xiaomei (Female)'**
  String get voiceXiaomeiFemale;

  /// No description provided for @voiceXiaoxinFemale.
  ///
  /// In en, this message translates to:
  /// **'Xiaoxin (Female)'**
  String get voiceXiaoxinFemale;

  /// No description provided for @voiceXiaoyueFemale.
  ///
  /// In en, this message translates to:
  /// **'Xiaoyue (Female)'**
  String get voiceXiaoyueFemale;

  /// No description provided for @listenFromHere.
  ///
  /// In en, this message translates to:
  /// **'Listen From Here'**
  String get listenFromHere;

  /// No description provided for @listenSelfSpeaker.
  ///
  /// In en, this message translates to:
  /// **'I'**
  String get listenSelfSpeaker;

  /// No description provided for @listenSays.
  ///
  /// In en, this message translates to:
  /// **'{speaker} said: '**
  String listenSays(String speaker);

  /// No description provided for @listenSentImage.
  ///
  /// In en, this message translates to:
  /// **'{speaker} sent an image'**
  String listenSentImage(String speaker);

  /// No description provided for @listenSentVideo.
  ///
  /// In en, this message translates to:
  /// **'{speaker} sent a video'**
  String listenSentVideo(String speaker);

  /// No description provided for @listenSentFile.
  ///
  /// In en, this message translates to:
  /// **'{speaker} sent a file'**
  String listenSentFile(String speaker);

  /// No description provided for @listenSentMerged.
  ///
  /// In en, this message translates to:
  /// **'{speaker} sent: {title}'**
  String listenSentMerged(String speaker, String title);
}

class _ChatLocalizationsDelegate
    extends LocalizationsDelegate<ChatLocalizations> {
  const _ChatLocalizationsDelegate();

  @override
  Future<ChatLocalizations> load(Locale locale) {
    return SynchronousFuture<ChatLocalizations>(
        lookupChatLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'ja', 'ko', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_ChatLocalizationsDelegate old) => false;
}

ChatLocalizations lookupChatLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hans':
            return ChatLocalizationsZhHans();
          case 'Hant':
            return ChatLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return ChatLocalizationsAr();
    case 'en':
      return ChatLocalizationsEn();
    case 'ja':
      return ChatLocalizationsJa();
    case 'ko':
      return ChatLocalizationsKo();
    case 'zh':
      return ChatLocalizationsZh();
  }

  throw FlutterError(
      'ChatLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
