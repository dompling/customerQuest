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
              const SizedBox(height: 100),

              //------------------------------------------------------------------------------

              // BUTTON BOX
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
                    minimumSize: WidgetStateProperty.all(Size(160, 60)),

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

              // BUTTON BOX
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

                      fontSize: 15,
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