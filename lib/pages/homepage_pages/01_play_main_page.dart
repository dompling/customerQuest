//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

// CUSTOM FILES
import 'package:loverquest/logics/play_logics/01_match_data_class.dart';

import 'package:loverquest/logics/decks_logics/04_deck_management_class.dart';

// HIVE
import 'package:hive_flutter/hive_flutter.dart';

//------------------------------------------------------------------------------

// PLAY PAGE DEFINITION
class PlayMainPage extends StatefulWidget {

  // CLASS CONSTRUCTOR
  const PlayMainPage({super.key});

  @override
  State<PlayMainPage> createState() => _PlayMainPageState();

}

//------------------------------------------------------------------------------

// PLAY PAGE CONTENT
class _PlayMainPageState extends State<PlayMainPage> {

  //------------------------------------------------------------------------------

  // DEFINING THE PREVIOUS DATA PRESENCE VAR
  bool previous_data = false;

  // DEFINING THE APP PREFERENCE VAR
  late SharedPreferences prefs;

  // DEFINING A BLANK MATCH DATA VAR
  MatchData match_data = MatchData();

  // INITIALING THE REVIEW LINK
  String review_link = "";


  //------------------------------------------------------------------------------

  // FUNCTION TO OPEN THE LINKS IN THE DEFAULT SYSTEM BROWSER
  Future<void> open_link(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Unable to open the link: $url";
    }
  }

  //------------------------------------------------------------------------------

  // INITIAL PAGE STATE
  @override
  void initState()  {
    super.initState();

    // AFTER THE FIRST FRAME HAS BEEN DRAW
    WidgetsBinding.instance.addPostFrameCallback((_) {

      Future.microtask(() async {

        // CHECKING IF WE ARE USING THE WEB APP
        if (kIsWeb) {

          // SETTING THE REVIEW LINK
          review_link = "https://forms.gle/gwVRFa3ijNok9TdQ8";

        } else {

          // SETTING THE REVIEW LINK
          review_link = "https://play.google.com/store/apps/details?id=com.herzen.loverquest.app&reviewId=0";

        }

        // LOADING THE APP PREFERENCE
        prefs = await SharedPreferences.getInstance();

        // CHECKING IF THERE ARE PREVIOUS MATCH DATA
        await check_previous_data_presence();

        // CHECKING IF IS NECESSARY TO SHOW THE SPLASH SCREEN
        await check_splash_screen();

        // CHECKING IF IS NECESSARY TO SHOW THE DONATION REMINDER
        await check_donation_reminder();

        // CHECKING IF IS NECESSARY TO SHOW THE REVIEW REMINDER
        await check_review_reminder();

        // CONVERTING LEGACY DECKS ON ANDROID IF THEY EXISTS
        if (!kIsWeb) {

          await DeckManagement.convert_legacy_custom_decks_to_hive();

        }

      });
    });

  }

  // FUNCTION TO CHECK IF PREVIOUS MATCH DATA EXIST
  Future<void> check_previous_data_presence() async {

    // GETTING THE FILE
    final box = await Hive.openBox('matchDataBox');

    // CHECKING IF THE FILE EXIST
    if (box.containsKey('match')) {
      if (!mounted) return;
      setState(() {
        previous_data = true;
      });
    }

  }

  //------------------------------------------------------------------------------

  // CHECKING IF IS THE FIRST TIME THAT THE APP IS OPENED IN ORDER TO SHOW THE SPLASH SCREEN
  Future<void> check_splash_screen () async {

    // GETTING THE SPLASH SCREEN PREFERENCE, IF THERE ARE NOT SETTING IT TO ZERO
    bool show_splash_screen = prefs.getBool('show_splash_screen') ?? true;

    // CHECKING IF IS NECESSARY TO SHOW THE SPLASH SCREEN
    if (show_splash_screen) {

      // SHOWING THE SPLASH SCREEN
      show_splash_screen_dialog(context);

      // SETTING THE SPLASH SCREEN AS SHOWED
      await prefs.setBool('show_splash_screen', false);

    }

  }

  // APP SPLASH SCREEN DIALOG
  void show_splash_screen_dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        //------------------------------------------------------------------------------

        // DIALOG DEFINITION
        return Dialog(

          // DIALOG CONTENT
          child: ConstrainedBox(

            // SETTING MAX DIMENSIONS
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
              maxWidth: 500,
            ),

            // MAKING CONTENT SCROLLABLE IF NECESSARY
            child: SingleChildScrollView(

              // PAGE PADDING
              child: Padding(
                padding: EdgeInsets.all(15),

                // PAGE CONTENT
                child: Column(

                  // SIZE
                  mainAxisSize: MainAxisSize.min,

                  // ALIGNMENT
                  crossAxisAlignment: CrossAxisAlignment.center,

                  // COLUMN CONTENT
                  children: [

                    //------------------------------------------------------------------------------

                    // DIALOG TITLE
                    Text(

                      // TEXT
                      AppLocalizations.of(context)!.app_splash_screen_title,

                      // ALIGNMENT
                      textAlign: TextAlign.center,

                      // STYLE
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),

                    ),

                    //------------------------------------------------------------------------------

                    // DIALOG CONTENT
                    Markdown(

                      // LETTING THE CONTAINER TO ADAPT THE CONTENT
                      shrinkWrap: true,

                      // TEXT
                      data: AppLocalizations.of(context)!.app_splash_screen_content,

                      // DISABLING INTERNAL SCROLLING
                      physics: NeverScrollableScrollPhysics(),

                      // STYLE
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(fontSize: 16, color: Colors.white),
                        strong: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        em: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.white70),
                        blockquote: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),
                      ),

                    ),

                    //------------------------------------------------------------------------------

                    // SPACER
                    SizedBox(height: 15),

                    //------------------------------------------------------------------------------

                    // EXIT BUTTON
                    TextButton(

                      // STYLE
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(
                            Theme.of(context).colorScheme.onPrimary),
                        backgroundColor: WidgetStateProperty.all(
                            Theme.of(context).colorScheme.secondary),
                        padding: WidgetStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),

                      // FUNCTION
                      onPressed: () => Navigator.of(context).pop(),

                      // BUTTON CONTENT
                      child: Text(

                        // TEXT
                        AppLocalizations.of(context)!.app_splash_screen_close_button_label,

                      ),

                    ),

                    //------------------------------------------------------------------------------

                  ],

                ),

              ),

            ),

          ),

        );

      },

    );

  }

  //------------------------------------------------------------------------------

  // INCREASING THE PLAYED GAME COUNTER IN THE PREFERENCES
  Future<void> increasing_played_game_counter() async {

    // LOADING THE APP PREFERENCES
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // GETTING THE PLAYED GAMES NUMBER, IF THERE ARE NOT SETTING IT TO ZERO
    int played_games = prefs.getInt('played_games') ?? 1;

    // INCREASING THE COUNTER
    played_games = played_games +1;

    // SAVING THE COUNTER IN THE PREFERENCES
    await prefs.setInt('played_games', played_games);

  }

  // CHECKING IF THE USER HAS PLAYED ENOUGH GAME TO SHOW A DONATION REMINDER
  Future<void> check_donation_reminder() async {

    // GETTING THE PLAYED GAMES NUMBER, IF THERE ARE NOT SETTING IT TO ZERO
    int played_games = prefs.getInt('played_games') ?? 1;

    // CHECKING IF THE USER HAS PLAYED A NUMBER OF MATCH THAT IS DIVISIBLE BY 3
    if (played_games % 3 == 0) {

      // SHOWING THE DONATION REMINDER DIALOG
      show_donation_dialog(context);

    }

  }

  // DONATION REMINDER DIALOG
  void show_donation_dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        // DIALOG
        return AlertDialog(

          // DIALOG TITLE
          title: Text(

            // TEXT
            AppLocalizations.of(context)!.donation_reminder_dialog_title,

            // ALIGNMENT
            textAlign: TextAlign.center,

            // STYLE
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),

          ),

          // DIALOG CONTENT
          content: Container(

            // SETTING THE WIDTH LIMIT
            constraints: BoxConstraints(maxWidth: 500),

            // CONTAINER CONTENT
            child: SingleChildScrollView(

              child: Text(

                // TEXT
                AppLocalizations.of(context)!.donation_reminder_dialog_content,

                // ALIGNMENT
                textAlign: TextAlign.center,

                // STYLE
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                ),

              ),

            ),

          ),

          // DIALOG BUTTONS
          actions: [

            // BUTTON ROW
            Row(

              // ALIGN
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              // ROW CONTENT
              children: [

                // DONATE BUTTON
                TextButton(

                  // STYLE
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.onPrimary),
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.secondary),
                    padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),

                  // FUNCTION
                  onPressed: () => open_link("https://github.com/H3rz3n/loverquest/tree/main?tab=readme-ov-file#how-can-i-support-the-project"),

                  // BUTTON CONTENT
                  child: Text(

                    // TEXT
                    AppLocalizations.of(context)!.donation_reminder_dialog_donate_button_label,

                  ),

                ),

                // EXIT BUTTON
                TextButton(

                  // STYLE
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.onPrimary),
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                    padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),

                  // FUNCTION
                  onPressed: () => Navigator.of(context).pop(),

                  // BUTTON CONTENT
                  child: Text(

                    // TEXT
                    AppLocalizations.of(context)!.app_splash_screen_close_button_label,

                  ),

                ),



              ],

            ),

          ],


        );

      },

    );

  }

  // CHECKING IF THE USER HAS PLAYED ENOUGH GAME TO SHOW A REVIEW REMINDER
  Future<void> check_review_reminder() async {

    // GETTING THE PLAYED GAMES NUMBER, IF THERE ARE NOT SETTING IT TO ZERO
    int played_games = prefs.getInt('played_games') ?? 1;

    // CHECKING IF THE USER HAS PLAYED A NUMBER OF MATCH THAT IS DIVISIBLE BY 3
    if (played_games % 5 == 0) {

      // SHOWING THE DONATION REMINDER DIALOG
      show_review_dialog(context);

    }

  }

  // REVIEW REMINDER DIALOG
  void show_review_dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        // DIALOG
        return AlertDialog(

          // DIALOG TITLE
          title: Text(

            // TEXT
            AppLocalizations.of(context)!.review_reminder_dialog_title,

            // ALIGNMENT
            textAlign: TextAlign.center,

            // STYLE
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),

          ),

          // DIALOG CONTENT
          content: Container(

            // SETTING THE WIDTH LIMIT
            constraints: BoxConstraints(maxWidth: 500),

            // CONTAINER CONTENT
            child: SingleChildScrollView(

              child: Text(

                // TEXT
                AppLocalizations.of(context)!.review_reminder_dialog_content,

                // ALIGNMENT
                textAlign: TextAlign.center,

                // STYLE
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                ),

              ),

            ),

          ),

          // DIALOG BUTTONS
          actions: [

            // BUTTON ROW
            Row(

              // ALIGN
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              // ROW CONTENT
              children: [

                // DONATE BUTTON
                TextButton(

                  // STYLE
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.onPrimary),
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.secondary),
                    padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),

                  // FUNCTION
                  onPressed: () => open_link(review_link),

                  // BUTTON CONTENT
                  child: Text(

                    // TEXT
                    AppLocalizations.of(context)!.review_reminder_dialog_review_button_label,

                  ),

                ),

                // EXIT BUTTON
                TextButton(

                  // STYLE
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.onPrimary),
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                    padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),

                  // FUNCTION
                  onPressed: () => Navigator.of(context).pop(),

                  // BUTTON CONTENT
                  child: Text(

                    // TEXT
                    AppLocalizations.of(context)!.app_splash_screen_close_button_label,

                  ),

                ),



              ],

            ),

          ],


        );

      },

    );

  }

  //------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    // CONTENT ENTRY
    return Scaffold(

      // PAGE CONTENT
      body: SafeArea(

        // SAFE AREA CONTENT
        child: Container(

          // PAGE PADDING
          padding: EdgeInsets.all(10),

          // PAGE ALIGNMENT
          alignment: Alignment.topCenter,

          // SCROLLABLE CONTAINER
          child: SingleChildScrollView(

            // MAIN COLUMN
            child: Column(

              // SIZE PARAMETERS
              mainAxisSize: MainAxisSize.max,

              // COLUMN CONTENT
              children: [

                // SPACER
                const SizedBox(height: 80),

                //------------------------------------------------------------------------------

                // APP LOGO
                Image.asset(
                  'assets/images/main_icon.png',
                  width: 180,
                  height: 180,
                  fit: BoxFit.contain,
                ),

                //------------------------------------------------------------------------------

                // SPACER
                const SizedBox(height: 30),

                //------------------------------------------------------------------------------

                // TITLE
                Text(

                  // TEXT
                  AppLocalizations.of(context)!.play_main_page_title,

                  // TEXT ALIGNMENT
                  textAlign: TextAlign.center,

                  // TEXT STYLE
                  style: TextStyle(

                    fontSize: 46,
                    fontWeight: FontWeight.bold,

                  ),

                ),

                //------------------------------------------------------------------------------

                // SUBTITLE
                Text(

                  // TEXT
                  AppLocalizations.of(context)!.play_main_page_subtitle,

                  // TEXT ALIGNMENT
                  textAlign: TextAlign.center,

                  // TEXT STYLE
                  style: TextStyle(

                    fontSize: 19,
                    fontWeight: FontWeight.w400,

                  ),

                ),

                //------------------------------------------------------------------------------

                // SPACER
                const SizedBox(height: 100),

                //------------------------------------------------------------------------------

                // NEW GAME BUTTON BOX
                SizedBox(

                  // DYNAMIC SIZE
                  width: 180,

                  // BOX CONTENT
                  child: ElevatedButton(

                    // BUTTON STYLE PARAMETERS
                    style: ButtonStyle(

                      // NORMAL TEXT COLOR
                      foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),

                      // NORMAL BACKGROUND COLOR
                      backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.secondary),

                      // MINIMUM SIZE
                      minimumSize: WidgetStateProperty.all(Size(100, 60)),

                      // PADDING
                      padding: WidgetStateProperty.all(EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15)),

                      // BORDER RADIUS
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),

                    ),

                    // ON PRESSED CALL
                    onPressed: () {

                      // INCREASING THE PLAYED GAME COUNTER
                      increasing_played_game_counter();

                      // RESETTING THE MATCH DATA INSIDE THE PROVIDER
                      Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(null);

                      // PAGE LINKER
                      context.push('/play/game_type');

                    },

                    // BUTTON CONTENT
                    child: Text(

                      // TEXT
                      AppLocalizations.of(context)!.play_main_page_new_game_button_label,

                      // TEXT ALIGNMENT
                      textAlign: TextAlign.center,

                      // TEXT STYLE
                      style: TextStyle(

                        fontSize: 15,
                        fontWeight: FontWeight.w500,

                      ),

                    ),

                  ),

                ),

                //------------------------------------------------------------------------------

                // SPACER
                const SizedBox(height: 15),

                //------------------------------------------------------------------------------

                // LOAD GAME BUTTON BOX
                if (previous_data) SizedBox(

                  // DYNAMIC SIZE
                  width: 180,

                  // BOX CONTENT
                  child: ElevatedButton(

                    // BUTTON STYLE PARAMETERS
                    style: ButtonStyle(

                      // NORMAL TEXT COLOR
                      foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),

                      // NORMAL BACKGROUND COLOR
                      backgroundColor: WidgetStateProperty.all(Color.fromRGBO(65, 95, 117, 1.0)),

                      // MINIMUM SIZE
                      minimumSize: WidgetStateProperty.all(Size(100, 60)),

                      // PADDING
                      padding: WidgetStateProperty.all(EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15)),

                      // BORDER RADIUS
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),

                    ),

                    // ON PRESSED CALL
                    onPressed: () async {

                      // DEFINING THE HIVE BOX
                      Box matchBox;

                      // CHECKING IF THE BOX WAS PREVIOUSLY OPENED
                      if (Hive.isBoxOpen('matchdatabox')) {

                        // LOADING THE PREVIOUSLY OPENED INSTANCE
                        matchBox = Hive.box('matchdatabox');

                      } else {

                        // OPENING A NEW INSTANCE
                        matchBox = await Hive.openBox('matchdatabox');

                      }

                      // LOADING FROM FILE FILE MATCH DATA
                      match_data = matchBox.get('match') ?? MatchData();

                      // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                      Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(match_data);

                      // PAGE LINKER
                      context.go('/play/game', extra: match_data);

                    },

                    // BUTTON CONTENT
                    child: Text(

                      // TEXT
                      AppLocalizations.of(context)!.play_main_page_load_game_button_label,

                      // TEXT ALIGNMENT
                      textAlign: TextAlign.center,

                      // TEXT STYLE
                      style: TextStyle(

                        fontSize: 15,
                        fontWeight: FontWeight.w500,

                      ),

                    ),

                  ),

                ) else SizedBox.shrink(),

                //------------------------------------------------------------------------------

                // SPACER
                const SizedBox(height: 20),

                //------------------------------------------------------------------------------

              ], // Children

            ),

          )

        ),

      )

    );

  }

}