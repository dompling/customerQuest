// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_splash_screen_title => 'Thank you !';

  @override
  String get app_splash_screen_content => 'Thank you for downloading _Loverquest_! We hope you enjoy our game.\n\nOur goal is to provide you with a fun, discreet, safe, and interactive experience. Our app **does not collect any personal data, does not access the Internet, and does not display ads**.\n\nWe firmly believe that intimacy should be respected. That’s why we are committed to ensuring **maximum privacy**. _Loverquest_ is an **open-source project**, so you can check the source code at any time to verify the app’s transparency and integrity for yourself.\n\nWhen playing with a partner, always remember to **respect their boundaries and never force them to do anything against their will**.\n\nThe actions suggested by the game are designed purely for fun and **do not encourage any form of coercion or sexual violence**.\n\nIf you or your partner feel uncomfortable, you can always **skip any action** you don’t like.\n\nThis project is developed on a voluntary basis and is supported by **user donations**. If you enjoy Loverquest and want to support it, consider making a donation to help us keep it running and improve it.\n\nThe _Loverquest_ team wishes you lots of fun!';

  @override
  String get app_splash_screen_close_button_label => 'Close';

  @override
  String get donation_reminder_dialog_title => 'Help us !';

  @override
  String get donation_reminder_dialog_content => 'If you enjoyed Loverquest and want to support it, consider making a donation to help us keep it running and continue improving it.';

  @override
  String get donation_reminder_dialog_donate_button_label => 'Donate';

  @override
  String get online_play_disclaimer_dialog_title => 'Warning !';

  @override
  String get online_play_disclaimer_dialog_content => 'Beware of sharing intimate material online\n\nSafety comes first. Remember that any content shared on the Internet could remain online forever, with no way to completely erase it. Avoid including personal data and make sure that the person you are playing with is trustworthy before sending any intimate material.\n\nLoverquest assumes no responsibility for any illegal activities committed online, such as the non-consensual distribution of intimate material, the sharing of child exploitation content, or other violations of the law.\n';

  @override
  String get navbar_play_button_label => 'Play';

  @override
  String get navbar_decks_button_label => 'Decks';

  @override
  String get navbar_settings_button_label => 'Settings';

  @override
  String get play_main_page_title => 'Loverquest';

  @override
  String get play_main_page_subtitle => 'Road to pleasure';

  @override
  String get play_main_page_new_game_button_label => 'New game';

  @override
  String get play_main_page_load_game_button_label => 'Load game';

  @override
  String get select_game_type_page_title => 'Select the game type';

  @override
  String get select_game_type_presence_mode_title => 'Local play';

  @override
  String get select_game_type_presence_mode_subtitle => 'Live and amazing journey with your partner.';

  @override
  String get select_game_type_distance_mode_title => 'Online play';

  @override
  String get select_game_type_distance_mode_subtitle => 'Play remotely with your partner on your favorite chat and live some magic moments together.';

  @override
  String get select_players_type_title => 'Select the players\' sex';

  @override
  String get select_players_type_hetero_couple_title => 'Straight couple';

  @override
  String get select_players_type_hetero_couple_subtitle => 'A couple whose the players have different genitals.';

  @override
  String get select_players_type_lesbian_couple_title => 'Lesbian couple';

  @override
  String get select_players_type_lesbian_couple_subtitle => 'A couple where both the players have female genitals';

  @override
  String get select_players_type_gay_couple_title => 'Gay couple';

  @override
  String get select_players_type_gay_couple_subtitle => 'A couple where both the players have male genitals ';

  @override
  String get define_players_name_page_title => 'Insert the players alias';

  @override
  String get define_players_name_player_one_label => 'Player 1';

  @override
  String get define_players_name_player_two_label => 'Player 2';

  @override
  String get define_players_name_textfield_hint_label => 'Insert the nickname...';

  @override
  String get define_players_name_error_label => 'It\'s mandatory to compile all the field';

  @override
  String get define_players_name_confirm_button => 'Confirm';

  @override
  String get select_start_player_page_title => 'Choose who will be the first player';

  @override
  String select_start_player_player_one_name(String player_1_alias) {
    return '$player_1_alias will start';
  }

  @override
  String select_start_player_player_two_name(String player_2_alias) {
    return '$player_2_alias will start';
  }

  @override
  String get select_start_player_random_player => 'Random';

  @override
  String get select_deck_page_title => 'Choose which deck you want to play';

  @override
  String get deck_language_en => 'English';

  @override
  String get deck_language_it => 'Italian';

  @override
  String get deck_language_es => 'Spanish';

  @override
  String get deck_language_de => 'German';

  @override
  String get deck_language_fr => 'French';

  @override
  String get deck_couple_type_tag_label_hetero => 'Straight';

  @override
  String get deck_couple_type_tag_label_lesbian => 'Lesbian';

  @override
  String get deck_couple_type_tag_label_gay => 'Gay';

  @override
  String get deck_couple_type_tag_label_not_spec => 'Not specified';

  @override
  String get deck_game_type_tag_label_presence => 'Local';

  @override
  String get deck_game_type_tag_label_distance => 'Online';

  @override
  String get deck_difficulty_not_specified => 'Not specified';

  @override
  String get no_tools_label => 'No tools';

  @override
  String get tools_label => 'Requires tools';

  @override
  String select_deck_time_minutes_label(int deck_requested_time) {
    return '$deck_requested_time minutes';
  }

  @override
  String get deck_info_no_tools_label => 'None';

  @override
  String get deck_info_distance_label => 'Online';

  @override
  String get deck_info_presence_label => 'Local';

  @override
  String get deck_info_couple_type_hetero => 'Straight';

  @override
  String get deck_info_couple_type_lesbian => 'Lesbian';

  @override
  String get deck_info_couple_type_gay => 'Gay';

  @override
  String get deck_info_page_title => 'Deck information';

  @override
  String get deck_info_information_name_label => 'Name: ';

  @override
  String get deck_info_information_language_label => 'Language: ';

  @override
  String get deck_info_information_game_type_label => 'Game type: ';

  @override
  String get deck_info_information_couple_type_label => 'Couple type: ';

  @override
  String get deck_info_information_timer_label => 'Time limit: ';

  @override
  String get deck_info_information_minute_label => 'minutes';

  @override
  String get deck_info_information_quest_number_label => 'Number of quests: ';

  @override
  String get deck_info_information_requested_tools_label => 'Required tools: ';

  @override
  String get deck_info_information_designated_player_label => 'Designated player: ';

  @override
  String get deck_info_information_description_label => 'Description: ';

  @override
  String get deck_info_start_game_button_label => 'Start game';

  @override
  String get deck_info_quest_list_title => 'Quest list';

  @override
  String get deck_info_quest_info_early_quest_type => 'Early quest';

  @override
  String get deck_info_quest_info_mid_quest_type => 'Mid quest';

  @override
  String get deck_info_quest_info_late_quest_type => 'Late quest';

  @override
  String get deck_info_quest_info_end_quest_type => 'End quest';

  @override
  String get deck_info_quest_info_quest_type_label => 'Type: ';

  @override
  String get quest_tool_female_lingerie => 'female lingerie';

  @override
  String get quest_tool_male_lingerie => 'male lingerie';

  @override
  String get quest_tool_blindfold => 'blindfold';

  @override
  String get quest_tool_rope => 'ropes';

  @override
  String get quest_tool_handcuffs => 'handcuffs';

  @override
  String get quest_tool_dice => 'dice';

  @override
  String get quest_tool_vibrator => 'vibrator';

  @override
  String get quest_tool_remote_vibrator => 'remote vibrator';

  @override
  String get quest_tool_anal_beads => 'anal beads';

  @override
  String get quest_tool_dildo => 'dildo';

  @override
  String get quest_tool_inflatable_dildo => 'inflatable dildo';

  @override
  String get quest_tool_suction_cup_dildo => 'suction cup dildo';

  @override
  String get quest_tool_vibrating_dildo => 'vibrating dildo';

  @override
  String get quest_tool_gag => 'gag';

  @override
  String get quest_tool_feather => 'feather';

  @override
  String get quest_tool_plug => 'plug';

  @override
  String get quest_tool_inflatable_plug => 'inflatable plug';

  @override
  String get quest_tool_vibrating_plug => 'vibrating plug';

  @override
  String get quest_tool_candle => 'massage candle';

  @override
  String get quest_tool_collar_and_leash => 'collar and leash';

  @override
  String get quest_tool_massage_oil => 'massage oil';

  @override
  String get quest_tool_lubricants => 'lubricants';

  @override
  String get quest_tool_strap_on => 'strap-on';

  @override
  String get quest_tool_nipple_clamps => 'nipple clamps';

  @override
  String get quest_tool_nipple_pump => 'nipple pump';

  @override
  String get quest_tool_riding_crop => 'riding crop';

  @override
  String get quest_tool_flogger => 'flogger';

  @override
  String get quest_tool_spanking_paddle => 'spanking paddle';

  @override
  String get quest_tool_male_chastity_cage => 'male chastity cage';

  @override
  String get quest_tool_female_chastity_cage => 'female chastity cage';

  @override
  String get quest_tool_ice => 'ice';

  @override
  String get play_page_title => 'Your quest';

  @override
  String get play_page_completed_button => 'Completed';

  @override
  String get play_page_replace_button => 'Replace';

  @override
  String get deck_list_main_page_title => 'Manage decks';

  @override
  String get deck_list_main_page_default_decks_section_title => 'Default decks';

  @override
  String get deck_list_main_page_default_decks_section_subtitle => 'Read and manage the app default decks.';

  @override
  String get deck_list_main_page_custom_decks_section_title => 'Custom decks';

  @override
  String get deck_list_main_page_custom_decks_section_subtitle => 'Create, manage and import awesome custom decks.';

  @override
  String get deck_management_page_default_deck_list => 'Default decks list';

  @override
  String get deck_management_page_custom_deck_list => 'Custom decks list';

  @override
  String get deck_management_press_menu_delete => 'Delete';

  @override
  String get deck_management_press_menu_export => 'Export';

  @override
  String get deck_management_delete_dialog_title => 'Are you sure?';

  @override
  String get deck_management_delete_dialog_subtitle => 'Do you want to delete it?';

  @override
  String get deck_management_delete_dialog_yes_button_label => 'Yes';

  @override
  String get deck_management_delete_dialog_no_button_label => 'No';

  @override
  String get deck_summary_editor_title => 'Deck summary info';

  @override
  String get deck_summary_editor_insert_text_hint => 'Insert text here...';

  @override
  String get quest_editor_page_title => 'Quest content';

  @override
  String get quest_editor_page_quest_type => 'Quest type';

  @override
  String get quest_editor_page_quest_type_early => 'Early';

  @override
  String get quest_editor_page_quest_type_mid => 'Mid';

  @override
  String get quest_editor_page_quest_type_late => 'Late';

  @override
  String get quest_editor_page_quest_type_end => 'End';

  @override
  String get quest_editor_page_quest_timer_label => 'Time limit - minutes';

  @override
  String get quest_editor_page_quest_content_label => 'Content';

  @override
  String get quest_editor_page_tools_dialog_title => 'Select the tools';

  @override
  String get quest_editor_page_player_type_title => 'Select for which player is designed';

  @override
  String get quest_editor_page_player_type_both => 'Both';

  @override
  String get quest_editor_page_player_type_male => 'Male';

  @override
  String get quest_editor_page_player_type_female => 'Female';

  @override
  String get quest_editor_page_tools_dialog_save_button_label => 'Save';

  @override
  String get deck_filter_dialog_title => 'Select the filters';

  @override
  String get deck_filter_dialog_hetero_tag => 'Straight';

  @override
  String get deck_filter_dialog_lesbian_tag => 'Lesbian';

  @override
  String get deck_filter_dialog_gay_tag => 'Gay';

  @override
  String get deck_filter_dialog_all_tag => 'All';

  @override
  String get deck_filter_dialog_presence_tag => 'Local';

  @override
  String get deck_filter_dialog_distance_tag => 'Online';

  @override
  String get deck_filter_apply_filter_button => 'Apply';

  @override
  String get settings_main_page_title => 'Settings';

  @override
  String get settings_main_page_language_section_label => 'Language';

  @override
  String get settings_main_page_language_button_label => 'Choose language';

  @override
  String get settings_main_page_support_section_label => 'Support';

  @override
  String get settings_main_page_feedback_section_label => 'Feedback';

  @override
  String get settings_main_page_donate_on_paypal_label => 'Support us on Paypal';

  @override
  String get settings_main_page_donate_on_buy_me_coffee_label => 'Support us on BuyMeACoffee';

  @override
  String get settings_main_page_bug_report_label => 'Report a bug';

  @override
  String get settings_main_page_github_page_label => 'Open the Github page';

  @override
  String get settings_main_page_credits_section_label => 'Credits';

  @override
  String get settings_main_page_credits_label => 'Developed with love by Herzen';

  @override
  String get settings_main_page_license_label => 'App license';
}
