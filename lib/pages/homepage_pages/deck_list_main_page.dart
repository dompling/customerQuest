//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';

// CUSTOM FILES
import 'package:loverquest/pages/decks_pages/deck_management_page.dart';

//------------------------------------------------------------------------------

// SELECT GAME TYPE PAGE DEFINITION
class DeckSelectionPage extends StatelessWidget {

  // CLASS CONSTRUCTOR
  const DeckSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {

    // PAGE CONTENT
    return Scaffold(

      // SCAFFOLD CONTENT
      body: SafeArea(

        // SAFE AREA CONTENT
        child: SingleChildScrollView(

          // SCROLLABLE CONTAINER CONTENT
          child: Container(

            // PAGE PADDING
              padding: EdgeInsets.all(10),

              // PAGE ALIGNMENT
              alignment: Alignment.topCenter,

              // CONTAINER CONTENT
              child: Column(

                // COLUMN CONTENT
                children: [

                  //------------------------------------------------------------------------------

                  // SPACER
                  const SizedBox(height: 45),

                  //------------------------------------------------------------------------------

                  // PAGE LOGO
                  Image.asset(
                    'assets/images/deck_choice_icon.png',
                    width: 140,
                    height: 140,
                    fit: BoxFit.contain,
                  ),

                  //------------------------------------------------------------------------------

                  // SPACER
                  const SizedBox(height: 30),

                  //------------------------------------------------------------------------------

                  // PAGE TITLE CONTAINER
                  FractionallySizedBox(

                    // DYNAMIC WIDTH
                    widthFactor: 0.8,

                    // TITLE
                    child: Text(

                      // TEXT
                      AppLocalizations.of(context)!.deck_list_main_page_title,

                      // TEXT ALIGNMENT
                      textAlign: TextAlign.center,

                      // TEXT STYLE
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,

                      ),
                    ),

                  ),

                  //------------------------------------------------------------------------------

                  // SPACER
                  const SizedBox(height: 30),

                  //------------------------------------------------------------------------------

                  // DEFAULT DECKS SECTION BUTTON BOX
                  SizedBox(

                    // WIDTH LARGE AS SCREEN
                    width: double.infinity,

                    // FIRST GAME MODE BUTTON
                    child: ElevatedButton(

                      //------------------------------------------------------------------------------

                      // BUTTON STYLE PARAMETERS
                      style: ButtonStyle(

                        // NORMAL TEXT COLOR
                        foregroundColor: WidgetStateProperty.all(
                            Theme.of(context).colorScheme.onPrimary
                        ),

                        // NORMAL BACKGROUND COLOR
                        backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.primary,
                        ),

                        // CORNERS RADIUS
                        shape:
                        WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),

                        // PADDING
                        padding: WidgetStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                        ),

                      ),

                      //------------------------------------------------------------------------------

                      // ON PRESSED CALL
                      onPressed: () {

                        // PAGE LINKER
                        Navigator.push(
                          context,
                          MaterialPageRoute(

                            // OPEN NEW PAGE
                            builder: (context) => DeckManagementPage(load_default_decks: true,),

                          ),

                        );

                      },

                      //------------------------------------------------------------------------------

                      // BUTT0N CONTENT
                      child: Row(

                        // ROW CONTENT
                        children: [

                          //------------------------------------------------------------------------------

                          // CARD ICON
                          Image.asset(
                            'assets/images/default_decks_icon.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),

                          //------------------------------------------------------------------------------

                          // SPACER
                          const SizedBox(width: 25),

                          //------------------------------------------------------------------------------

                          // COLUMN
                          Expanded(
                            child: Column(

                              // ALIGNMENT
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                // CARD TEXT
                                Text(

                                  // TEXT
                                  AppLocalizations.of(context)!.deck_list_main_page_default_decks_section_title,

                                  // TEXT STYLE
                                  style: TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                // SPACER
                                const SizedBox(height: 3),

                                // CARD TEXT
                                Text(

                                  // TEXT
                                  AppLocalizations.of(context)!.deck_list_main_page_default_decks_section_subtitle,

                                  // TEXT STYLE
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),

                              ],

                            ),

                          ),

                          //------------------------------------------------------------------------------

                          // SPACER
                          const SizedBox(width: 10),

                          //------------------------------------------------------------------------------

                          // ARROW ICON
                          Icon(

                            // ICON IMAGE
                            Icons.arrow_forward,

                            // ICON COLOR
                            color: Theme.of(context).colorScheme.onPrimary,

                          )

                          //------------------------------------------------------------------------------

                        ],

                      ),

                    ),

                  ),

                  //------------------------------------------------------------------------------

                  // SPACER
                  const SizedBox(height: 15),

                  //------------------------------------------------------------------------------

                  // SECOND GAME MODE BUTTON BOX
                  SizedBox(

                    // WIDTH LARGE AS SCREEN
                    width: double.infinity,

                    // FIRST GAME MODE BUTTON
                    child: ElevatedButton(

                      //------------------------------------------------------------------------------

                      // BUTTON STYLE PARAMETERS
                      style: ButtonStyle(

                        // NORMAL TEXT COLOR
                        foregroundColor: WidgetStateProperty.all(
                            Theme.of(context).colorScheme.onPrimary
                        ),

                        // NORMAL BACKGROUND COLOR
                        backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.primary,
                        ),

                        // CORNERS RADIUS
                        shape:
                        WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),

                        // PADDING
                        padding: WidgetStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                        ),

                      ),

                      //------------------------------------------------------------------------------

                      // ON PRESSED CALL
                      onPressed: () {

                        // PAGE LINKER
                        Navigator.push(
                          context,
                          MaterialPageRoute(

                            // OPEN NEW PAGE
                            builder: (context) => DeckManagementPage(load_default_decks: false ,),

                          ),

                        );

                      },

                      //------------------------------------------------------------------------------

                      // BUTT0N CONTENT
                      child: Row(

                        // ROW CONTENT
                        children: [

                          //------------------------------------------------------------------------------

                          // CARD ICON
                          Image.asset(
                            'assets/images/custom_decks_icon.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),

                          //------------------------------------------------------------------------------

                          // SPACER
                          const SizedBox(width: 25),

                          //------------------------------------------------------------------------------

                          // COLUMN
                          Expanded(
                            child: Column(
                              //
                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [

                                // CARD TEXT
                                Text(
                                  // TEXT
                                  AppLocalizations.of(context)!.deck_list_main_page_custom_decks_section_title,

                                  // TEXT STYLE
                                  style: TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                // SPACER
                                const SizedBox(height: 3),

                                // CARD TEXT
                                Text(
                                  // TEXT
                                  AppLocalizations.of(context)!.deck_list_main_page_custom_decks_section_subtitle,

                                  // TEXT STYLE
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),

                              ],

                            ),

                          ),

                          //------------------------------------------------------------------------------

                          // SPACER
                          const SizedBox(width: 10),

                          //------------------------------------------------------------------------------

                          // ARROW ICON
                          Icon(

                            // ICON IMAGE
                            Icons.arrow_forward,

                            // ICON COLOR
                            color: Theme.of(context).colorScheme.onPrimary,

                          )

                          //------------------------------------------------------------------------------

                        ],

                      ),

                    ),

                  ),

                  //------------------------------------------------------------------------------

                  // SPACER
                  const SizedBox(height: 30),

                  //------------------------------------------------------------------------------

                ],
              )

          ),

        ),


      ),

    );

  }

}
