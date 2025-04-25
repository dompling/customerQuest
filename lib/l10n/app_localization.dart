import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localization_en.dart';
import 'app_localization_it.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it')
  ];

  /// No description provided for @app_splash_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Thank you !'**
  String get app_splash_screen_title;

  /// No description provided for @app_splash_screen_content.
  ///
  /// In en, this message translates to:
  /// **'Thank you for downloading _Loverquest_! We hope you enjoy our game.\n\nOur goal is to provide you with a fun, discreet, safe, and interactive experience. Our app **does not collect any personal data, does not access the Internet, and does not display ads**.\n\nWe firmly believe that intimacy should be respected. That’s why we are committed to ensuring **maximum privacy**. _Loverquest_ is an **open-source project**, so you can check the source code at any time to verify the app’s transparency and integrity for yourself.\n\nWhen playing with a partner, always remember to **respect their boundaries and never force them to do anything against their will**.\n\nThe actions suggested by the game are designed purely for fun and **do not encourage any form of coercion or sexual violence**.\n\nIf you or your partner feel uncomfortable, you can always **skip any action** you don’t like.\n\nThis project is developed on a voluntary basis and is supported by **user donations**. If you enjoy Loverquest and want to support it, consider making a donation to help us keep it running and improve it.\n\nThe _Loverquest_ team wishes you lots of fun!'**
  String get app_splash_screen_content;

  /// No description provided for @app_splash_screen_close_button_label.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get app_splash_screen_close_button_label;

  /// No description provided for @donation_reminder_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Help us !'**
  String get donation_reminder_dialog_title;

  /// No description provided for @donation_reminder_dialog_content.
  ///
  /// In en, this message translates to:
  /// **'If you enjoyed Loverquest and want to support it, consider making a donation to help us keep it running and continue improving it.'**
  String get donation_reminder_dialog_content;

  /// No description provided for @donation_reminder_dialog_donate_button_label.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get donation_reminder_dialog_donate_button_label;

  /// No description provided for @review_reminder_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Help us !'**
  String get review_reminder_dialog_title;

  /// No description provided for @review_reminder_dialog_content.
  ///
  /// In en, this message translates to:
  /// **'If you enjoyed Loverquest and want to support it, consider leaving a review on Google Play.'**
  String get review_reminder_dialog_content;

  /// No description provided for @review_reminder_dialog_review_button_label.
  ///
  /// In en, this message translates to:
  /// **'Support us'**
  String get review_reminder_dialog_review_button_label;

  /// No description provided for @online_play_disclaimer_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Warning !'**
  String get online_play_disclaimer_dialog_title;

  /// No description provided for @online_play_disclaimer_dialog_content.
  ///
  /// In en, this message translates to:
  /// **'Beware of sharing intimate material online\n\nSafety comes first. Remember that any content shared on the Internet could remain online forever, with no way to completely erase it. Avoid including personal data and make sure that the person you are playing with is trustworthy before sending any intimate material.\n\nLoverquest assumes no responsibility for any illegal activities committed online, such as the non-consensual distribution of intimate material, the sharing of child exploitation content, or other violations of the law.\n'**
  String get online_play_disclaimer_dialog_content;

  /// No description provided for @navbar_play_button_label.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get navbar_play_button_label;

  /// No description provided for @navbar_decks_button_label.
  ///
  /// In en, this message translates to:
  /// **'Decks'**
  String get navbar_decks_button_label;

  /// No description provided for @navbar_settings_button_label.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navbar_settings_button_label;

  /// No description provided for @play_main_page_title.
  ///
  /// In en, this message translates to:
  /// **'Loverquest'**
  String get play_main_page_title;

  /// No description provided for @play_main_page_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Road to pleasure'**
  String get play_main_page_subtitle;

  /// No description provided for @play_main_page_new_game_button_label.
  ///
  /// In en, this message translates to:
  /// **'New game'**
  String get play_main_page_new_game_button_label;

  /// No description provided for @play_main_page_load_game_button_label.
  ///
  /// In en, this message translates to:
  /// **'Load game'**
  String get play_main_page_load_game_button_label;

  /// No description provided for @select_game_type_page_title.
  ///
  /// In en, this message translates to:
  /// **'Select the game type'**
  String get select_game_type_page_title;

  /// No description provided for @select_game_type_presence_mode_title.
  ///
  /// In en, this message translates to:
  /// **'Local play'**
  String get select_game_type_presence_mode_title;

  /// No description provided for @select_game_type_presence_mode_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Live and amazing journey with your partner.'**
  String get select_game_type_presence_mode_subtitle;

  /// No description provided for @select_game_type_distance_mode_title.
  ///
  /// In en, this message translates to:
  /// **'Online play'**
  String get select_game_type_distance_mode_title;

  /// No description provided for @select_game_type_distance_mode_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Play remotely with your partner on your favorite chat and live some magic moments together.'**
  String get select_game_type_distance_mode_subtitle;

  /// No description provided for @select_players_type_title.
  ///
  /// In en, this message translates to:
  /// **'Select the players\' sex'**
  String get select_players_type_title;

  /// No description provided for @select_players_type_hetero_couple_title.
  ///
  /// In en, this message translates to:
  /// **'Straight couple'**
  String get select_players_type_hetero_couple_title;

  /// No description provided for @select_players_type_hetero_couple_subtitle.
  ///
  /// In en, this message translates to:
  /// **'A couple whose the players have different genitals.'**
  String get select_players_type_hetero_couple_subtitle;

  /// No description provided for @select_players_type_lesbian_couple_title.
  ///
  /// In en, this message translates to:
  /// **'Lesbian couple'**
  String get select_players_type_lesbian_couple_title;

  /// No description provided for @select_players_type_lesbian_couple_subtitle.
  ///
  /// In en, this message translates to:
  /// **'A couple where both the players have female genitals'**
  String get select_players_type_lesbian_couple_subtitle;

  /// No description provided for @select_players_type_gay_couple_title.
  ///
  /// In en, this message translates to:
  /// **'Gay couple'**
  String get select_players_type_gay_couple_title;

  /// No description provided for @select_players_type_gay_couple_subtitle.
  ///
  /// In en, this message translates to:
  /// **'A couple where both the players have male genitals '**
  String get select_players_type_gay_couple_subtitle;

  /// No description provided for @define_players_name_page_title.
  ///
  /// In en, this message translates to:
  /// **'Insert the players alias'**
  String get define_players_name_page_title;

  /// No description provided for @define_players_name_player_one_label.
  ///
  /// In en, this message translates to:
  /// **'Player 1'**
  String get define_players_name_player_one_label;

  /// No description provided for @define_players_name_player_two_label.
  ///
  /// In en, this message translates to:
  /// **'Player 2'**
  String get define_players_name_player_two_label;

  /// No description provided for @define_players_name_textfield_hint_label.
  ///
  /// In en, this message translates to:
  /// **'Insert the nickname...'**
  String get define_players_name_textfield_hint_label;

  /// No description provided for @define_players_name_error_label.
  ///
  /// In en, this message translates to:
  /// **'It\'s mandatory to compile all the field'**
  String get define_players_name_error_label;

  /// No description provided for @define_players_name_confirm_button.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get define_players_name_confirm_button;

  /// No description provided for @select_start_player_page_title.
  ///
  /// In en, this message translates to:
  /// **'Choose who will be the first player'**
  String get select_start_player_page_title;

  /// No description provided for @select_start_player_player_one_name.
  ///
  /// In en, this message translates to:
  /// **'{player_1_alias} will start'**
  String select_start_player_player_one_name(String player_1_alias);

  /// No description provided for @select_start_player_player_two_name.
  ///
  /// In en, this message translates to:
  /// **'{player_2_alias} will start'**
  String select_start_player_player_two_name(String player_2_alias);

  /// No description provided for @select_start_player_random_player.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get select_start_player_random_player;

  /// No description provided for @select_deck_page_title.
  ///
  /// In en, this message translates to:
  /// **'Choose which deck you want to play'**
  String get select_deck_page_title;

  /// No description provided for @deck_language_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get deck_language_en;

  /// No description provided for @deck_language_it.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get deck_language_it;

  /// No description provided for @deck_language_es.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get deck_language_es;

  /// No description provided for @deck_language_de.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get deck_language_de;

  /// No description provided for @deck_language_fr.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get deck_language_fr;

  /// No description provided for @deck_couple_type_tag_label_hetero.
  ///
  /// In en, this message translates to:
  /// **'Straight'**
  String get deck_couple_type_tag_label_hetero;

  /// No description provided for @deck_couple_type_tag_label_lesbian.
  ///
  /// In en, this message translates to:
  /// **'Lesbian'**
  String get deck_couple_type_tag_label_lesbian;

  /// No description provided for @deck_couple_type_tag_label_gay.
  ///
  /// In en, this message translates to:
  /// **'Gay'**
  String get deck_couple_type_tag_label_gay;

  /// No description provided for @deck_couple_type_tag_label_not_spec.
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get deck_couple_type_tag_label_not_spec;

  /// No description provided for @deck_game_type_tag_label_presence.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get deck_game_type_tag_label_presence;

  /// No description provided for @deck_game_type_tag_label_distance.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get deck_game_type_tag_label_distance;

  /// No description provided for @deck_oral_sex_tag_label.
  ///
  /// In en, this message translates to:
  /// **'Oral sex'**
  String get deck_oral_sex_tag_label;

  /// No description provided for @deck_vaginal_sex_tag_label.
  ///
  /// In en, this message translates to:
  /// **'Vaginal sex'**
  String get deck_vaginal_sex_tag_label;

  /// No description provided for @deck_anal_sex_tag_label.
  ///
  /// In en, this message translates to:
  /// **'Anal sex'**
  String get deck_anal_sex_tag_label;

  /// No description provided for @deck_bondage_tag_label.
  ///
  /// In en, this message translates to:
  /// **'Bondage'**
  String get deck_bondage_tag_label;

  /// No description provided for @deck_bdsm_tag_label.
  ///
  /// In en, this message translates to:
  /// **'BDSM'**
  String get deck_bdsm_tag_label;

  /// No description provided for @deck_difficulty_not_specified.
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get deck_difficulty_not_specified;

  /// No description provided for @no_tools_label.
  ///
  /// In en, this message translates to:
  /// **'No tools'**
  String get no_tools_label;

  /// No description provided for @tools_label.
  ///
  /// In en, this message translates to:
  /// **'Requires tools'**
  String get tools_label;

  /// No description provided for @select_deck_time_minutes_label.
  ///
  /// In en, this message translates to:
  /// **'{deck_requested_time} minutes'**
  String select_deck_time_minutes_label(int deck_requested_time);

  /// No description provided for @deck_info_no_tools_label.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get deck_info_no_tools_label;

  /// No description provided for @deck_info_distance_label.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get deck_info_distance_label;

  /// No description provided for @deck_info_presence_label.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get deck_info_presence_label;

  /// No description provided for @deck_info_couple_type_hetero.
  ///
  /// In en, this message translates to:
  /// **'Straight'**
  String get deck_info_couple_type_hetero;

  /// No description provided for @deck_info_couple_type_lesbian.
  ///
  /// In en, this message translates to:
  /// **'Lesbian'**
  String get deck_info_couple_type_lesbian;

  /// No description provided for @deck_info_couple_type_gay.
  ///
  /// In en, this message translates to:
  /// **'Gay'**
  String get deck_info_couple_type_gay;

  /// No description provided for @deck_info_page_title.
  ///
  /// In en, this message translates to:
  /// **'Deck information'**
  String get deck_info_page_title;

  /// No description provided for @deck_info_information_name_label.
  ///
  /// In en, this message translates to:
  /// **'Name: '**
  String get deck_info_information_name_label;

  /// No description provided for @deck_info_information_language_label.
  ///
  /// In en, this message translates to:
  /// **'Language: '**
  String get deck_info_information_language_label;

  /// No description provided for @deck_info_information_game_type_label.
  ///
  /// In en, this message translates to:
  /// **'Game type: '**
  String get deck_info_information_game_type_label;

  /// No description provided for @deck_info_information_couple_type_label.
  ///
  /// In en, this message translates to:
  /// **'Couple type: '**
  String get deck_info_information_couple_type_label;

  /// No description provided for @deck_info_information_timer_label.
  ///
  /// In en, this message translates to:
  /// **'Time limit: '**
  String get deck_info_information_timer_label;

  /// No description provided for @deck_info_information_minute_label.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get deck_info_information_minute_label;

  /// No description provided for @deck_info_information_quest_number_label.
  ///
  /// In en, this message translates to:
  /// **'Number of quests: '**
  String get deck_info_information_quest_number_label;

  /// No description provided for @deck_info_information_requested_tools_label.
  ///
  /// In en, this message translates to:
  /// **'Required tools: '**
  String get deck_info_information_requested_tools_label;

  /// No description provided for @deck_info_information_designated_player_label.
  ///
  /// In en, this message translates to:
  /// **'Designated player: '**
  String get deck_info_information_designated_player_label;

  /// No description provided for @deck_info_information_description_label.
  ///
  /// In en, this message translates to:
  /// **'Description: '**
  String get deck_info_information_description_label;

  /// No description provided for @deck_info_select_deck_button_label.
  ///
  /// In en, this message translates to:
  /// **'Select this deck'**
  String get deck_info_select_deck_button_label;

  /// No description provided for @deck_info_quest_list_title.
  ///
  /// In en, this message translates to:
  /// **'Quest list'**
  String get deck_info_quest_list_title;

  /// No description provided for @deck_info_quest_info_early_quest_type.
  ///
  /// In en, this message translates to:
  /// **'Early quest'**
  String get deck_info_quest_info_early_quest_type;

  /// No description provided for @deck_info_quest_info_mid_quest_type.
  ///
  /// In en, this message translates to:
  /// **'Mid quest'**
  String get deck_info_quest_info_mid_quest_type;

  /// No description provided for @deck_info_quest_info_late_quest_type.
  ///
  /// In en, this message translates to:
  /// **'Late quest'**
  String get deck_info_quest_info_late_quest_type;

  /// No description provided for @deck_info_quest_info_end_quest_type.
  ///
  /// In en, this message translates to:
  /// **'End quest'**
  String get deck_info_quest_info_end_quest_type;

  /// No description provided for @deck_info_quest_info_quest_type_label.
  ///
  /// In en, this message translates to:
  /// **'Type: '**
  String get deck_info_quest_info_quest_type_label;

  /// No description provided for @deck_info_tags_list_label.
  ///
  /// In en, this message translates to:
  /// **'Tags: '**
  String get deck_info_tags_list_label;

  /// No description provided for @tags_list_oral_sex_tag.
  ///
  /// In en, this message translates to:
  /// **'oral sex'**
  String get tags_list_oral_sex_tag;

  /// No description provided for @tags_list_anal_sex_tag.
  ///
  /// In en, this message translates to:
  /// **'anal sex'**
  String get tags_list_anal_sex_tag;

  /// No description provided for @tags_list_vaginal_sex_tag.
  ///
  /// In en, this message translates to:
  /// **'vaginal sex'**
  String get tags_list_vaginal_sex_tag;

  /// No description provided for @tags_list_bondage_tag.
  ///
  /// In en, this message translates to:
  /// **'bondage'**
  String get tags_list_bondage_tag;

  /// No description provided for @tags_list_bdsm_tag.
  ///
  /// In en, this message translates to:
  /// **'BDSM'**
  String get tags_list_bdsm_tag;

  /// No description provided for @deck_info_deck_unplayable_error.
  ///
  /// In en, this message translates to:
  /// **'You can\'t play a deck without quests ! Please add some quests to this deck or select another deck to continue.'**
  String get deck_info_deck_unplayable_error;

  /// No description provided for @select_game_speed_page_title.
  ///
  /// In en, this message translates to:
  /// **'Select the game pace'**
  String get select_game_speed_page_title;

  /// No description provided for @select_game_speed_speed_1_title.
  ///
  /// In en, this message translates to:
  /// **'I\'m out of time'**
  String get select_game_speed_speed_1_title;

  /// No description provided for @select_game_speed_speed_2_title.
  ///
  /// In en, this message translates to:
  /// **'Fast & fun'**
  String get select_game_speed_speed_2_title;

  /// No description provided for @select_game_speed_speed_3_title.
  ///
  /// In en, this message translates to:
  /// **'I\'m not in a hurry'**
  String get select_game_speed_speed_3_title;

  /// No description provided for @select_game_speed_speed_4_title.
  ///
  /// In en, this message translates to:
  /// **'I want to try it all'**
  String get select_game_speed_speed_4_title;

  /// No description provided for @select_game_speed_speed_1_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Quests will only move to the next category after at least 25% of the previous category has been used.'**
  String get select_game_speed_speed_1_subtitle;

  /// No description provided for @select_game_speed_speed_2_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Quests will only move to the next category after at least 50% of the previous category has been used.'**
  String get select_game_speed_speed_2_subtitle;

  /// No description provided for @select_game_speed_speed_3_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Quests will only move to the next category after at least 75% of the previous category has been used.'**
  String get select_game_speed_speed_3_subtitle;

  /// No description provided for @select_game_speed_speed_4_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Quests will only move to the next category after all the quest of the previous category has been used.'**
  String get select_game_speed_speed_4_subtitle;

  /// No description provided for @quest_tool_female_lingerie.
  ///
  /// In en, this message translates to:
  /// **'female lingerie'**
  String get quest_tool_female_lingerie;

  /// No description provided for @quest_tool_male_lingerie.
  ///
  /// In en, this message translates to:
  /// **'male lingerie'**
  String get quest_tool_male_lingerie;

  /// No description provided for @quest_tool_blindfold.
  ///
  /// In en, this message translates to:
  /// **'blindfold'**
  String get quest_tool_blindfold;

  /// No description provided for @quest_tool_rope.
  ///
  /// In en, this message translates to:
  /// **'ropes'**
  String get quest_tool_rope;

  /// No description provided for @quest_tool_handcuffs.
  ///
  /// In en, this message translates to:
  /// **'handcuffs'**
  String get quest_tool_handcuffs;

  /// No description provided for @quest_tool_dice.
  ///
  /// In en, this message translates to:
  /// **'dice'**
  String get quest_tool_dice;

  /// No description provided for @quest_tool_vibrator.
  ///
  /// In en, this message translates to:
  /// **'vibrator'**
  String get quest_tool_vibrator;

  /// No description provided for @quest_tool_remote_vibrator.
  ///
  /// In en, this message translates to:
  /// **'remote vibrator'**
  String get quest_tool_remote_vibrator;

  /// No description provided for @quest_tool_anal_beads.
  ///
  /// In en, this message translates to:
  /// **'anal beads'**
  String get quest_tool_anal_beads;

  /// No description provided for @quest_tool_dildo.
  ///
  /// In en, this message translates to:
  /// **'dildo'**
  String get quest_tool_dildo;

  /// No description provided for @quest_tool_inflatable_dildo.
  ///
  /// In en, this message translates to:
  /// **'inflatable dildo'**
  String get quest_tool_inflatable_dildo;

  /// No description provided for @quest_tool_suction_cup_dildo.
  ///
  /// In en, this message translates to:
  /// **'suction cup dildo'**
  String get quest_tool_suction_cup_dildo;

  /// No description provided for @quest_tool_vibrating_dildo.
  ///
  /// In en, this message translates to:
  /// **'vibrating dildo'**
  String get quest_tool_vibrating_dildo;

  /// No description provided for @quest_tool_gag.
  ///
  /// In en, this message translates to:
  /// **'gag'**
  String get quest_tool_gag;

  /// No description provided for @quest_tool_feather.
  ///
  /// In en, this message translates to:
  /// **'feather'**
  String get quest_tool_feather;

  /// No description provided for @quest_tool_plug.
  ///
  /// In en, this message translates to:
  /// **'plug'**
  String get quest_tool_plug;

  /// No description provided for @quest_tool_inflatable_plug.
  ///
  /// In en, this message translates to:
  /// **'inflatable plug'**
  String get quest_tool_inflatable_plug;

  /// No description provided for @quest_tool_vibrating_plug.
  ///
  /// In en, this message translates to:
  /// **'vibrating plug'**
  String get quest_tool_vibrating_plug;

  /// No description provided for @quest_tool_candle.
  ///
  /// In en, this message translates to:
  /// **'massage candle'**
  String get quest_tool_candle;

  /// No description provided for @quest_tool_collar_and_leash.
  ///
  /// In en, this message translates to:
  /// **'collar and leash'**
  String get quest_tool_collar_and_leash;

  /// No description provided for @quest_tool_massage_oil.
  ///
  /// In en, this message translates to:
  /// **'massage oil'**
  String get quest_tool_massage_oil;

  /// No description provided for @quest_tool_lubricants.
  ///
  /// In en, this message translates to:
  /// **'lubricants'**
  String get quest_tool_lubricants;

  /// No description provided for @quest_tool_strap_on.
  ///
  /// In en, this message translates to:
  /// **'strap-on'**
  String get quest_tool_strap_on;

  /// No description provided for @quest_tool_nipple_clamps.
  ///
  /// In en, this message translates to:
  /// **'nipple clamps'**
  String get quest_tool_nipple_clamps;

  /// No description provided for @quest_tool_nipple_pump.
  ///
  /// In en, this message translates to:
  /// **'nipple pump'**
  String get quest_tool_nipple_pump;

  /// No description provided for @quest_tool_riding_crop.
  ///
  /// In en, this message translates to:
  /// **'riding crop'**
  String get quest_tool_riding_crop;

  /// No description provided for @quest_tool_flogger.
  ///
  /// In en, this message translates to:
  /// **'flogger'**
  String get quest_tool_flogger;

  /// No description provided for @quest_tool_spanking_paddle.
  ///
  /// In en, this message translates to:
  /// **'spanking paddle'**
  String get quest_tool_spanking_paddle;

  /// No description provided for @quest_tool_male_chastity_cage.
  ///
  /// In en, this message translates to:
  /// **'male chastity cage'**
  String get quest_tool_male_chastity_cage;

  /// No description provided for @quest_tool_female_chastity_cage.
  ///
  /// In en, this message translates to:
  /// **'female chastity cage'**
  String get quest_tool_female_chastity_cage;

  /// No description provided for @quest_tool_ice.
  ///
  /// In en, this message translates to:
  /// **'ice'**
  String get quest_tool_ice;

  /// No description provided for @play_page_title.
  ///
  /// In en, this message translates to:
  /// **'Your quest'**
  String get play_page_title;

  /// No description provided for @play_page_completed_button.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get play_page_completed_button;

  /// No description provided for @play_page_replace_button.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get play_page_replace_button;

  /// No description provided for @play_page_timer_label.
  ///
  /// In en, this message translates to:
  /// **'Timer'**
  String get play_page_timer_label;

  /// No description provided for @deck_list_main_page_title.
  ///
  /// In en, this message translates to:
  /// **'Manage decks'**
  String get deck_list_main_page_title;

  /// No description provided for @deck_list_main_page_default_decks_section_title.
  ///
  /// In en, this message translates to:
  /// **'Default decks'**
  String get deck_list_main_page_default_decks_section_title;

  /// No description provided for @deck_list_main_page_default_decks_section_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Read and manage the app default decks.'**
  String get deck_list_main_page_default_decks_section_subtitle;

  /// No description provided for @deck_list_main_page_custom_decks_section_title.
  ///
  /// In en, this message translates to:
  /// **'Custom decks'**
  String get deck_list_main_page_custom_decks_section_title;

  /// No description provided for @deck_list_main_page_custom_decks_section_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Create, manage and import awesome custom decks.'**
  String get deck_list_main_page_custom_decks_section_subtitle;

  /// No description provided for @deck_management_page_default_deck_list.
  ///
  /// In en, this message translates to:
  /// **'Default decks list'**
  String get deck_management_page_default_deck_list;

  /// No description provided for @deck_management_page_custom_deck_list.
  ///
  /// In en, this message translates to:
  /// **'Custom decks list'**
  String get deck_management_page_custom_deck_list;

  /// No description provided for @deck_management_page_import_error_text.
  ///
  /// In en, this message translates to:
  /// **'There was an error importing the selected deck. Please choose a valid Loverquest deck file and try again.'**
  String get deck_management_page_import_error_text;

  /// No description provided for @deck_management_press_menu_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deck_management_press_menu_delete;

  /// No description provided for @deck_management_press_menu_export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get deck_management_press_menu_export;

  /// No description provided for @deck_management_press_menu_duplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get deck_management_press_menu_duplicate;

  /// No description provided for @deck_management_press_menu_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get deck_management_press_menu_edit;

  /// No description provided for @deck_management_delete_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get deck_management_delete_dialog_title;

  /// No description provided for @deck_management_delete_dialog_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete it?'**
  String get deck_management_delete_dialog_subtitle;

  /// No description provided for @deck_management_delete_dialog_yes_button_label.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get deck_management_delete_dialog_yes_button_label;

  /// No description provided for @deck_management_delete_dialog_no_button_label.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get deck_management_delete_dialog_no_button_label;

  /// No description provided for @deck_management_page_no_decks_text.
  ///
  /// In en, this message translates to:
  /// **'Sorry, there is nothing here'**
  String get deck_management_page_no_decks_text;

  /// No description provided for @deck_management_page_not_done_yet.
  ///
  /// In en, this message translates to:
  /// **'Sorry, try to come here after the next update'**
  String get deck_management_page_not_done_yet;

  /// No description provided for @deck_summary_editor_title.
  ///
  /// In en, this message translates to:
  /// **'Deck summary info'**
  String get deck_summary_editor_title;

  /// No description provided for @deck_summary_editor_insert_text_hint.
  ///
  /// In en, this message translates to:
  /// **'Insert text here...'**
  String get deck_summary_editor_insert_text_hint;

  /// No description provided for @quest_editor_page_title.
  ///
  /// In en, this message translates to:
  /// **'Quest content'**
  String get quest_editor_page_title;

  /// No description provided for @quest_editor_page_quest_type.
  ///
  /// In en, this message translates to:
  /// **'Quest type'**
  String get quest_editor_page_quest_type;

  /// No description provided for @quest_editor_page_quest_type_early.
  ///
  /// In en, this message translates to:
  /// **'Early'**
  String get quest_editor_page_quest_type_early;

  /// No description provided for @quest_editor_page_quest_type_mid.
  ///
  /// In en, this message translates to:
  /// **'Mid'**
  String get quest_editor_page_quest_type_mid;

  /// No description provided for @quest_editor_page_quest_type_late.
  ///
  /// In en, this message translates to:
  /// **'Late'**
  String get quest_editor_page_quest_type_late;

  /// No description provided for @quest_editor_page_quest_type_end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get quest_editor_page_quest_type_end;

  /// No description provided for @quest_editor_page_quest_timer_label.
  ///
  /// In en, this message translates to:
  /// **'Time limit - minutes'**
  String get quest_editor_page_quest_timer_label;

  /// No description provided for @quest_editor_page_quest_content_label.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get quest_editor_page_quest_content_label;

  /// No description provided for @quest_editor_page_tools_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Select the tools'**
  String get quest_editor_page_tools_dialog_title;

  /// No description provided for @quest_editor_page_player_type_title.
  ///
  /// In en, this message translates to:
  /// **'Select for which player is designed'**
  String get quest_editor_page_player_type_title;

  /// No description provided for @quest_editor_page_player_type_both.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get quest_editor_page_player_type_both;

  /// No description provided for @quest_editor_page_player_type_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get quest_editor_page_player_type_male;

  /// No description provided for @quest_editor_page_player_type_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get quest_editor_page_player_type_female;

  /// No description provided for @quest_editor_page_tools_dialog_save_button_label.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get quest_editor_page_tools_dialog_save_button_label;

  /// No description provided for @deck_filter_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Select the filters'**
  String get deck_filter_dialog_title;

  /// No description provided for @deck_filter_dialog_hetero_tag.
  ///
  /// In en, this message translates to:
  /// **'Straight'**
  String get deck_filter_dialog_hetero_tag;

  /// No description provided for @deck_filter_dialog_lesbian_tag.
  ///
  /// In en, this message translates to:
  /// **'Lesbian'**
  String get deck_filter_dialog_lesbian_tag;

  /// No description provided for @deck_filter_dialog_gay_tag.
  ///
  /// In en, this message translates to:
  /// **'Gay'**
  String get deck_filter_dialog_gay_tag;

  /// No description provided for @deck_filter_dialog_all_tag.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get deck_filter_dialog_all_tag;

  /// No description provided for @deck_filter_dialog_presence_tag.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get deck_filter_dialog_presence_tag;

  /// No description provided for @deck_filter_dialog_distance_tag.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get deck_filter_dialog_distance_tag;

  /// No description provided for @deck_filter_apply_filter_button.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get deck_filter_apply_filter_button;

  /// No description provided for @settings_main_page_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_main_page_title;

  /// No description provided for @settings_main_page_language_section_label.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_main_page_language_section_label;

  /// No description provided for @settings_main_page_language_button_label.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get settings_main_page_language_button_label;

  /// No description provided for @settings_main_page_support_section_label.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settings_main_page_support_section_label;

  /// No description provided for @settings_main_page_feedback_section_label.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get settings_main_page_feedback_section_label;

  /// No description provided for @settings_main_page_donate_on_paypal_label.
  ///
  /// In en, this message translates to:
  /// **'Support us on Paypal'**
  String get settings_main_page_donate_on_paypal_label;

  /// No description provided for @settings_main_page_donate_on_buy_me_coffee_label.
  ///
  /// In en, this message translates to:
  /// **'Support us on BuyMeACoffee'**
  String get settings_main_page_donate_on_buy_me_coffee_label;

  /// No description provided for @settings_main_page_bug_report_label.
  ///
  /// In en, this message translates to:
  /// **'Report a bug'**
  String get settings_main_page_bug_report_label;

  /// No description provided for @settings_main_page_github_page_label.
  ///
  /// In en, this message translates to:
  /// **'Open the Github page'**
  String get settings_main_page_github_page_label;

  /// No description provided for @settings_main_page_credits_section_label.
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get settings_main_page_credits_section_label;

  /// No description provided for @settings_main_page_credits_label.
  ///
  /// In en, this message translates to:
  /// **'Developed with love by Herzen'**
  String get settings_main_page_credits_label;

  /// No description provided for @settings_main_page_other_section_label.
  ///
  /// In en, this message translates to:
  /// **'Misc'**
  String get settings_main_page_other_section_label;

  /// No description provided for @settings_main_page_license_label.
  ///
  /// In en, this message translates to:
  /// **'App License'**
  String get settings_main_page_license_label;

  /// No description provided for @settings_main_page_privacy_policy_label.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settings_main_page_privacy_policy_label;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'it': return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
