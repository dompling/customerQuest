//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';
import 'package:go_router/go_router.dart';

//------------------------------------------------------------------------------

// DONATION PAGE DEFINITION
class OnlineSafetyReminderPage extends StatefulWidget {

  // CLASS CONSTRUCTOR
  const OnlineSafetyReminderPage({super.key});

  @override
  State<OnlineSafetyReminderPage> createState() => OnlineSafetyReminderPageState();

}

// DONATION PAGE CONTENT
class OnlineSafetyReminderPageState extends State<OnlineSafetyReminderPage> {

  @override
  Widget build(BuildContext context) {

    // PAGE CONTENT
    return Scaffold(

      // APP BAR
      appBar: AppBar(),

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

                        // APP LOGO
                        Image.asset(
                          'assets/images/warning.png',
                          width: 120,
                          height: 120,
                          fit: BoxFit.contain,
                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(height: 30),

                        //------------------------------------------------------------------------------

                        // TITLE
                        Text(

                          // TEXT
                          AppLocalizations.of(context)!.online_safety_reminder_page_title,

                          // TEXT ALIGNMENT
                          textAlign: TextAlign.center,

                          // TEXT STYLE
                          style: TextStyle(

                            fontSize: 30,
                            fontWeight: FontWeight.bold,

                          ),

                        ),

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
                                  'assets/images/private.png',
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
                                        AppLocalizations.of(context)!.online_safety_reminder_page_section_1_title,

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
                                        AppLocalizations.of(context)!.online_safety_reminder_page_section_1_subtitle,

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

                        ),

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
                                  'assets/images/signal'
                                      '.png',
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
                                        AppLocalizations.of(context)!.online_safety_reminder_page_section_2_title,

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
                                        AppLocalizations.of(context)!.online_safety_reminder_page_section_2_subtitle,

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

                        ),

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
                                  'assets/images/balance.png',
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
                                        AppLocalizations.of(context)!.online_safety_reminder_page_section_3_title,

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
                                        AppLocalizations.of(context)!.online_safety_reminder_page_section_3_subtitle,

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

                        ),

                        //------------------------------------------------------------------------------

                        Expanded(
                          child: Container(),
                        ),

                        // SPACER
                        const SizedBox(height: 20),

                        //------------------------------------------------------------------------------

                        // NEW GAME BUTTON BOX
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
                              onPressed: () => context.pushReplacement('/play/players_type'),

                              // BUTTON CONTENT
                              child: Text(

                                // TEXT
                                AppLocalizations.of(context)!.online_safety_reminder_donate_button_label,

                                // TEXT ALIGNMENT
                                textAlign: TextAlign.center,

                                // TEXT STYLE
                                style: TextStyle(

                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,

                                ),

                              ),

                            )

                        ),

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
