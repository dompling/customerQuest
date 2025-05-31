//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

// CUSTOM FILES
import 'package:loverquest/logics/play_logics/01_match_data_class.dart';


import 'package:loverquest/logics/general/app_router_wrapper_classes.dart';

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

  // DEFINING THE APP STARTUP NUMBER VAR
  late int app_startup_counter;

  // INITIALIZING THE POP UP WRAPPER OBJECT
  PlayPagePopUpWrapper? pop_up_wrapper_object;


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

        // CHECKING IF THERE ARE PREVIOUS MATCH DATA
        await check_previous_data_presence();

        // LOADING THE APP PREFERENCE
        prefs = await SharedPreferences.getInstance();

        // LOADING THE APP STARTUP NUMBER
        app_startup_counter = prefs.getInt('app_startup_counter') ?? 0;

        // GETTING THE DATA FROM THE PROVIDER
        pop_up_wrapper_object = Provider.of<PlayPagePopUpWrapperProvider>(context, listen: false).wrapperData;

        // CHECKING IF THE WRAPPER OBJECT EXIST
        pop_up_wrapper_object ??= PlayPagePopUpWrapper(session_check: false);

        // CHECKING IF THE GAME WAS PLAYED A MINIMUM NUMBER OF TIMES AND IF WE ARE IN THE INSTANCE
        if (app_startup_counter > 2 && pop_up_wrapper_object!.session_check == false) {

          // SETTING THE SESSION CHECK
          pop_up_wrapper_object!.session_check = true;

          // SAVING THE SESSION CHECK
          Provider.of<PlayPagePopUpWrapperProvider>(context, listen: false).updateWrapperData(pop_up_wrapper_object);

          // CHECKING IF THE COUNTER IS DIVISIBLE FOR 3
          if (app_startup_counter % 1 == 0) {

            // AWAIT 0.2 SECONDS BEFORE LOADING THE PAGE
            await Future.delayed(Duration(milliseconds: 200));

            // SHOWING THE DONATION REMINDER PAGE
            context.push('/play/donation_reminder_page');

          } else if (app_startup_counter % 5 == 0) {

            // AWAIT 0.2 SECONDS BEFORE LOADING THE PAGE
            await Future.delayed(Duration(milliseconds: 200));

            // SHOWING THE REVIEW REMINDER DIALOG
            show_review_dialog(context);

          }

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
            AppLocalizations.of(context)!.donation_reminder_dialog_donate_button_label,

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
                AppLocalizations.of(context)!.donation_reminder_dialog_donate_button_label,

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
                    AppLocalizations.of(context)!.donation_reminder_dialog_close_button_label,

                  ),

                ),



              ],

            ),

          ],


        );

      },

    );

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
                    AppLocalizations.of(context)!.review_reminder_dialog_close_button_label,

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
                    onPressed: () async {

                      // UPDATING THE COUNTER
                      app_startup_counter++;

                      // SAVING THE UPDATED COUNTER IN THE PREFERENCES
                      await prefs.setInt('app_startup_counter', app_startup_counter);

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