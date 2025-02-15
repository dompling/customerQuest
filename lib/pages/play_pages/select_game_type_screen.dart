//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';

//------------------------------------------------------------------------------

// SELECT GAME TYPE PAGE DEFINITION
class SelectGameTypePage extends StatelessWidget {
  // CLASS CONSTRUCTOR
  const SelectGameTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    // WIDGET CONTENT
    return Scaffold(
      // CENTER CONTENT
      body: SafeArea(
        child: Align(
          // INTERFACE ALIGNMENT
          alignment: Alignment.topCenter,

          // ALIGN CONTENT
          child: SingleChildScrollView(
            // SCROLLABLE CONTAINER CONTENT
            child: Container(

                // SETTING CONTAINER PADDING
                padding: EdgeInsets.all(10),

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
                      'images/select_game_mode_icon.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 30),

                    //------------------------------------------------------------------------------

                    // TITLE
                    Text(
                      // TEXT
                      'Scegli la modalità di gioco',

                      // TEXT STYLE
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 30),

                    //------------------------------------------------------------------------------

                    // FIRST GAME MODE BUTTON BOX
                    SizedBox(

                      //
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
                            EdgeInsets.symmetric(horizontal: 25, vertical: 25), // Padding interno
                          ),

                        ),

                        //------------------------------------------------------------------------------

                        // ON PRESSED CALL
                        onPressed: () {
                          //print('Ciao ! Questa è una prova !');
                        },

                        //------------------------------------------------------------------------------

                        // BUTT0N CONTENT
                        child: Row(

                              // ROW CONTENT
                              children: [

                                //------------------------------------------------------------------------------

                                // CARD ICON
                                Image.asset(
                                  'images/play_presence_icon.png',
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
                                        'Gioca in presenza',

                                        // TEXT STYLE
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      // SPACER
                                      const SizedBox(height: 3),

                                      // CARD TEXT
                                      Text(
                                        // TEXT
                                        'Vivi un eccitante avventura assieme al tuo partner giocando assieme di persona.',
                                        maxLines: 3,
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
                              ],

                            ),

                        //------------------------------------------------------------------------------

                        ),

                      ),

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 15),

                    //------------------------------------------------------------------------------

                    // SECOND GAME MODE BUTTON BOX
                    SizedBox(

                      //
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
                            EdgeInsets.symmetric(horizontal: 25, vertical: 25), // Padding interno
                          ),

                        ),

                        //------------------------------------------------------------------------------

                        // ON PRESSED CALL
                        onPressed: () {
                          //print('Ciao ! Questa è una prova !');
                        },

                        //------------------------------------------------------------------------------

                        // BUTT0N CONTENT
                        child: Row(

                          // ROW CONTENT
                          children: [

                            //------------------------------------------------------------------------------

                            // CARD ICON
                            Image.asset(
                              'images/play_distance_icon.png',
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
                                    'Gioca a distanza',

                                    // TEXT STYLE
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  // SPACER
                                  const SizedBox(height: 3),

                                  // CARD TEXT
                                  Text(
                                    // TEXT
                                    'Gioca assieme al tuo partner a distanza nella tua chat preferita e vivi magici momenti di coppia.',
                                    maxLines: 3,
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
                          ],

                        ),

                        //------------------------------------------------------------------------------

                      ),

                    ),

                    //------------------------------------------------------------------------------

                  ],
                )

            ),

          ),

        ),

      ),

    );

  }

}
