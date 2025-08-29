import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localization_de.dart';
import 'app_localization_en.dart';
import 'app_localization_es.dart';
import 'app_localization_fr.dart';
import 'app_localization_it.dart';
import 'app_localization_nl.dart';
import 'app_localization_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('nl'),
    Locale('zh')
  ];

  /// No description provided for @app_presentation_welcome_page_title.
  ///
  /// In zh, this message translates to:
  /// **'欢迎'**
  String get app_presentation_welcome_page_title;

  /// No description provided for @app_presentation_welcome_page_section_1_title.
  ///
  /// In zh, this message translates to:
  /// **'开启难忘的旅程'**
  String get app_presentation_welcome_page_section_1_title;

  /// No description provided for @app_presentation_welcome_page_section_1_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'体验为您和伴侣精心设计的一系列独特冒险。'**
  String get app_presentation_welcome_page_section_1_subtitle;

  /// No description provided for @app_presentation_welcome_page_section_2_title.
  ///
  /// In zh, this message translates to:
  /// **'适合每一对情侣'**
  String get app_presentation_welcome_page_section_2_title;

  /// No description provided for @app_presentation_welcome_page_section_2_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'无论你们在一起多久，都能加深联系并发现新的亲密形式。'**
  String get app_presentation_welcome_page_section_2_subtitle;

  /// No description provided for @app_presentation_welcome_page_section_3_title.
  ///
  /// In zh, this message translates to:
  /// **'精选内容的世界'**
  String get app_presentation_welcome_page_section_3_title;

  /// No description provided for @app_presentation_welcome_page_section_3_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'探索丰富的即用型内容库，满足各种需求和偏好。'**
  String get app_presentation_welcome_page_section_3_subtitle;

  /// No description provided for @app_presentation_game_modes_page_title.
  ///
  /// In zh, this message translates to:
  /// **'按你的方式游戏'**
  String get app_presentation_game_modes_page_title;

  /// No description provided for @app_presentation_game_modes_page_section_1_title.
  ///
  /// In zh, this message translates to:
  /// **'享受美好时光'**
  String get app_presentation_game_modes_page_section_1_title;

  /// No description provided for @app_presentation_game_modes_page_section_1_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'无论是本地还是在线，总有乐趣可以与伴侣分享。'**
  String get app_presentation_game_modes_page_section_1_subtitle;

  /// No description provided for @app_presentation_game_modes_page_section_2_title.
  ///
  /// In zh, this message translates to:
  /// **'包容每个人'**
  String get app_presentation_game_modes_page_section_2_title;

  /// No description provided for @app_presentation_game_modes_page_section_2_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'无论你是谁，我们的游戏都是为通用乐趣而精心制作的。'**
  String get app_presentation_game_modes_page_section_2_subtitle;

  /// No description provided for @app_presentation_game_modes_page_section_3_title.
  ///
  /// In zh, this message translates to:
  /// **'你掌握控制权'**
  String get app_presentation_game_modes_page_section_3_title;

  /// No description provided for @app_presentation_game_modes_page_section_3_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'设定你的节奏，跳过任何你希望的任务——舒适和同意永远是第一位的。'**
  String get app_presentation_game_modes_page_section_3_subtitle;

  /// No description provided for @app_presentation_customization_page_title.
  ///
  /// In zh, this message translates to:
  /// **'独特，就像你一样'**
  String get app_presentation_customization_page_title;

  /// No description provided for @app_presentation_customization_page_section_1_title.
  ///
  /// In zh, this message translates to:
  /// **'创造你的冒险'**
  String get app_presentation_customization_page_section_1_title;

  /// No description provided for @app_presentation_customization_page_section_1_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'用反映你们个性的定制体验取悦伴侣。'**
  String get app_presentation_customization_page_section_1_subtitle;

  /// No description provided for @app_presentation_customization_page_section_2_title.
  ///
  /// In zh, this message translates to:
  /// **'广泛的道具兼容性'**
  String get app_presentation_customization_page_section_2_title;

  /// No description provided for @app_presentation_customization_page_section_2_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'享受对各种道具和活动的无缝支持。'**
  String get app_presentation_customization_page_section_2_subtitle;

  /// No description provided for @app_presentation_customization_page_section_3_title.
  ///
  /// In zh, this message translates to:
  /// **'用户友好的编辑器'**
  String get app_presentation_customization_page_section_3_title;

  /// No description provided for @app_presentation_customization_page_section_3_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'使用我们的编辑器设计你的专属体验既流畅又直观。'**
  String get app_presentation_customization_page_section_3_subtitle;

  /// No description provided for @app_presentation_privacy_page_title.
  ///
  /// In zh, this message translates to:
  /// **'隐私第一'**
  String get app_presentation_privacy_page_title;

  /// No description provided for @app_presentation_privacy_page_section_1_title.
  ///
  /// In zh, this message translates to:
  /// **'绝不追踪'**
  String get app_presentation_privacy_page_section_1_title;

  /// No description provided for @app_presentation_privacy_page_section_1_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'你的个人数据属于你——永远不会被收集或共享，甚至与我们。'**
  String get app_presentation_privacy_page_section_1_subtitle;

  /// No description provided for @app_presentation_privacy_page_section_2_title.
  ///
  /// In zh, this message translates to:
  /// **'无外部连接'**
  String get app_presentation_privacy_page_section_2_title;

  /// No description provided for @app_presentation_privacy_page_section_2_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'该应用程序从不连接到外部服务器，现在或将来都不会。'**
  String get app_presentation_privacy_page_section_2_subtitle;

  /// No description provided for @app_presentation_privacy_page_section_3_title.
  ///
  /// In zh, this message translates to:
  /// **'开源且透明'**
  String get app_presentation_privacy_page_section_3_title;

  /// No description provided for @app_presentation_privacy_page_section_3_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'我们的源代码在GitHub上公开——开放和透明高于一切。'**
  String get app_presentation_privacy_page_section_3_subtitle;

  /// No description provided for @app_presentation_web_app_page_title.
  ///
  /// In zh, this message translates to:
  /// **'试用网页应用'**
  String get app_presentation_web_app_page_title;

  /// No description provided for @app_presentation_web_app_page_section_1_title.
  ///
  /// In zh, this message translates to:
  /// **'在任何地方都可访问'**
  String get app_presentation_web_app_page_section_1_title;

  /// No description provided for @app_presentation_web_app_page_section_1_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'在iOS、Android或桌面上使用网页版本——无需安装。'**
  String get app_presentation_web_app_page_section_1_subtitle;

  /// No description provided for @app_presentation_web_app_page_section_2_title.
  ///
  /// In zh, this message translates to:
  /// **'云端隐私'**
  String get app_presentation_web_app_page_section_2_title;

  /// No description provided for @app_presentation_web_app_page_section_2_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'你的数据始终停留在你的浏览器中——从不上传或被追踪。'**
  String get app_presentation_web_app_page_section_2_subtitle;

  /// No description provided for @app_presentation_web_app_page_section_3_title.
  ///
  /// In zh, this message translates to:
  /// **'如何访问'**
  String get app_presentation_web_app_page_section_3_title;

  /// No description provided for @app_presentation_web_app_page_section_3_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'在应用设置中找到网页应用链接和详细信息。'**
  String get app_presentation_web_app_page_section_3_subtitle;

  /// No description provided for @app_presentation_donation_page_title.
  ///
  /// In zh, this message translates to:
  /// **'支持我们的使命'**
  String get app_presentation_donation_page_title;

  /// No description provided for @app_presentation_donation_page_section_1_title.
  ///
  /// In zh, this message translates to:
  /// **'永远免费使用'**
  String get app_presentation_donation_page_section_1_title;

  /// No description provided for @app_presentation_donation_page_section_1_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'您的帮助使这个项目对所有人都永远可访问。'**
  String get app_presentation_donation_page_section_1_subtitle;

  /// No description provided for @app_presentation_donation_page_section_2_title.
  ///
  /// In zh, this message translates to:
  /// **'永不放广告'**
  String get app_presentation_donation_page_section_2_title;

  /// No description provided for @app_presentation_donation_page_section_2_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'你永远不会看到广告——你的支持让我们能够保持这样。'**
  String get app_presentation_donation_page_section_2_subtitle;

  /// No description provided for @app_presentation_donation_page_section_3_title.
  ///
  /// In zh, this message translates to:
  /// **'透明且私密'**
  String get app_presentation_donation_page_section_3_title;

  /// No description provided for @app_presentation_donation_page_section_3_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'如果你相信隐私和开源为全人所享，请支持我们。'**
  String get app_presentation_donation_page_section_3_subtitle;

  /// No description provided for @navbar_play_button_label.
  ///
  /// In zh, this message translates to:
  /// **'开始游戏'**
  String get navbar_play_button_label;

  /// No description provided for @navbar_decks_button_label.
  ///
  /// In zh, this message translates to:
  /// **'卡牌组'**
  String get navbar_decks_button_label;

  /// No description provided for @navbar_settings_button_label.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get navbar_settings_button_label;

  /// No description provided for @online_play_disclaimer_dialog_title.
  ///
  /// In zh, this message translates to:
  /// **'警告！'**
  String get online_play_disclaimer_dialog_title;

  /// No description provided for @online_play_disclaimer_dialog_content.
  ///
  /// In zh, this message translates to:
  /// **'小心在线分享亲密内容\n\n安全第一。记住，在互联网上分享的任何内容都可能永远留在网上，无法完全清除。避免包含个人数据，并确保你游戏的人是值得信赖的，在发送任何亲密材料之前。\n\nLoverquest不为在线进行的任何非法活动承担责任，如未经同意分发亲密材料、分享儿童剥削内容或其他违法行为。\n'**
  String get online_play_disclaimer_dialog_content;

  /// No description provided for @online_play_disclaimer_dialog_close_button_label.
  ///
  /// In zh, this message translates to:
  /// **'我明白了'**
  String get online_play_disclaimer_dialog_close_button_label;

  /// No description provided for @donation_reminder_page_donate_button_label.
  ///
  /// In zh, this message translates to:
  /// **'支持我们'**
  String get donation_reminder_page_donate_button_label;

  /// No description provided for @review_reminder_page_title.
  ///
  /// In zh, this message translates to:
  /// **'你的意见很重要'**
  String get review_reminder_page_title;

  /// No description provided for @review_reminder_page_section_1_title.
  ///
  /// In zh, this message translates to:
  /// **'分享你的想法'**
  String get review_reminder_page_section_1_title;

  /// No description provided for @review_reminder_page_section_1_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'你的反馈非常重要！告诉我们你希望在未来的更新中看到什么功能。'**
  String get review_reminder_page_section_1_subtitle;

  /// No description provided for @review_reminder_page_section_2_title.
  ///
  /// In zh, this message translates to:
  /// **'帮助我们改进'**
  String get review_reminder_page_section_2_title;

  /// No description provided for @review_reminder_page_section_2_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'如果你遇到任何问题，请告诉我们——我们会尽快修复它们。'**
  String get review_reminder_page_section_2_subtitle;

  /// No description provided for @review_reminder_page_section_3_title.
  ///
  /// In zh, this message translates to:
  /// **'表达你的支持'**
  String get review_reminder_page_section_3_title;

  /// No description provided for @review_reminder_page_section_3_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'留下评论是帮助我们的项目发展并触达更多人的好方法。'**
  String get review_reminder_page_section_3_subtitle;

  /// No description provided for @review_reminder_donate_button_label.
  ///
  /// In zh, this message translates to:
  /// **'去评价'**
  String get review_reminder_donate_button_label;

  /// No description provided for @download_native_page_title.
  ///
  /// In zh, this message translates to:
  /// **'下载原生应用'**
  String get download_native_page_title;

  /// No description provided for @download_native_page_section_1_title.
  ///
  /// In zh, this message translates to:
  /// **'更佳性能'**
  String get download_native_page_section_1_title;

  /// No description provided for @download_native_page_section_1_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'原生应用运行更流畅、更快速、更稳定。'**
  String get download_native_page_section_1_subtitle;

  /// No description provided for @download_native_page_section_2_title.
  ///
  /// In zh, this message translates to:
  /// **'数据安全'**
  String get download_native_page_section_2_title;

  /// No description provided for @download_native_page_section_2_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'使用原生应用更安全地保护你的宝贵数据。'**
  String get download_native_page_section_2_subtitle;

  /// No description provided for @download_native_page_section_3_title.
  ///
  /// In zh, this message translates to:
  /// **'离线访问'**
  String get download_native_page_section_3_title;

  /// No description provided for @download_native_page_section_3_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'有了原生应用，即使离线你也可以畅玩。'**
  String get download_native_page_section_3_subtitle;

  /// No description provided for @download_native_donate_button_label.
  ///
  /// In zh, this message translates to:
  /// **'立即下载'**
  String get download_native_donate_button_label;

  /// No description provided for @play_main_page_title.
  ///
  /// In zh, this message translates to:
  /// **'Loverquest'**
  String get play_main_page_title;

  /// No description provided for @play_main_page_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'愉悦之旅'**
  String get play_main_page_subtitle;

  /// No description provided for @play_main_page_new_game_button_label.
  ///
  /// In zh, this message translates to:
  /// **'新游戏'**
  String get play_main_page_new_game_button_label;

  /// No description provided for @play_main_page_load_game_button_label.
  ///
  /// In zh, this message translates to:
  /// **'加载游戏'**
  String get play_main_page_load_game_button_label;

  /// No description provided for @ai_translation_warning_snackbar.
  ///
  /// In zh, this message translates to:
  /// **'此版本使用AI翻译生成。如果您发现任何异常，请告知我们并提出修改建议。'**
  String get ai_translation_warning_snackbar;

  /// No description provided for @select_game_type_page_title.
  ///
  /// In zh, this message translates to:
  /// **'选择游戏模式'**
  String get select_game_type_page_title;

  /// No description provided for @select_game_type_presence_mode_title.
  ///
  /// In zh, this message translates to:
  /// **'本地同玩'**
  String get select_game_type_presence_mode_title;

  /// No description provided for @select_game_type_presence_mode_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'与伴侣开启一段精彩绝伦的现场旅程。'**
  String get select_game_type_presence_mode_subtitle;

  /// No description provided for @select_game_type_distance_mode_title.
  ///
  /// In zh, this message translates to:
  /// **'在线同玩'**
  String get select_game_type_distance_mode_title;

  /// No description provided for @select_game_type_distance_mode_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'通过你喜欢的聊天工具远程与伴侣一起玩，共同体验神奇时刻。'**
  String get select_game_type_distance_mode_subtitle;

  /// No description provided for @online_safety_reminder_page_title.
  ///
  /// In zh, this message translates to:
  /// **'安全第一'**
  String get online_safety_reminder_page_title;

  /// No description provided for @online_safety_reminder_page_section_1_title.
  ///
  /// In zh, this message translates to:
  /// **'负责任地分享'**
  String get online_safety_reminder_page_section_1_title;

  /// No description provided for @online_safety_reminder_page_section_1_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'在线分享的任何内容都可能被永久保存。'**
  String get online_safety_reminder_page_section_1_subtitle;

  /// No description provided for @online_safety_reminder_page_section_2_title.
  ///
  /// In zh, this message translates to:
  /// **'使用私密应用'**
  String get online_safety_reminder_page_section_2_title;

  /// No description provided for @online_safety_reminder_page_section_2_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'我们推荐使用Signal等安全应用，以确保隐私并与日常生活分离。'**
  String get online_safety_reminder_page_section_2_subtitle;

  /// No description provided for @online_safety_reminder_page_section_3_title.
  ///
  /// In zh, this message translates to:
  /// **'遵守法律'**
  String get online_safety_reminder_page_section_3_title;

  /// No description provided for @online_safety_reminder_page_section_3_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'Loverquest对非法活动或分享违禁内容不承担责任。'**
  String get online_safety_reminder_page_section_3_subtitle;

  /// No description provided for @online_safety_reminder_donate_button_label.
  ///
  /// In zh, this message translates to:
  /// **'明白了'**
  String get online_safety_reminder_donate_button_label;

  /// No description provided for @select_players_type_title.
  ///
  /// In zh, this message translates to:
  /// **'选择玩家性别'**
  String get select_players_type_title;

  /// No description provided for @select_players_type_hetero_couple_title.
  ///
  /// In zh, this message translates to:
  /// **'异性恋伴侣'**
  String get select_players_type_hetero_couple_title;

  /// No description provided for @select_players_type_hetero_couple_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'玩家拥有不同生殖器的伴侣。'**
  String get select_players_type_hetero_couple_subtitle;

  /// No description provided for @select_players_type_lesbian_couple_title.
  ///
  /// In zh, this message translates to:
  /// **'女同性恋伴侣'**
  String get select_players_type_lesbian_couple_title;

  /// No description provided for @select_players_type_lesbian_couple_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'两位玩家均拥有女性生殖器的伴侣。'**
  String get select_players_type_lesbian_couple_subtitle;

  /// No description provided for @select_players_type_gay_couple_title.
  ///
  /// In zh, this message translates to:
  /// **'男同性恋伴侣'**
  String get select_players_type_gay_couple_title;

  /// No description provided for @select_players_type_gay_couple_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'两位玩家均拥有男性生殖器的伴侣。'**
  String get select_players_type_gay_couple_subtitle;

  /// No description provided for @define_players_name_page_title.
  ///
  /// In zh, this message translates to:
  /// **'输入玩家昵称'**
  String get define_players_name_page_title;

  /// No description provided for @define_players_name_player_one_label.
  ///
  /// In zh, this message translates to:
  /// **'玩家 1'**
  String get define_players_name_player_one_label;

  /// No description provided for @define_players_name_player_two_label.
  ///
  /// In zh, this message translates to:
  /// **'玩家 2'**
  String get define_players_name_player_two_label;

  /// No description provided for @define_players_name_textfield_hint_label.
  ///
  /// In zh, this message translates to:
  /// **'输入昵称...'**
  String get define_players_name_textfield_hint_label;

  /// No description provided for @define_players_name_error_label.
  ///
  /// In zh, this message translates to:
  /// **'必须填写所有字段'**
  String get define_players_name_error_label;

  /// No description provided for @define_players_name_confirm_button.
  ///
  /// In zh, this message translates to:
  /// **'确认'**
  String get define_players_name_confirm_button;

  /// No description provided for @select_start_player_page_title.
  ///
  /// In zh, this message translates to:
  /// **'选择谁先开始'**
  String get select_start_player_page_title;

  /// No description provided for @select_start_player_player_one_name.
  ///
  /// In zh, this message translates to:
  /// **'{player_1_alias} 先开始'**
  String select_start_player_player_one_name(String player_1_alias);

  /// No description provided for @select_start_player_player_two_name.
  ///
  /// In zh, this message translates to:
  /// **'{player_2_alias} 先开始'**
  String select_start_player_player_two_name(String player_2_alias);

  /// No description provided for @select_start_player_random_player.
  ///
  /// In zh, this message translates to:
  /// **'随机选择'**
  String get select_start_player_random_player;

  /// No description provided for @select_deck_page_title.
  ///
  /// In zh, this message translates to:
  /// **'选择你想玩的卡组'**
  String get select_deck_page_title;

  /// No description provided for @deck_language_en.
  ///
  /// In zh, this message translates to:
  /// **'英语'**
  String get deck_language_en;

  /// No description provided for @deck_language_it.
  ///
  /// In zh, this message translates to:
  /// **'意大利语'**
  String get deck_language_it;

  /// No description provided for @deck_language_es.
  ///
  /// In zh, this message translates to:
  /// **'西班牙语'**
  String get deck_language_es;

  /// No description provided for @deck_language_de.
  ///
  /// In zh, this message translates to:
  /// **'德语'**
  String get deck_language_de;

  /// No description provided for @deck_language_fr.
  ///
  /// In zh, this message translates to:
  /// **'法语'**
  String get deck_language_fr;

  /// No description provided for @deck_language_nl.
  ///
  /// In zh, this message translates to:
  /// **'荷兰语'**
  String get deck_language_nl;

  /// No description provided for @deck_language_zh.
  ///
  /// In zh, this message translates to:
  /// **'Chinese'**
  String get deck_language_zh;

  /// No description provided for @deck_couple_type_tag_label_hetero.
  ///
  /// In zh, this message translates to:
  /// **'异性恋'**
  String get deck_couple_type_tag_label_hetero;

  /// No description provided for @deck_couple_type_tag_label_lesbian.
  ///
  /// In zh, this message translates to:
  /// **'女同性恋'**
  String get deck_couple_type_tag_label_lesbian;

  /// No description provided for @deck_couple_type_tag_label_gay.
  ///
  /// In zh, this message translates to:
  /// **'男同性恋'**
  String get deck_couple_type_tag_label_gay;

  /// No description provided for @deck_couple_type_tag_label_not_spec.
  ///
  /// In zh, this message translates to:
  /// **'未指定'**
  String get deck_couple_type_tag_label_not_spec;

  /// No description provided for @deck_game_type_tag_label_presence.
  ///
  /// In zh, this message translates to:
  /// **'本地'**
  String get deck_game_type_tag_label_presence;

  /// No description provided for @deck_game_type_tag_label_distance.
  ///
  /// In zh, this message translates to:
  /// **'在线'**
  String get deck_game_type_tag_label_distance;

  /// No description provided for @deck_oral_sex_tag_label.
  ///
  /// In zh, this message translates to:
  /// **'口交'**
  String get deck_oral_sex_tag_label;

  /// No description provided for @deck_vaginal_sex_tag_label.
  ///
  /// In zh, this message translates to:
  /// **'阴道性交'**
  String get deck_vaginal_sex_tag_label;

  /// No description provided for @deck_anal_sex_tag_label.
  ///
  /// In zh, this message translates to:
  /// **'肛交'**
  String get deck_anal_sex_tag_label;

  /// No description provided for @deck_bondage_tag_label.
  ///
  /// In zh, this message translates to:
  /// **'捆绑'**
  String get deck_bondage_tag_label;

  /// No description provided for @deck_bdsm_tag_label.
  ///
  /// In zh, this message translates to:
  /// **'BDSM'**
  String get deck_bdsm_tag_label;

  /// No description provided for @deck_chat_tag_label.
  ///
  /// In zh, this message translates to:
  /// **'聊天'**
  String get deck_chat_tag_label;

  /// No description provided for @deck_video_chat_tag_label.
  ///
  /// In zh, this message translates to:
  /// **'视频通话'**
  String get deck_video_chat_tag_label;

  /// No description provided for @deck_difficulty_not_specified.
  ///
  /// In zh, this message translates to:
  /// **'未指定'**
  String get deck_difficulty_not_specified;

  /// No description provided for @no_tools_label.
  ///
  /// In zh, this message translates to:
  /// **'无需道具'**
  String get no_tools_label;

  /// No description provided for @tools_label.
  ///
  /// In zh, this message translates to:
  /// **'需要道具'**
  String get tools_label;

  /// No description provided for @select_deck_time_minutes_label.
  ///
  /// In zh, this message translates to:
  /// **'{deck_requested_time} 分钟'**
  String select_deck_time_minutes_label(int deck_requested_time);

  /// No description provided for @deck_info_no_tools_label.
  ///
  /// In zh, this message translates to:
  /// **'无'**
  String get deck_info_no_tools_label;

  /// No description provided for @deck_info_distance_label.
  ///
  /// In zh, this message translates to:
  /// **'在线'**
  String get deck_info_distance_label;

  /// No description provided for @deck_info_presence_label.
  ///
  /// In zh, this message translates to:
  /// **'本地'**
  String get deck_info_presence_label;

  /// No description provided for @deck_info_couple_type_hetero.
  ///
  /// In zh, this message translates to:
  /// **'异性恋'**
  String get deck_info_couple_type_hetero;

  /// No description provided for @deck_info_couple_type_lesbian.
  ///
  /// In zh, this message translates to:
  /// **'女同性恋'**
  String get deck_info_couple_type_lesbian;

  /// No description provided for @deck_info_couple_type_gay.
  ///
  /// In zh, this message translates to:
  /// **'男同性恋'**
  String get deck_info_couple_type_gay;

  /// No description provided for @deck_info_page_title.
  ///
  /// In zh, this message translates to:
  /// **'卡组信息'**
  String get deck_info_page_title;

  /// No description provided for @deck_info_information_name_label.
  ///
  /// In zh, this message translates to:
  /// **'名称: '**
  String get deck_info_information_name_label;

  /// No description provided for @deck_info_information_language_label.
  ///
  /// In zh, this message translates to:
  /// **'语言: '**
  String get deck_info_information_language_label;

  /// No description provided for @deck_info_information_game_type_label.
  ///
  /// In zh, this message translates to:
  /// **'游戏模式: '**
  String get deck_info_information_game_type_label;

  /// No description provided for @deck_info_information_couple_type_label.
  ///
  /// In zh, this message translates to:
  /// **'伴侣类型: '**
  String get deck_info_information_couple_type_label;

  /// No description provided for @deck_info_information_timer_label.
  ///
  /// In zh, this message translates to:
  /// **'时间限制: '**
  String get deck_info_information_timer_label;

  /// No description provided for @deck_info_information_minute_label.
  ///
  /// In zh, this message translates to:
  /// **'分钟'**
  String get deck_info_information_minute_label;

  /// No description provided for @deck_info_information_quest_number_label.
  ///
  /// In zh, this message translates to:
  /// **'任务数量: '**
  String get deck_info_information_quest_number_label;

  /// No description provided for @deck_info_information_requested_tools_label.
  ///
  /// In zh, this message translates to:
  /// **'所需道具: '**
  String get deck_info_information_requested_tools_label;

  /// No description provided for @deck_info_information_designated_player_label.
  ///
  /// In zh, this message translates to:
  /// **'指定玩家: '**
  String get deck_info_information_designated_player_label;

  /// No description provided for @deck_info_information_description_label.
  ///
  /// In zh, this message translates to:
  /// **'描述: '**
  String get deck_info_information_description_label;

  /// No description provided for @deck_info_select_deck_button_label.
  ///
  /// In zh, this message translates to:
  /// **'选择此卡组'**
  String get deck_info_select_deck_button_label;

  /// No description provided for @deck_info_quest_list_title.
  ///
  /// In zh, this message translates to:
  /// **'任务列表'**
  String get deck_info_quest_list_title;

  /// No description provided for @deck_info_quest_info_early_quest_type.
  ///
  /// In zh, this message translates to:
  /// **'前期任务'**
  String get deck_info_quest_info_early_quest_type;

  /// No description provided for @deck_info_quest_info_mid_quest_type.
  ///
  /// In zh, this message translates to:
  /// **'中期任务'**
  String get deck_info_quest_info_mid_quest_type;

  /// No description provided for @deck_info_quest_info_late_quest_type.
  ///
  /// In zh, this message translates to:
  /// **'后期任务'**
  String get deck_info_quest_info_late_quest_type;

  /// No description provided for @deck_info_quest_info_end_quest_type.
  ///
  /// In zh, this message translates to:
  /// **'最终任务'**
  String get deck_info_quest_info_end_quest_type;

  /// No description provided for @deck_info_quest_info_quest_type_label.
  ///
  /// In zh, this message translates to:
  /// **'类型: '**
  String get deck_info_quest_info_quest_type_label;

  /// No description provided for @deck_info_tags_list_label.
  ///
  /// In zh, this message translates to:
  /// **'标签: '**
  String get deck_info_tags_list_label;

  /// No description provided for @tags_list_oral_sex_tag.
  ///
  /// In zh, this message translates to:
  /// **'口交'**
  String get tags_list_oral_sex_tag;

  /// No description provided for @tags_list_anal_sex_tag.
  ///
  /// In zh, this message translates to:
  /// **'肛交'**
  String get tags_list_anal_sex_tag;

  /// No description provided for @tags_list_vaginal_sex_tag.
  ///
  /// In zh, this message translates to:
  /// **'阴道性交'**
  String get tags_list_vaginal_sex_tag;

  /// No description provided for @tags_list_bondage_tag.
  ///
  /// In zh, this message translates to:
  /// **'捆绑'**
  String get tags_list_bondage_tag;

  /// No description provided for @tags_list_bdsm_tag.
  ///
  /// In zh, this message translates to:
  /// **'BDSM'**
  String get tags_list_bdsm_tag;

  /// No description provided for @tags_list_chat_tag.
  ///
  /// In zh, this message translates to:
  /// **'聊天'**
  String get tags_list_chat_tag;

  /// No description provided for @tags_list_video_chat_tag.
  ///
  /// In zh, this message translates to:
  /// **'视频通话'**
  String get tags_list_video_chat_tag;

  /// No description provided for @deck_info_deck_unplayable_error.
  ///
  /// In zh, this message translates to:
  /// **'你不能玩一个没有任务的卡组！请为此卡组添加一些任务或选择另一个卡组继续。'**
  String get deck_info_deck_unplayable_error;

  /// No description provided for @select_game_speed_page_title.
  ///
  /// In zh, this message translates to:
  /// **'选择游戏节奏'**
  String get select_game_speed_page_title;

  /// No description provided for @select_game_speed_speed_1_title.
  ///
  /// In zh, this message translates to:
  /// **'时间紧迫'**
  String get select_game_speed_speed_1_title;

  /// No description provided for @select_game_speed_speed_2_title.
  ///
  /// In zh, this message translates to:
  /// **'快速有趣'**
  String get select_game_speed_speed_2_title;

  /// No description provided for @select_game_speed_speed_3_title.
  ///
  /// In zh, this message translates to:
  /// **'不急不忙'**
  String get select_game_speed_speed_3_title;

  /// No description provided for @select_game_speed_speed_4_title.
  ///
  /// In zh, this message translates to:
  /// **'我想体验全部'**
  String get select_game_speed_speed_4_title;

  /// No description provided for @select_game_speed_speed_1_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'只有在前一类别中至少使用了25%的任务后，才会进入下一类别。'**
  String get select_game_speed_speed_1_subtitle;

  /// No description provided for @select_game_speed_speed_2_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'只有在前一类别中至少使用了50%的任务后，才会进入下一类别。'**
  String get select_game_speed_speed_2_subtitle;

  /// No description provided for @select_game_speed_speed_3_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'只有在前一类别中至少使用了75%的任务后，才会进入下一类别。'**
  String get select_game_speed_speed_3_subtitle;

  /// No description provided for @select_game_speed_speed_4_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'只有在前一类别中的所有任务都使用完后，才会进入下一类别。'**
  String get select_game_speed_speed_4_subtitle;

  /// No description provided for @quest_tool_female_lingerie.
  ///
  /// In zh, this message translates to:
  /// **'女性内衣'**
  String get quest_tool_female_lingerie;

  /// No description provided for @quest_tool_male_lingerie.
  ///
  /// In zh, this message translates to:
  /// **'男性内衣'**
  String get quest_tool_male_lingerie;

  /// No description provided for @quest_tool_blindfold.
  ///
  /// In zh, this message translates to:
  /// **'眼罩'**
  String get quest_tool_blindfold;

  /// No description provided for @quest_tool_rope.
  ///
  /// In zh, this message translates to:
  /// **'绳索'**
  String get quest_tool_rope;

  /// No description provided for @quest_tool_handcuffs.
  ///
  /// In zh, this message translates to:
  /// **'手铐'**
  String get quest_tool_handcuffs;

  /// No description provided for @quest_tool_dice.
  ///
  /// In zh, this message translates to:
  /// **'骰子'**
  String get quest_tool_dice;

  /// No description provided for @quest_tool_vibrator.
  ///
  /// In zh, this message translates to:
  /// **'振动棒'**
  String get quest_tool_vibrator;

  /// No description provided for @quest_tool_remote_vibrator.
  ///
  /// In zh, this message translates to:
  /// **'远程振动棒'**
  String get quest_tool_remote_vibrator;

  /// No description provided for @quest_tool_anal_beads.
  ///
  /// In zh, this message translates to:
  /// **'肛珠'**
  String get quest_tool_anal_beads;

  /// No description provided for @quest_tool_dildo.
  ///
  /// In zh, this message translates to:
  /// **'假阳具'**
  String get quest_tool_dildo;

  /// No description provided for @quest_tool_inflatable_dildo.
  ///
  /// In zh, this message translates to:
  /// **'充气假阳具'**
  String get quest_tool_inflatable_dildo;

  /// No description provided for @quest_tool_suction_cup_dildo.
  ///
  /// In zh, this message translates to:
  /// **'吸盘假阳具'**
  String get quest_tool_suction_cup_dildo;

  /// No description provided for @quest_tool_vibrating_dildo.
  ///
  /// In zh, this message translates to:
  /// **'振动假阳具'**
  String get quest_tool_vibrating_dildo;

  /// No description provided for @quest_tool_gag.
  ///
  /// In zh, this message translates to:
  /// **'口球'**
  String get quest_tool_gag;

  /// No description provided for @quest_tool_feather.
  ///
  /// In zh, this message translates to:
  /// **'羽毛'**
  String get quest_tool_feather;

  /// No description provided for @quest_tool_plug.
  ///
  /// In zh, this message translates to:
  /// **'肛门塞'**
  String get quest_tool_plug;

  /// No description provided for @quest_tool_inflatable_plug.
  ///
  /// In zh, this message translates to:
  /// **'充气肛门塞'**
  String get quest_tool_inflatable_plug;

  /// No description provided for @quest_tool_vibrating_plug.
  ///
  /// In zh, this message translates to:
  /// **'振动肛门塞'**
  String get quest_tool_vibrating_plug;

  /// No description provided for @quest_tool_candle.
  ///
  /// In zh, this message translates to:
  /// **'按摩蜡烛'**
  String get quest_tool_candle;

  /// No description provided for @quest_tool_collar_and_leash.
  ///
  /// In zh, this message translates to:
  /// **'项圈和 leash'**
  String get quest_tool_collar_and_leash;

  /// No description provided for @quest_tool_massage_oil.
  ///
  /// In zh, this message translates to:
  /// **'按摩油'**
  String get quest_tool_massage_oil;

  /// No description provided for @quest_tool_lubricants.
  ///
  /// In zh, this message translates to:
  /// **'润滑剂'**
  String get quest_tool_lubricants;

  /// No description provided for @quest_tool_strap_on.
  ///
  /// In zh, this message translates to:
  /// **' strap-on 假阳具'**
  String get quest_tool_strap_on;

  /// No description provided for @quest_tool_nipple_clamps.
  ///
  /// In zh, this message translates to:
  /// **'乳头夹'**
  String get quest_tool_nipple_clamps;

  /// No description provided for @quest_tool_nipple_pump.
  ///
  /// In zh, this message translates to:
  /// **'乳头泵'**
  String get quest_tool_nipple_pump;

  /// No description provided for @quest_tool_riding_crop.
  ///
  /// In zh, this message translates to:
  /// **'骑乘鞭'**
  String get quest_tool_riding_crop;

  /// No description provided for @quest_tool_flogger.
  ///
  /// In zh, this message translates to:
  /// **' flogger (鞭子)'**
  String get quest_tool_flogger;

  /// No description provided for @quest_tool_spanking_paddle.
  ///
  /// In zh, this message translates to:
  /// **'打屁股板'**
  String get quest_tool_spanking_paddle;

  /// No description provided for @quest_tool_male_chastity_cage.
  ///
  /// In zh, this message translates to:
  /// **'男性贞操笼'**
  String get quest_tool_male_chastity_cage;

  /// No description provided for @quest_tool_female_chastity_cage.
  ///
  /// In zh, this message translates to:
  /// **'女性贞操笼'**
  String get quest_tool_female_chastity_cage;

  /// No description provided for @quest_tool_ice.
  ///
  /// In zh, this message translates to:
  /// **'冰块'**
  String get quest_tool_ice;

  /// No description provided for @play_page_title.
  ///
  /// In zh, this message translates to:
  /// **'你的任务'**
  String get play_page_title;

  /// No description provided for @play_page_completed_button.
  ///
  /// In zh, this message translates to:
  /// **'已完成'**
  String get play_page_completed_button;

  /// No description provided for @play_page_replace_button.
  ///
  /// In zh, this message translates to:
  /// **'替换'**
  String get play_page_replace_button;

  /// No description provided for @play_page_timer_label.
  ///
  /// In zh, this message translates to:
  /// **'计时器'**
  String get play_page_timer_label;

  /// No description provided for @play_page_quest_no_quest_label.
  ///
  /// In zh, this message translates to:
  /// **'没有更多任务了，请开始新游戏。'**
  String get play_page_quest_no_quest_label;

  /// No description provided for @play_page_end_page_title.
  ///
  /// In zh, this message translates to:
  /// **'你已完成所有任务！'**
  String get play_page_end_page_title;

  /// No description provided for @play_page_end_page_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'感谢你游玩 Loverquest，希望你们玩得开心'**
  String get play_page_end_page_subtitle;

  /// No description provided for @play_page_end_page_go_home_button_label.
  ///
  /// In zh, this message translates to:
  /// **'退出'**
  String get play_page_end_page_go_home_button_label;

  /// No description provided for @deck_list_main_page_title.
  ///
  /// In zh, this message translates to:
  /// **'管理卡组'**
  String get deck_list_main_page_title;

  /// No description provided for @deck_list_main_page_default_decks_section_title.
  ///
  /// In zh, this message translates to:
  /// **'默认卡组'**
  String get deck_list_main_page_default_decks_section_title;

  /// No description provided for @deck_list_main_page_default_decks_section_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'查看和管理应用的默认卡组。'**
  String get deck_list_main_page_default_decks_section_subtitle;

  /// No description provided for @deck_list_main_page_custom_decks_section_title.
  ///
  /// In zh, this message translates to:
  /// **'自定义卡组'**
  String get deck_list_main_page_custom_decks_section_title;

  /// No description provided for @deck_list_main_page_custom_decks_section_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'创建、管理和导入精彩的自定义卡组。'**
  String get deck_list_main_page_custom_decks_section_subtitle;

  /// No description provided for @deck_management_page_default_deck_list.
  ///
  /// In zh, this message translates to:
  /// **'默认卡组列表'**
  String get deck_management_page_default_deck_list;

  /// No description provided for @deck_management_page_custom_deck_list.
  ///
  /// In zh, this message translates to:
  /// **'自定义卡组列表'**
  String get deck_management_page_custom_deck_list;

  /// No description provided for @deck_management_page_import_error_text.
  ///
  /// In zh, this message translates to:
  /// **'导入所选卡组时出错。请选择一个有效的 Loverquest 卡组文件并重试。'**
  String get deck_management_page_import_error_text;

  /// No description provided for @deck_management_press_menu_delete.
  ///
  /// In zh, this message translates to:
  /// **'删除'**
  String get deck_management_press_menu_delete;

  /// No description provided for @deck_management_press_menu_export.
  ///
  /// In zh, this message translates to:
  /// **'导出'**
  String get deck_management_press_menu_export;

  /// No description provided for @deck_management_press_menu_duplicate.
  ///
  /// In zh, this message translates to:
  /// **'复制'**
  String get deck_management_press_menu_duplicate;

  /// No description provided for @deck_management_press_menu_edit.
  ///
  /// In zh, this message translates to:
  /// **'编辑'**
  String get deck_management_press_menu_edit;

  /// No description provided for @deck_management_delete_deck_dialog_title.
  ///
  /// In zh, this message translates to:
  /// **'确定吗？'**
  String get deck_management_delete_deck_dialog_title;

  /// No description provided for @deck_management_delete_deck_dialog_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'这将永久删除以下卡组：'**
  String get deck_management_delete_deck_dialog_subtitle;

  /// No description provided for @deck_management_delete_deck_dialog_yes_button_label.
  ///
  /// In zh, this message translates to:
  /// **'是'**
  String get deck_management_delete_deck_dialog_yes_button_label;

  /// No description provided for @deck_management_delete_deck_dialog_no_button_label.
  ///
  /// In zh, this message translates to:
  /// **'否'**
  String get deck_management_delete_deck_dialog_no_button_label;

  /// No description provided for @deck_management_delete_quest_dialog_title.
  ///
  /// In zh, this message translates to:
  /// **'确定吗？'**
  String get deck_management_delete_quest_dialog_title;

  /// No description provided for @deck_management_delete_quest_dialog_subtitle.
  ///
  /// In zh, this message translates to:
  /// **'这将永久删除以下任务：'**
  String get deck_management_delete_quest_dialog_subtitle;

  /// No description provided for @deck_management_delete_quest_dialog_yes_button_label.
  ///
  /// In zh, this message translates to:
  /// **'是'**
  String get deck_management_delete_quest_dialog_yes_button_label;

  /// No description provided for @deck_management_delete_quest_dialog_no_button_label.
  ///
  /// In zh, this message translates to:
  /// **'否'**
  String get deck_management_delete_quest_dialog_no_button_label;

  /// No description provided for @deck_management_page_no_decks_text.
  ///
  /// In zh, this message translates to:
  /// **'抱歉，这里空空如也'**
  String get deck_management_page_no_decks_text;

  /// No description provided for @deck_management_page_not_done_yet.
  ///
  /// In zh, this message translates to:
  /// **'抱歉，请等待下次更新后再来尝试'**
  String get deck_management_page_not_done_yet;

  /// No description provided for @deck_management_page_warning_dialog_title.
  ///
  /// In zh, this message translates to:
  /// **'警告！'**
  String get deck_management_page_warning_dialog_title;

  /// No description provided for @deck_management_page_warning_dialog_content.
  ///
  /// In zh, this message translates to:
  /// **'自定义卡组数据将保存在你的浏览器缓存中。我们建议始终下载你的自定义卡组，以避免意外丢失。'**
  String get deck_management_page_warning_dialog_content;

  /// No description provided for @deck_management_page_warning_dialog_ok_button.
  ///
  /// In zh, this message translates to:
  /// **'知道了'**
  String get deck_management_page_warning_dialog_ok_button;

  /// No description provided for @deck_summary_editor_title.
  ///
  /// In zh, this message translates to:
  /// **'卡组摘要信息'**
  String get deck_summary_editor_title;

  /// No description provided for @deck_summary_editor_insert_text_hint.
  ///
  /// In zh, this message translates to:
  /// **'在此输入文本...'**
  String get deck_summary_editor_insert_text_hint;

  /// No description provided for @quest_editor_page_title.
  ///
  /// In zh, this message translates to:
  /// **'任务内容'**
  String get quest_editor_page_title;

  /// No description provided for @quest_editor_page_quest_type.
  ///
  /// In zh, this message translates to:
  /// **'任务类型'**
  String get quest_editor_page_quest_type;

  /// No description provided for @quest_editor_page_quest_type_early.
  ///
  /// In zh, this message translates to:
  /// **'前期'**
  String get quest_editor_page_quest_type_early;

  /// No description provided for @quest_editor_page_quest_type_mid.
  ///
  /// In zh, this message translates to:
  /// **'中期'**
  String get quest_editor_page_quest_type_mid;

  /// No description provided for @quest_editor_page_quest_type_late.
  ///
  /// In zh, this message translates to:
  /// **'后期'**
  String get quest_editor_page_quest_type_late;

  /// No description provided for @quest_editor_page_quest_type_end.
  ///
  /// In zh, this message translates to:
  /// **'最终'**
  String get quest_editor_page_quest_type_end;

  /// No description provided for @quest_editor_page_quest_timer_label.
  ///
  /// In zh, this message translates to:
  /// **'时间限制 - 分钟'**
  String get quest_editor_page_quest_timer_label;

  /// No description provided for @quest_editor_page_quest_content_label.
  ///
  /// In zh, this message translates to:
  /// **'内容'**
  String get quest_editor_page_quest_content_label;

  /// No description provided for @quest_editor_page_tools_dialog_title.
  ///
  /// In zh, this message translates to:
  /// **'选择道具'**
  String get quest_editor_page_tools_dialog_title;

  /// No description provided for @quest_editor_page_player_type_title.
  ///
  /// In zh, this message translates to:
  /// **'选择目标玩家'**
  String get quest_editor_page_player_type_title;

  /// No description provided for @quest_editor_page_player_type_both.
  ///
  /// In zh, this message translates to:
  /// **'双方'**
  String get quest_editor_page_player_type_both;

  /// No description provided for @quest_editor_page_player_type_male.
  ///
  /// In zh, this message translates to:
  /// **'男性'**
  String get quest_editor_page_player_type_male;

  /// No description provided for @quest_editor_page_player_type_female.
  ///
  /// In zh, this message translates to:
  /// **'女性'**
  String get quest_editor_page_player_type_female;

  /// No description provided for @quest_editor_page_tools_dialog_save_button_label.
  ///
  /// In zh, this message translates to:
  /// **'保存'**
  String get quest_editor_page_tools_dialog_save_button_label;

  /// No description provided for @deck_filter_dialog_title.
  ///
  /// In zh, this message translates to:
  /// **'选择筛选条件'**
  String get deck_filter_dialog_title;

  /// No description provided for @deck_filter_dialog_hetero_tag.
  ///
  /// In zh, this message translates to:
  /// **'异性恋'**
  String get deck_filter_dialog_hetero_tag;

  /// No description provided for @deck_filter_dialog_lesbian_tag.
  ///
  /// In zh, this message translates to:
  /// **'女同性恋'**
  String get deck_filter_dialog_lesbian_tag;

  /// No description provided for @deck_filter_dialog_gay_tag.
  ///
  /// In zh, this message translates to:
  /// **'男同性恋'**
  String get deck_filter_dialog_gay_tag;

  /// No description provided for @deck_filter_dialog_all_tag.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get deck_filter_dialog_all_tag;

  /// No description provided for @deck_filter_dialog_presence_tag.
  ///
  /// In zh, this message translates to:
  /// **'本地'**
  String get deck_filter_dialog_presence_tag;

  /// No description provided for @deck_filter_dialog_distance_tag.
  ///
  /// In zh, this message translates to:
  /// **'在线'**
  String get deck_filter_dialog_distance_tag;

  /// No description provided for @deck_filter_dialog_with_tools_tag.
  ///
  /// In zh, this message translates to:
  /// **'需要道具'**
  String get deck_filter_dialog_with_tools_tag;

  /// No description provided for @deck_filter_dialog_without_tools_tag.
  ///
  /// In zh, this message translates to:
  /// **'无需道具'**
  String get deck_filter_dialog_without_tools_tag;

  /// No description provided for @deck_filter_dialog_chat_only_tag.
  ///
  /// In zh, this message translates to:
  /// **'仅聊天'**
  String get deck_filter_dialog_chat_only_tag;

  /// No description provided for @deck_filter_dialog_videochat_only_tag.
  ///
  /// In zh, this message translates to:
  /// **'仅视频通话'**
  String get deck_filter_dialog_videochat_only_tag;

  /// No description provided for @deck_filter_dialog_beginner_tag.
  ///
  /// In zh, this message translates to:
  /// **'初学者'**
  String get deck_filter_dialog_beginner_tag;

  /// No description provided for @deck_filter_dialog_intermediate_tag.
  ///
  /// In zh, this message translates to:
  /// **'中级'**
  String get deck_filter_dialog_intermediate_tag;

  /// No description provided for @deck_filter_dialog_advanced_tag.
  ///
  /// In zh, this message translates to:
  /// **'高级'**
  String get deck_filter_dialog_advanced_tag;

  /// No description provided for @deck_filter_dialog_order_ascending_tag.
  ///
  /// In zh, this message translates to:
  /// **'升序'**
  String get deck_filter_dialog_order_ascending_tag;

  /// No description provided for @deck_filter_dialog_order_descending_tag.
  ///
  /// In zh, this message translates to:
  /// **'降序'**
  String get deck_filter_dialog_order_descending_tag;

  /// No description provided for @deck_filter_dialog_moment_early_tag.
  ///
  /// In zh, this message translates to:
  /// **'前期'**
  String get deck_filter_dialog_moment_early_tag;

  /// No description provided for @deck_filter_dialog_moment_mid_tag.
  ///
  /// In zh, this message translates to:
  /// **'中期'**
  String get deck_filter_dialog_moment_mid_tag;

  /// No description provided for @deck_filter_dialog_moment_late_tag.
  ///
  /// In zh, this message translates to:
  /// **'后期'**
  String get deck_filter_dialog_moment_late_tag;

  /// No description provided for @deck_filter_dialog_moment_end_tag.
  ///
  /// In zh, this message translates to:
  /// **'最终'**
  String get deck_filter_dialog_moment_end_tag;

  /// No description provided for @deck_filter_dialog_tools_with_tools_tag.
  ///
  /// In zh, this message translates to:
  /// **'需要道具'**
  String get deck_filter_dialog_tools_with_tools_tag;

  /// No description provided for @deck_filter_dialog_moment_without_tools_tag.
  ///
  /// In zh, this message translates to:
  /// **'无需道具'**
  String get deck_filter_dialog_moment_without_tools_tag;

  /// No description provided for @deck_filter_apply_filter_button.
  ///
  /// In zh, this message translates to:
  /// **'应用筛选'**
  String get deck_filter_apply_filter_button;

  /// No description provided for @settings_main_page_title.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get settings_main_page_title;

  /// No description provided for @settings_main_page_language_section_label.
  ///
  /// In zh, this message translates to:
  /// **'语言'**
  String get settings_main_page_language_section_label;

  /// No description provided for @settings_main_page_language_button_label.
  ///
  /// In zh, this message translates to:
  /// **'选择语言'**
  String get settings_main_page_language_button_label;

  /// No description provided for @settings_main_page_translation_help_button_label.
  ///
  /// In zh, this message translates to:
  /// **'帮助我们翻译'**
  String get settings_main_page_translation_help_button_label;

  /// No description provided for @settings_main_page_webapp_section_label.
  ///
  /// In zh, this message translates to:
  /// **'网页应用'**
  String get settings_main_page_webapp_section_label;

  /// No description provided for @settings_main_page_webapp_button_label.
  ///
  /// In zh, this message translates to:
  /// **'打开网页应用网站'**
  String get settings_main_page_webapp_button_label;

  /// No description provided for @settings_main_page_support_section_label.
  ///
  /// In zh, this message translates to:
  /// **'支持我们'**
  String get settings_main_page_support_section_label;

  /// No description provided for @settings_main_page_feedback_section_label.
  ///
  /// In zh, this message translates to:
  /// **'反馈'**
  String get settings_main_page_feedback_section_label;

  /// No description provided for @settings_main_page_donate_on_github_label.
  ///
  /// In zh, this message translates to:
  /// **'在 GitHub Sponsor 上支持我们'**
  String get settings_main_page_donate_on_github_label;

  /// No description provided for @settings_main_page_donate_on_paypal_label.
  ///
  /// In zh, this message translates to:
  /// **'在 Paypal 上支持我们'**
  String get settings_main_page_donate_on_paypal_label;

  /// No description provided for @settings_main_page_donate_on_buy_me_coffee_label.
  ///
  /// In zh, this message translates to:
  /// **'在 BuyMeACoffee 上支持我们'**
  String get settings_main_page_donate_on_buy_me_coffee_label;

  /// No description provided for @settings_main_page_bug_report_label.
  ///
  /// In zh, this message translates to:
  /// **'报告错误'**
  String get settings_main_page_bug_report_label;

  /// No description provided for @settings_main_page_github_page_label.
  ///
  /// In zh, this message translates to:
  /// **'打开 Github 页面'**
  String get settings_main_page_github_page_label;

  /// No description provided for @settings_main_page_credits_section_label.
  ///
  /// In zh, this message translates to:
  /// **'致谢'**
  String get settings_main_page_credits_section_label;

  /// No description provided for @settings_main_page_credits_label.
  ///
  /// In zh, this message translates to:
  /// **'由 Herzen 用心开发'**
  String get settings_main_page_credits_label;

  /// No description provided for @settings_main_page_other_section_label.
  ///
  /// In zh, this message translates to:
  /// **'其他'**
  String get settings_main_page_other_section_label;

  /// No description provided for @settings_main_page_license_label.
  ///
  /// In zh, this message translates to:
  /// **'应用许可协议'**
  String get settings_main_page_license_label;

  /// No description provided for @settings_main_page_privacy_policy_label.
  ///
  /// In zh, this message translates to:
  /// **'隐私政策'**
  String get settings_main_page_privacy_policy_label;

  /// No description provided for @settings_main_page_app_info_label.
  ///
  /// In zh, this message translates to:
  /// **'应用版本 :'**
  String get settings_main_page_app_info_label;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'it',
        'nl',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'nl':
      return AppLocalizationsNl();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
