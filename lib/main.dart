//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// CUSTOM FILES
import 'package:loverquest/pages/play_pages/play_main_page.dart';
import 'package:loverquest/pages/decks_pages/deck_list_main_page.dart';

//------------------------------------------------------------------------------



// APP ENTRY POINT
void main() {

  // FORCING STATUS BAR LIGHT THEME AND NAVBAR DARK THEME
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,                         // STATUS BAR BACKGROUND CLEAR
    statusBarIconBrightness: Brightness.light,                  // STATUS BAR WHITE ICONS
    systemNavigationBarColor: Colors.black,                     // NAVBAR BLACK BACKGROUND
    systemNavigationBarIconBrightness: Brightness.light,        // NAVBAR WHITE ICONS
  ));

  // APP START
  runApp(const MyApp());

}



//------------------------------------------------------------------------------


// APP DEFINITION
class MyApp extends StatelessWidget {

  // CLASS CONSTRUCTOR
  const MyApp({super.key});

  //
  @override
  Widget build(BuildContext context) {


    return MaterialApp(

      // HIDING DEBUG LABEL
      debugShowCheckedModeBanner: false,

      // DEFINING APP THEME
        theme : ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,                      // THEME TYPE
            primary: Colors.white10,                          // PRIMARY COLOR
            onPrimary: Colors.white,                          // ELEMENTS ON PRIMARY COLOR
            secondary: Color.fromRGBO(106, 65, 117, 1.0),        // SECONDARY COLOR
            onSecondary: Colors.white,                        // ELEMENTS ON SECONDARY COLOR
            error: Colors.red,                                // ERRORS COLOR
            onError: Colors.white,                            // ELEMENTS ON ERRORS COLOR
            surface: Colors.black,                            // APP MAIN COLOR
            onSurface: Colors.white,                          // ELEMENTS CON MAIN COLOR
          ),
        ),

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
    const MessagesPage(),
  ];

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
        destinations: const <Widget>[

          // NAVBAR PLAY PAGE SETTINGS
          NavigationDestination(
            selectedIcon: Icon(Icons.gamepad),
            icon: Icon(Icons.gamepad_outlined),
            label: 'Gioca',
          ),

          // NAVBAR DECKS PAGE SETTINGS
          NavigationDestination(
            selectedIcon: Icon(Icons.subscriptions),
            icon: Icon(Icons.subscriptions_outlined),
            label: 'Decks',
          ),

          // NAVBAR SETTINGS PAGE SETTINGS
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Impostazioni',
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





























// 📌 Notifications Page
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Page',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}



// 📌 Messages Page
class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Page',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

}
