// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get app_splash_screen_title => 'Grazie !';

  @override
  String get app_splash_screen_content => 'Ti ringraziamo per aver scaricato _Loverquest_! Speriamo che il nostro gioco ti piaccia.\n\nIl nostro obiettivo è offrirti un\'esperienza divertente, discreta, sicura e interattiva. La nostra app **non raccoglie alcun dato personale, non accede a Internet e non mostra pubblicità**.\n\nCrediamo fermamente che l\'intimità debba essere rispettata. Per questo ci impegniamo a garantirti la **massima riservatezza**. _Loverquest_ è un progetto **open source**, quindi puoi consultare in qualsiasi momento il codice sorgente per verificare in prima persona la trasparenza e la correttezza dell’app.\n\nQuando giochi con un partner, ricorda sempre di **rispettare i suoi limiti e di non forzarlo mai a fare qualcosa contro la sua volontà**. \n\nLe azioni suggerite dal gioco sono pensate esclusivamente per il divertimento e **non incoraggiano alcuna forma di coercizione o violenza sessuale**. \n\nSe tu o il tuo partner vi sentite a disagio, potete sempre **saltare qualsiasi azione** non gradita.\n\nQuesto progetto è sviluppato su base volontaria e si sostiene grazie alle **donazioni degli utenti**. Se ti piace _Loverquest_ e vuoi supportarlo, considera l’idea di fare una donazione per aiutarci a mantenerlo attivo e migliorarlo.\n\nIl team di _Loverquest_ ti augura un buon divertimento!';

  @override
  String get app_splash_screen_close_button_label => 'Chiudi';

  @override
  String get donation_reminder_dialog_title => 'Aiutaci !';

  @override
  String get donation_reminder_dialog_content => 'Se ti è piaciuto giocare a Loverquest, considerà l\'idea di fare una donazione per aiutarci mantenerlo attivo e migliorarlo.';

  @override
  String get donation_reminder_dialog_donate_button_label => 'Supportaci';

  @override
  String get online_play_disclaimer_dialog_title => 'Attenzione !';

  @override
  String get online_play_disclaimer_dialog_content => 'Attenzione alla condivisione di materiale intimo online. La sicurezza viene prima di tutto. Ricorda che qualsiasi contenuto condiviso su Internet potrebbe rimanere online per sempre, senza possibilità di essere completamente cancellato. Evita di includere dati personali e assicurati che la persona con cui stai giocando sia affidabile prima di inviare qualsiasi materiale intimo.\n\nLoverquest non si assume alcuna responsabilità per eventuali illeciti commessi online, come la diffusione non consensuale di materiale intimo, la condivisione di contenuti pedopornografici o altre violazioni della legge.';

  @override
  String get navbar_play_button_label => 'Gioca';

  @override
  String get navbar_decks_button_label => 'Mazzi';

  @override
  String get navbar_settings_button_label => 'Impostazioni';

  @override
  String get play_main_page_title => 'Loverquest';

  @override
  String get play_main_page_subtitle => 'Road to pleasure';

  @override
  String get play_main_page_new_game_button_label => 'Nuova partita';

  @override
  String get play_main_page_load_game_button_label => 'Continua partita';

  @override
  String get select_game_type_page_title => 'Scegli la modalità di gioco';

  @override
  String get select_game_type_presence_mode_title => 'Gioca in presenza';

  @override
  String get select_game_type_presence_mode_subtitle => 'Vivi un eccitante avventura assieme al tuo partner giocando assieme di persona.';

  @override
  String get select_game_type_distance_mode_title => 'Gioca a distanza';

  @override
  String get select_game_type_distance_mode_subtitle => 'Gioca assieme al tuo partner a distanza nella tua chat preferita e vivi magici momenti di coppia.';

  @override
  String get select_players_type_title => 'Seleziona il sesso dei giocatori';

  @override
  String get select_players_type_hetero_couple_title => 'Coppia etero';

  @override
  String get select_players_type_hetero_couple_subtitle => 'Una coppia in cui i partner hanno genitali differenti.';

  @override
  String get select_players_type_lesbian_couple_title => 'Coppia lesbica';

  @override
  String get select_players_type_lesbian_couple_subtitle => 'Una coppia in cui entrambi i partner hanno genitali femminili.';

  @override
  String get select_players_type_gay_couple_title => 'Coppia gay';

  @override
  String get select_players_type_gay_couple_subtitle => 'Una coppia in cui entrambi i partner hanno genitali maschili.';

  @override
  String get define_players_name_page_title => 'Inserisci gli alias dei giocatori';

  @override
  String get define_players_name_player_one_label => 'Giocatore 1';

  @override
  String get define_players_name_player_two_label => 'Giocatore 2';

  @override
  String get define_players_name_textfield_hint_label => 'Inserisci il nickname...';

  @override
  String get define_players_name_error_label => 'È necessario compilare tutti i campi';

  @override
  String get define_players_name_confirm_button => 'Conferma';

  @override
  String get select_start_player_page_title => 'Seleziona chi sarà il primo giocatore';

  @override
  String select_start_player_player_one_name(String player_1_alias) {
    return 'Inizierà $player_1_alias';
  }

  @override
  String select_start_player_player_two_name(String player_2_alias) {
    return 'Inizierà $player_2_alias';
  }

  @override
  String get select_start_player_random_player => 'Casuale';

  @override
  String get select_deck_page_title => 'Seleziona il mazzo da giocare';

  @override
  String get deck_language_en => 'Inglese';

  @override
  String get deck_language_it => 'Italiano';

  @override
  String get deck_language_es => 'Spagnolo';

  @override
  String get deck_language_de => 'Tedesco';

  @override
  String get deck_language_fr => 'Francese';

  @override
  String get deck_couple_type_tag_label_hetero => 'Etero';

  @override
  String get deck_couple_type_tag_label_lesbian => 'Lesbo';

  @override
  String get deck_couple_type_tag_label_gay => 'Gay';

  @override
  String get deck_couple_type_tag_label_not_spec => 'Non specificata';

  @override
  String get deck_game_type_tag_label_presence => 'Presenza';

  @override
  String get deck_game_type_tag_label_distance => 'Online';

  @override
  String get deck_difficulty_not_specified => 'Non specificato';

  @override
  String get no_tools_label => 'Niente strumenti';

  @override
  String get tools_label => 'Richiede strumenti';

  @override
  String select_deck_time_minutes_label(int deck_requested_time) {
    return '$deck_requested_time minuti';
  }

  @override
  String get deck_info_no_tools_label => 'Nessuno';

  @override
  String get deck_info_distance_label => 'Online';

  @override
  String get deck_info_presence_label => 'In presenza';

  @override
  String get deck_info_couple_type_hetero => 'Etero';

  @override
  String get deck_info_couple_type_lesbian => 'Lesbo';

  @override
  String get deck_info_couple_type_gay => 'Gay';

  @override
  String get deck_info_page_title => 'Informazioni sul mazzo';

  @override
  String get deck_info_information_name_label => 'Nome: ';

  @override
  String get deck_info_information_language_label => 'Lingua: ';

  @override
  String get deck_info_information_game_type_label => 'Tipologia di gioco: ';

  @override
  String get deck_info_information_couple_type_label => 'Tipo di coppia: ';

  @override
  String get deck_info_information_timer_label => 'Tempo limite:';

  @override
  String get deck_info_information_minute_label => 'minuti';

  @override
  String get deck_info_information_quest_number_label => 'Numero di quest: ';

  @override
  String get deck_info_information_requested_tools_label => 'Strumenti richiesti: ';

  @override
  String get deck_info_information_description_label => 'Descrizione: ';

  @override
  String get deck_info_start_game_button_label => 'Avvia il gioco';

  @override
  String get deck_info_quest_list_title => 'Lista delle quest';

  @override
  String get deck_info_quest_info_early_quest_type => 'Quest iniziali';

  @override
  String get deck_info_quest_info_mid_quest_type => 'Quest intermedie';

  @override
  String get deck_info_quest_info_late_quest_type => 'Quest avanzate';

  @override
  String get deck_info_quest_info_end_quest_type => 'Quest finali';

  @override
  String get deck_info_quest_info_quest_type_label => 'Tipologia: ';

  @override
  String get quest_tool_female_lingerie => 'lingerie da donna';

  @override
  String get quest_tool_male_lingerie => 'lingerie da uomo';

  @override
  String get quest_tool_blindfold => 'benda per gli occhi';

  @override
  String get quest_tool_rope => 'corde';

  @override
  String get quest_tool_handcuffs => 'manette';

  @override
  String get quest_tool_dice => 'dado';

  @override
  String get quest_tool_vibrator => 'vibratore';

  @override
  String get quest_tool_remote_vibrator => 'vibratore telecomandato';

  @override
  String get quest_tool_anal_beads => 'palline anali';

  @override
  String get quest_tool_dildo => 'dildo';

  @override
  String get quest_tool_inflatable_dildo => 'dildo gonfiabile';

  @override
  String get quest_tool_suction_cup_dildo => 'dildo con ventosa';

  @override
  String get quest_tool_vibrating_dildo => 'dildo vibrante';

  @override
  String get quest_tool_gag => 'gag';

  @override
  String get quest_tool_feather => 'piuma';

  @override
  String get quest_tool_plug => 'plug';

  @override
  String get quest_tool_inflatable_plug => 'plug gonfiabile';

  @override
  String get quest_tool_vibrating_plug => 'plug vibrante';

  @override
  String get quest_tool_candle => 'candela da massaggio';

  @override
  String get quest_tool_collar_and_leash => 'collare e guinzaglio';

  @override
  String get quest_tool_massage_oil => 'olio per masssaggi';

  @override
  String get quest_tool_lubricants => 'lubrificante intimo';

  @override
  String get quest_tool_strap_on => 'strap-on';

  @override
  String get quest_tool_nipple_clamps => 'mollette per capezzoli';

  @override
  String get quest_tool_nipple_pump => 'succhia capezzoli';

  @override
  String get quest_tool_riding_crop => 'frustino';

  @override
  String get quest_tool_flogger => 'frusta a strisce';

  @override
  String get quest_tool_spanking_paddle => 'paletta per sculacciate';

  @override
  String get quest_tool_male_chastity_cage => 'gabbia di castità maschile';

  @override
  String get quest_tool_female_chastity_cage => 'gabbia di castità femminile';

  @override
  String get play_page_title => 'La tua quest';

  @override
  String get play_page_completed_button => 'Completata';

  @override
  String get play_page_replace_button => 'Sostituisci';

  @override
  String get deck_list_main_page_title => 'Gestici i mazzi';

  @override
  String get deck_list_main_page_default_decks_section_title => 'Mazzi predefiniti';

  @override
  String get deck_list_main_page_default_decks_section_subtitle => 'Esplora e gestisci i mazzi predefiniti dell\'app.';

  @override
  String get deck_list_main_page_custom_decks_section_title => 'Mazzi personalizzati';

  @override
  String get deck_list_main_page_custom_decks_section_subtitle => 'Crea, gestici e importa fantasiosi mazzi personalizzatti.';

  @override
  String get deck_management_page_default_deck_list => 'Lista dei mazzi predefiniti';

  @override
  String get deck_management_page_custom_deck_list => 'Lista dei mazzi personalizzati';

  @override
  String get deck_management_press_menu_delete => 'Elimina';

  @override
  String get deck_management_press_menu_export => 'Esporta';

  @override
  String get deck_management_delete_dialog_title => 'Sei sicuro?';

  @override
  String get deck_management_delete_dialog_subtitle => 'Vuoi cancellarlo ?';

  @override
  String get deck_management_delete_dialog_yes_button_label => 'Si';

  @override
  String get deck_management_delete_dialog_no_button_label => 'No';

  @override
  String get deck_summary_editor_title => 'Informazioni sul mazzo';

  @override
  String get deck_summary_editor_insert_text_hint => 'Inserisci del testo...';

  @override
  String get quest_editor_page_title => 'Contenuto della quest';

  @override
  String get quest_editor_page_quest_type => 'Tipologia della quest';

  @override
  String get quest_editor_page_quest_type_early => 'Iniziale';

  @override
  String get quest_editor_page_quest_type_mid => 'Intermedia';

  @override
  String get quest_editor_page_quest_type_late => 'Avanzata';

  @override
  String get quest_editor_page_quest_type_end => 'Finale';

  @override
  String get quest_editor_page_quest_timer_label => 'Limite di tempo - minuti';

  @override
  String get quest_editor_page_quest_content_label => 'Contenuto';

  @override
  String get quest_editor_page_tools_dialog_title => 'Seleziona gli strumenti';

  @override
  String get quest_editor_page_tools_dialog_save_button_label => 'Salva';

  @override
  String get deck_filter_dialog_title => 'Seleziona i filtri';

  @override
  String get deck_filter_dialog_hetero_tag => 'Etero';

  @override
  String get deck_filter_dialog_lesbian_tag => 'Lesbo';

  @override
  String get deck_filter_dialog_gay_tag => 'Gay';

  @override
  String get deck_filter_dialog_all_tag => 'Tutti';

  @override
  String get deck_filter_dialog_presence_tag => 'Presenza';

  @override
  String get deck_filter_dialog_distance_tag => 'Online';

  @override
  String get deck_filter_apply_filter_button => 'Applica';

  @override
  String get settings_main_page_title => 'Impostazioni';

  @override
  String get settings_main_page_language_section_label => 'Lingua';

  @override
  String get settings_main_page_language_button_label => 'Seleziona la lingua';

  @override
  String get settings_main_page_support_section_label => 'Supportaci';

  @override
  String get settings_main_page_feedback_section_label => 'Assistenza';

  @override
  String get settings_main_page_donate_on_paypal_label => 'Supportaci su Paypal';

  @override
  String get settings_main_page_donate_on_buy_me_coffee_label => 'Supportaci su BuyMeACoffee';

  @override
  String get settings_main_page_bug_report_label => 'Segnala un bug';

  @override
  String get settings_main_page_github_page_label => 'Vai alla pagina Github';

  @override
  String get settings_main_page_credits_section_label => 'Crediti';

  @override
  String get settings_main_page_credits_label => 'Sviluppato con amore da Herzen';

  @override
  String get settings_main_page_license_label => 'Licenza dell\'app';
}
