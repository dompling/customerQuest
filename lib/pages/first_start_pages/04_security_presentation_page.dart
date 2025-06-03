//------------------------------------------------------------------------------
// Loverquest - https://github.com/H3rz3n/loverquest/
//
// Copyright (C) 2025 Lorenzo Maiuri & Contributors
//
// This file is part of Loverquest.
//
// Loverquest is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Loverquest is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Loverquest.  If not, see <https://www.gnu.org/licenses/>.
//
//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loverquest/l10n/app_localization.dart';
import 'package:go_router/go_router.dart';

//------------------------------------------------------------------------------

// WELCOME PAGE DEFINITION
class PresentationPrivacyPage extends StatefulWidget {

  // CLASS CONSTRUCTOR
  const PresentationPrivacyPage({super.key});

  @override
  State<PresentationPrivacyPage> createState() => PresentationPrivacyPageState();

}

// WELCOME PAGE CONTENT
class PresentationPrivacyPageState extends State<PresentationPrivacyPage> {


  // INIT STATE
  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    // PAGE CONTENT
    return Scaffold(

      // PAGE BODY
      body: SafeArea(

        // WIDGET CONTENT
        child: Container(

          // PAGE PADDING
          padding: EdgeInsets.all(10),

          // PAGE ALIGNMENT
          alignment: Alignment.center,

          // WIDGET CONTENT
          child: LayoutBuilder(

            builder: (context, constraints) {

              // SCROLLABLE CONTAINER
              return SingleChildScrollView(

                // SCROLLABLE CONTAINER CONTENT
                child: ConstrainedBox(

                  // SETTING THE MINIMUM SIZE
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    //minWidth: constraints.maxWidth,
                    maxWidth: 600,
                  ),

                  // WIDGET CONTENT
                  child: IntrinsicHeight(

                    // PAGE MAIN CONTENT
                    child: Column(

                      // VERTICAL ALIGNMENT
                      mainAxisAlignment: MainAxisAlignment.start,

                      // HORIZONTAL ALIGNMENT
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [

                        // SPACER
                        const SizedBox(height: 40),

                        //------------------------------------------------------------------------------

                        // APP LOGO
                        Image.asset(
                          'assets/images/privacy.png',
                          width: 130,
                          height: 130,
                          fit: BoxFit.contain,
                        )

                        // ANIMATION
                            .animate()
                            .fadeIn(duration: 500.ms),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(height: 30),

                        //------------------------------------------------------------------------------

                        // TITLE
                        Text(

                          // TEXT
                          AppLocalizations.of(context)!.app_presentation_privacy_page_title,

                          // TEXT ALIGNMENT
                          textAlign: TextAlign.center,

                          // TEXT STYLE
                          style: TextStyle(

                            fontSize: 30,
                            fontWeight: FontWeight.bold,

                          ),

                        )

                        // ANIMATION
                            .animate()
                            .fadeIn(duration: 500.ms, delay: 250.ms),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(height: 20),

                        //------------------------------------------------------------------------------

                        // BOX 1
                        SizedBox(

                          // WIDTH LARGE AS SCREEN
                          width: double.infinity,

                          // FIRST GAME MODE BUTTON
                          child: ElevatedButton(

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
                                EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              ),

                            ),

                            //------------------------------------------------------------------------------

                            // ON PRESSED CALL
                            onPressed: null,

                            //------------------------------------------------------------------------------

                            // BUTT0N CONTENT
                            child: Row(

                              // ROW CONTENT
                              children: [

                                //------------------------------------------------------------------------------

                                // CARD ICON
                                Image.asset(
                                  'assets/images/lock.png',
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

                                    // COLUMN ALIGNMENT
                                    crossAxisAlignment:CrossAxisAlignment.start,

                                    children: [

                                      //------------------------------------------------------------------------------

                                      // CARD TEXT
                                      Text(
                                        // TEXT
                                        AppLocalizations.of(context)!.app_presentation_privacy_page_section_1_title,

                                        // TEXT STYLE
                                        style: TextStyle(
                                          fontSize: 18.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      //------------------------------------------------------------------------------

                                      // SPACER
                                      const SizedBox(height: 3),

                                      //------------------------------------------------------------------------------

                                      // CARD TEXT
                                      Text(
                                        // TEXT
                                        AppLocalizations.of(context)!.app_presentation_privacy_page_section_1_subtitle,

                                        // TEXT STYLE
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),

                                    ],

                                  ),

                                ),

                              ],

                            ),

                          ),

                        )

                        // ANIMATION
                            .animate()
                            .fadeIn(duration: 500.ms, delay: 500.ms),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(height: 10),

                        //------------------------------------------------------------------------------

                        // BOX 2
                        SizedBox(

                          // WIDTH LARGE AS SCREEN
                          width: double.infinity,

                          // FIRST GAME MODE BUTTON
                          child: ElevatedButton(

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
                                EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              ),

                            ),

                            //------------------------------------------------------------------------------

                            // ON PRESSED CALL
                            onPressed: null,

                            //------------------------------------------------------------------------------

                            // BUTT0N CONTENT
                            child: Row(

                              // ROW CONTENT
                              children: [

                                //------------------------------------------------------------------------------

                                // CARD ICON
                                Image.asset(
                                  'assets/images/offline.png',
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

                                    // COLUMN ALIGNMENT
                                    crossAxisAlignment:CrossAxisAlignment.start,

                                    children: [

                                      //------------------------------------------------------------------------------

                                      // CARD TEXT
                                      Text(
                                        // TEXT
                                        AppLocalizations.of(context)!.app_presentation_privacy_page_section_2_title,

                                        // TEXT STYLE
                                        style: TextStyle(
                                          fontSize: 18.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      //------------------------------------------------------------------------------

                                      // SPACER
                                      const SizedBox(height: 3),

                                      //------------------------------------------------------------------------------

                                      // CARD TEXT
                                      Text(
                                        // TEXT
                                        AppLocalizations.of(context)!.app_presentation_privacy_page_section_2_subtitle,

                                        // TEXT STYLE
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),

                                    ],

                                  ),

                                ),

                              ],

                            ),

                          ),

                        )

                        // ANIMATION
                            .animate()
                            .fadeIn(duration: 500.ms, delay: 750.ms),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(height: 10),

                        //------------------------------------------------------------------------------

                        // BOX 3
                        SizedBox(

                          // WIDTH LARGE AS SCREEN
                          width: double.infinity,

                          // FIRST GAME MODE BUTTON
                          child: ElevatedButton(

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
                                EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              ),

                            ),

                            //------------------------------------------------------------------------------

                            // ON PRESSED CALL
                            onPressed: null,

                            //------------------------------------------------------------------------------

                            // BUTT0N CONTENT
                            child: Row(

                              // ROW CONTENT
                              children: [

                                //------------------------------------------------------------------------------

                                // CARD ICON
                                Image.asset(
                                  'assets/images/code.png',
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

                                    // COLUMN ALIGNMENT
                                    crossAxisAlignment:CrossAxisAlignment.start,

                                    children: [

                                      //------------------------------------------------------------------------------

                                      // CARD TEXT
                                      Text(
                                        // TEXT
                                        AppLocalizations.of(context)!.app_presentation_privacy_page_section_3_title,

                                        // TEXT STYLE
                                        style: TextStyle(
                                          fontSize: 18.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      //------------------------------------------------------------------------------

                                      // SPACER
                                      const SizedBox(height: 3),

                                      //------------------------------------------------------------------------------

                                      // CARD TEXT
                                      Text(
                                        // TEXT
                                        AppLocalizations.of(context)!.app_presentation_privacy_page_section_3_subtitle,

                                        // TEXT STYLE
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),

                                    ],

                                  ),

                                ),

                              ],

                            ),

                          ),

                        )

                        // ANIMATION
                            .animate()
                            .fadeIn(duration: 500.ms, delay: 1000.ms),

                        //------------------------------------------------------------------------------

                        Expanded(
                          child: Container(

                          ),
                        ),

                        // SPACER
                        const SizedBox(height: 20),

                        //------------------------------------------------------------------------------

                        // NAVIGATION BUTTONS ROW
                        Row (

                          // ALIGNMENT
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [

                            // GO TO PREVIOUS PAGE BUTTON BOX
                            SizedBox(

                              // BOX CONTENT
                              child: ElevatedButton(

                                // BUTTON STYLE PARAMETERS
                                style: ButtonStyle(

                                  // NORMAL TEXT COLOR
                                  foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),

                                  // NORMAL BACKGROUND COLOR
                                  backgroundColor: WidgetStateProperty.all(Color(0xFF1F172A)),

                                  // MINIMUM SIZE
                                  minimumSize: WidgetStateProperty.all(Size(50, 50)),

                                  // PADDING
                                  padding: WidgetStateProperty.all(EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5)),

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
                                  context.pop();

                                },

                                // BUTTON CONTENT
                                child: Icon(Icons.arrow_back_rounded, size: 30,),

                              ),

                            ),

                            // SPACER
                            const SizedBox(width: 20),

                            // GO TO NEXT PAGE BUTTON BOX
                            SizedBox(

                              // BOX CONTENT
                              child: ElevatedButton(

                                // BUTTON STYLE PARAMETERS
                                style: ButtonStyle(

                                  // NORMAL TEXT COLOR
                                  foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),

                                  // NORMAL BACKGROUND COLOR
                                  backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.secondary),

                                  // MINIMUM SIZE
                                  minimumSize: WidgetStateProperty.all(Size(50, 50)),

                                  // PADDING
                                  padding: WidgetStateProperty.all(EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5)),

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
                                  context.push('/presentation/web_app_presentation');

                                },

                                // BUTTON CONTENT
                                child: Icon(Icons.arrow_forward_rounded, size: 30,),

                              ),

                            ),

                          ],

                        )

                        // ANIMATION
                            .animate()
                            .fadeIn(duration: 500.ms, delay: 1250.ms),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(height: 60),


                      ],

                    ),

                  ),

                ),
              );

            },

          ),

        ),

      ),

    );

  }

}
