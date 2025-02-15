//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';

// CUSTOM FILES
import 'package:loverquest/pages/play_pages/select_game_type_page.dart';

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

  @override
  Widget build(BuildContext context) {

    // CONTENT ENTRY
    return Scaffold(

      body: Container(

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

              //------------------------------------------------------------------------------

              // SPACER
              const SizedBox(height: 70),

              //------------------------------------------------------------------------------

              // APP LOGO
              Image.asset(
                'images/main_icon.png',
                width: 170,
                height: 170,
                fit: BoxFit.contain,
              ),

              //------------------------------------------------------------------------------

              // SPACER
              const SizedBox(height: 10),

              //------------------------------------------------------------------------------

              // TITLE
              Text(

                // TEXT
                'Loverquest',

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
                'Road to pleasure',

                // TEXT STYLE
                style: TextStyle(

                  fontSize: 19,
                  fontWeight: FontWeight.w400,

                ),

              ),

              //------------------------------------------------------------------------------

              // SPACER
              const SizedBox(height: 80),

              //------------------------------------------------------------------------------

              // BUTTON BOX
              FractionallySizedBox(

                // DYNAMIC SIZE
                widthFactor: 0.5,

                // BOX CONTENT
                child: ElevatedButton(

                  // BUTTON STYLE PARAMETERS
                  style: ButtonStyle(

                    // NORMAL TEXT COLOR
                    foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),

                    // NORMAL BACKGROUND COLOR
                    backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.secondary),

                    // MINIMUM SIZE
                    minimumSize: WidgetStateProperty.all(Size(160, 70)),

                    // PADDING
                    padding: WidgetStateProperty.all(EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15)),

                    // BORDER RADIUS
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),

                  ),

                  // ON PRESSED CALL
                  onPressed: () {

                    // PAGE LINKER
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(

                        // OPEN NEW PAGE
                        builder: (context) => SelectGameTypePage(),

                      ),

                    );

                  },

                  // BUTTON CONTENT
                  child: const Text(

                    // TEXT
                    'Nuova partita',

                    // TEXT ALIGNMENT
                    textAlign: TextAlign.center,

                    // TEXT STYLE
                    style: TextStyle(

                      fontSize: 17,
                      fontWeight: FontWeight.w500,

                    ),

                  ),

                ),

              ),

              //------------------------------------------------------------------------------

              // SPACER
              const SizedBox(height: 20),

              //------------------------------------------------------------------------------

              // BUTTON BOX
              FractionallySizedBox(

                // DYNAMIC SIZE
                widthFactor: 0.5,

                // BOX CONTENT
                child: ElevatedButton(

                  // BUTTON STYLE PARAMETERS
                  style: ButtonStyle(

                    // NORMAL TEXT COLOR
                    foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),

                    // NORMAL BACKGROUND COLOR
                    backgroundColor: WidgetStateProperty.all(Color.fromRGBO(114, 156, 163, 1)),

                    // MINIMUM SIZE
                    minimumSize: WidgetStateProperty.all(Size(160, 70)),

                    // PADDING
                    padding: WidgetStateProperty.all(EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15)),

                    // BORDER RADIUS
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),

                  ),

                  // ON PRESSED CALL
                  onPressed: () {
                    //print('Ciao ! Questa è una prova !');
                  },

                  // BUTTON CONTENT
                  child: const Text(

                    // TEXT
                    'Continua partita',

                    // TEXT ALIGNMENT
                    textAlign: TextAlign.center,

                    // TEXT STYLE
                    style: TextStyle(

                      fontSize: 17,
                      fontWeight: FontWeight.w500,

                    ),

                  ),

                ),

              ),

              //------------------------------------------------------------------------------

              // SPACER
              const SizedBox(height: 20),

              //------------------------------------------------------------------------------

            ], // Children

          ),

        )

      ),

    );

  }

}