//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';

//------------------------------------------------------------------------------



// SELECT GAME TYPE PAGE DEFINITION
class SelectGameTypePage extends StatelessWidget  {

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
              padding: EdgeInsets.all(15),

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
                   'images/player_selection_icon.png',
                   width: 170,
                   height: 170,
                   fit: BoxFit.contain,
                 ),

                 //------------------------------------------------------------------------------

                 // SPACER
                 const SizedBox(height: 30),

                 //------------------------------------------------------------------------------

                 // TITLE
                 Text(

                   // TEXT
                   'Definisci i giocatori',

                   // TEXT STYLE
                   style: TextStyle(

                     fontSize: 29,
                     fontWeight: FontWeight.bold,

                   ),

                 ),

                 //------------------------------------------------------------------------------

                 // SPACER
                 const SizedBox(height: 30),

                 //------------------------------------------------------------------------------

                 // PLAYER ONE CARD
                 Card(

                   // BACKGROUND COLOR
                   color: Theme.of(context).colorScheme.primary,

                   // CARD CONTENT
                   child: Column(

                     // COLUMN CONTENT
                     children: [

                       // TITLE
                       Text(

                         // TEXT
                         'Giocatore 1 :',

                         // TEXT STYLE
                         style: TextStyle(

                           fontSize: 20,
                           fontWeight: FontWeight.normal,

                         ),

                       ),



                     ],

                   ),

                 ),

                 //------------------------------------------------------------------------------

                 // SPACER
                 const SizedBox(height: 10),

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
