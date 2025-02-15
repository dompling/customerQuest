//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';

// CUSTOM FILES
//import 'package:loverquest/pages/play_pages/select_game_type_page.dart';

//------------------------------------------------------------------------------



// PLAY PAGE DEFINITION
class SelectStartPlayerPage extends StatelessWidget {

  // ACQUIRING PREVIOUS PAGE INFO
  final couple_type;

  // CLASS CONSTRUCTOR
  const SelectStartPlayerPage({super.key, required this.couple_type});

  @override
  Widget build(BuildContext context) {

    // PAGE CONTENT
    return Scaffold(

      // SCAFFOLD CONTENT
      body: SafeArea(

        // SAFE AREA CONTENT
        child: SingleChildScrollView(

          // ALIGN CONTENT
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










                //------------------------------------------------------------------------------

              ],

            ),

          ),

        ),

      ),

    );

  }

}


//------------------------------------------------------------------------------