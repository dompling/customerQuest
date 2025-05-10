//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loverquest/logics/decks_logics/01_deck_reader_class.dart';
import 'package:loverquest/logics/play_logics/01_match_data_class.dart';
import 'package:loverquest/logics/play_logics/02_players_class.dart';
import 'package:provider/provider.dart';
import 'package:loverquest/l10n/app_localization.dart';
import 'package:loverquest/logics/settings_logics/01_language_switch.dart';

// CUSTOM FILES
import 'package:loverquest/pages/homepage_pages/01_play_main_page.dart';
import 'package:loverquest/pages/homepage_pages/02_decks_main_page.dart';
import 'package:loverquest/pages/homepage_pages/03_settings_main_page.dart';

// HIVE
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loverquest/logics/decks_logics/02_deck_summary_class.dart';
import 'package:loverquest/logics/decks_logics/03_quest_class.dart';

//------------------------------------------------------------------------------



// APP ENTRY POINT
void main() async {

  // FORCING STATUS BAR LIGHT THEME AND NAVBAR DARK THEME
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,                         // STATUS BAR BACKGROUND CLEAR
    statusBarIconBrightness: Brightness.light,                  // STATUS BAR WHITE ICONS
    systemNavigationBarColor: Colors.black,                     // NAVBAR BLACK BACKGROUND
    systemNavigationBarIconBrightness: Brightness.light,        // NAVBAR WHITE ICONS
  ));

  WidgetsFlutterBinding.ensureInitialized();

  // HIVE LOADING
  await Hive.initFlutter();
  Hive.registerAdapter(DeckSummaryAdapter());
  Hive.registerAdapter(QuestAdapter());
  Hive.registerAdapter(PlayersAdapter());
  Hive.registerAdapter(MatchDataAdapter());
  Hive.registerAdapter(DeckReaderAdapter());

  // PREPARING THE LOCALE FUNCTION
  final localeProvider = LocaleProvider();
  await localeProvider.loadLocale();

  // APP START
  runApp(
    ChangeNotifierProvider(
      create: (context) => localeProvider,
      child: MyApp(),
    ),
  );

}



//------------------------------------------------------------------------------

// SETTING THE WEB VERSION TITLE
void setWebTitle(String title) {
  SystemChrome.setApplicationSwitcherDescription(
    ApplicationSwitcherDescription(
      label: "Loverquest",
      primaryColor: 0xFF000000,
    ),
  );
}

//------------------------------------------------------------------------------

// APP WRAPPER - GLOBAL UI MANAGEMENT
class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});


  // CLASS CONSTRUCTOR
  @override
  AppWrapperState createState() => AppWrapperState();

}



//------------------------------------------------------------------------------



// APP WRAPPER - MAIN STATE
class AppWrapperState extends State<AppWrapper> with WidgetsBindingObserver {

  // VARIABLE TO MANAGE THE TRANSPARENT OVERLAY
  OverlayEntry? _overlayEntry;

  @override
  void initState() {

    // INITIALIZE STATE AND REGISTER LIFECYCLE OBSERVER
    super.initState();
    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void dispose() {

    // REMOVE LIFECYCLE OBSERVER BEFORE DESTROYING THE WIDGET
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    // CHECK IF THE APP RETURNS TO FOREGROUND
    if (state == AppLifecycleState.resumed) {

      // ACTIVATE OVERLAY TO FORCE REPAINT
      _showOverlay();

    }

  }

  //------------------------------------------------------------------------------


  // FUNCTION TO CREATE AND HANDLE TRANSPARENT OVERLAY
  void _showOverlay() {

    // GET THE ACTIVE OVERLAY
    final overlay = Overlay.of(context);

    // CREATE TRANSPARENT OVERLAY LAYER
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Container(color: Colors.transparent), // FORCES REPAINT WITHOUT AFFECTING UI
      ),
    );

    // INSERT THE OVERLAY INTO THE TOP LAYER OF THE APP
    overlay.insert(_overlayEntry!);

    // AUTOMATICALLY REMOVE THE OVERLAY AFTER 50ms TO AVOID VISIBLE IMPACT
    Future.delayed(Duration(milliseconds: 50), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });

  }

  //------------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {

    // RETURN THE NORMAL APP WITHOUT MODIFICATIONS
    return MyApp();

  }

}



//------------------------------------------------------------------------------



// APP DEFINITION
class MyApp extends StatelessWidget {

  // CLASS CONSTRUCTOR
  const MyApp({super.key});

  // APP CONTENT START
  @override
  Widget build(BuildContext context) {

    // INITIALIZATION OF THE LOCALE INFORMATION
    final localeProvider = Provider.of<LocaleProvider>(context);

    // APP MAIN SETTINGS
    return MaterialApp(

      // APP TITLE
      title: 'Loverquest',

      // HIDING DEBUG LABEL
      debugShowCheckedModeBanner: false,

      // DEFINING APP THEME
      theme : ThemeData(

        // APP FONT
        fontFamily: 'Roboto',

        // APP GENERAL THEME
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,                      // THEME TYPE
          primary: Colors.white10,                          // PRIMARY COLOR
          onPrimary: Colors.white,                          // ELEMENTS ON PRIMARY COLOR
          secondary: Color.fromRGBO(106, 65, 117, 1.0),     // SECONDARY COLOR
          onSecondary: Colors.white,                        // ELEMENTS ON SECONDARY COLOR
          error: Colors.red,                                // ERRORS COLOR
          onError: Colors.white,                            // ELEMENTS ON ERRORS COLOR
          surface: Colors.black,                            // APP MAIN COLOR
          onSurface: Colors.white,                          // ELEMENTS CON MAIN COLOR
        ),

        // POP-UP MENU THEME
        popupMenuTheme: PopupMenuThemeData(

          // BACKGROUND COLOR
          color: Colors.grey[900],

          //BORDER SETTINGS
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),

          // TEXT STYLE
          textStyle: TextStyle(color: Colors.white),

        ),

        // ALERT DIALOG THEME
        dialogTheme: DialogTheme(

          // BACKGROUND COLOR
          backgroundColor: Colors.grey[900],

          //BORDER SETTINGS
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),

          // TEXT STYLE
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),

        ),

        ),

      // LOADING THE LOCALE INFO
      locale: localeProvider.locale,

      // LIST OF THE SUPPORTED LOCALIZATION
      supportedLocales: [
        Locale('en', ''),
        Locale('it', ''),
        Locale('es', ''),
        Locale('fr', ''),
        Locale('de', ''),
        Locale('nl', ''),
      ],

      // LOADING THE TRANSLATION
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // DEFINING THE MAIN SCREEN
      home: const MainScreen(),

    );

  }

}



//------------------------------------------------------------------------------



// MAIN SCREEN DEFINITION
class MainScreen extends StatefulWidget {

  // CLASS CONSTRUCTOR
  const MainScreen({super.key});

  @override

  // DEFINING PAGE LINKED STATE
  State<MainScreen> createState() => _MainScreenState();

}



//------------------------------------------------------------------------------



// MAIN SCREEN CONTENT - MAIN SCREEN STATE
class _MainScreenState extends State<MainScreen> {

  // DEFINING NAVBAR PAGES INDEX
  int currentPageIndex = 0;

  // LIST OF NAVBAR MAIN SCREEN PAGES
  final List<Widget> _screens = [
    const PlayMainPage(),
    const DeckSelectionPage(),
    const SettingsMainPage(),
  ];

  // INITIAL PAGE STATE
  @override
  void initState() {
    super.initState();

    // SETTING THE WEB TITLE
    setWebTitle("none");

  }

  @override
  Widget build(BuildContext context) {

    // SCAFFOLD ENTRY POINT
    return Scaffold(

      //------------------------------------------------------------------------------

      // DEFINING NAVBAR
      bottomNavigationBar: NavigationBar(

        // NAVBAR PAGES SWITCH
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },

        // DEFINING NAVBAR THEME
        indicatorColor: Theme.of(context).colorScheme.primary,

        // DEFINING NAVBAR PAGE SELECTION
        selectedIndex: currentPageIndex,

        // DEFINING NAVBAR ITEMS
        destinations: <Widget>[

          // NAVBAR PLAY PAGE SETTINGS
          NavigationDestination(
            selectedIcon: Icon(Icons.gamepad),
            icon: Icon(Icons.gamepad_outlined),
            label: AppLocalizations.of(context)!.navbar_play_button_label,
          ),

          // NAVBAR DECKS PAGE SETTINGS
          NavigationDestination(
            selectedIcon: Icon(Icons.subscriptions),
            icon: Icon(Icons.subscriptions_outlined),
            label: AppLocalizations.of(context)!.navbar_decks_button_label,
          ),

          // NAVBAR SETTINGS PAGE SETTINGS
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: AppLocalizations.of(context)!.navbar_settings_button_label,
          ),

        ],

      ),

      //------------------------------------------------------------------------------

      // DEFINING BODY CONTENT
      body: SafeArea(child: _screens[currentPageIndex],),

      //------------------------------------------------------------------------------

    );

  }

}



//------------------------------------------------------------------------------