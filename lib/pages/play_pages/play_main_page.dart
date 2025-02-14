//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// CUSTOM FILES
import 'package:loverquest/pages/play_pages/select_game_type_screen.dart';

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
    return Align (

      // INTERFACE ALIGNMENT
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
            SvgPicture.asset(
              'images/main_icon.svg',
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
            const SizedBox(height: 50),

            //------------------------------------------------------------------------------

            // BUTTON BOX
            SizedBox(

              // SIZE PARAMETERS
              width: 190,
              height: 55,

              // BOX CONTENT
              child: ElevatedButton(

                // BUTTON STYLE PARAMETERS
                style: ButtonStyle(

                  // NORMAL TEXT COLOR
                  foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),

                  // NORMAL BACKGROUND COLOR
                  backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.secondary),

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
            SizedBox(

              // SIZE PARAMETERS
              width: 190,
              height: 55,

              // BOX CONTENT
              child: ElevatedButton(

                // BUTTON STYLE PARAMETERS
                style: ButtonStyle(

                  // NORMAL TEXT COLOR
                  foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),

                  // NORMAL BACKGROUND COLOR
                  backgroundColor: WidgetStateProperty.all(Color.fromRGBO(114, 156, 163, 1)),

                ),

                // ON PRESSED CALL
                onPressed: () {
                  //print('Ciao ! Questa è una prova !');
                },

                // BUTTON CONTENT
                child: const Text(

                  // TEXT
                  'Continua partita',

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

    );

  }

}