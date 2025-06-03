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
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loverquest/l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

//------------------------------------------------------------------------------

// DONATION PAGE DEFINITION
class DonationReminderPage extends StatefulWidget {

  // CLASS CONSTRUCTOR
  const DonationReminderPage({super.key});

  @override
  State<DonationReminderPage> createState() => DonationReminderPageState();

}

// DONATION PAGE CONTENT
class DonationReminderPageState extends State<DonationReminderPage> {

  // INITIALIZING THE DONATION PAGE LINK4
  String donation_page_link = "";

  // FUNCTION TO OPEN THE LINKS IN THE DEFAULT SYSTEM BROWSER
  Future<void> open_link(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Unable to open the link: $url";
    }
  }

  // INITIAL PAGE STATE
  @override
  void initState()  {
    super.initState();

    // CHECKING WHICH LANGUAGE IS ACTUALLY IN USE
    String language_in_use = PlatformDispatcher.instance.locale.languageCode;

    if (language_in_use == "it") {

      // SETTING THE CORRECT LINK
      donation_page_link = "https://github.com/H3rz3n/loverquest/blob/main/github_pages/readme/it_readme.md#come-posso-supportare-il-progetto";

    } else if (language_in_use == "es") {

      // SETTING THE CORRECT LINK
      donation_page_link = "https://github.com/H3rz3n/loverquest/blob/main/github_pages/readme/es_readme.md#c%C3%B3mo-puedo-apoyar-el-proyecto";

    } else if (language_in_use == "de") {

      // SETTING THE CORRECT LINK
      donation_page_link = "https://github.com/H3rz3n/loverquest/blob/main/github_pages/readme/de_readme.md#wie-kann-ich-das-projekt-unterst%C3%BCtzen";

    } else if (language_in_use == "fr") {

      // SETTING THE CORRECT LINK
      donation_page_link = "https://github.com/H3rz3n/loverquest/blob/main/github_pages/readme/fr_readme.md#comment-puis-je-soutenir-le-projet-";

    } else if (language_in_use == "nl") {

      // SETTING THE CORRECT LINK
      donation_page_link = "https://github.com/H3rz3n/loverquest/blob/main/github_pages/readme/nl_readme.md#hoe-kan-ik-het-project-steunen";

    } else {

      // SETTING THE CORRECT LINK
      donation_page_link = "https://github.com/H3rz3n/loverquest/tree/main?tab=readme-ov-file#how-can-i-support-the-project";

    }

  }

  @override
  Widget build(BuildContext context) {

    // PAGE CONTENT
    return Scaffold(

      // APP BAR
      appBar: AppBar(

        // CLOSE ICON
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),

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
                          'assets/images/donation.png',
                          width: 120,
                          height: 120,
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
                          AppLocalizations.of(context)!.app_presentation_donation_page_title,

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
                                  'assets/images/wallet.png',
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
                                        AppLocalizations.of(context)!.app_presentation_donation_page_section_1_title,

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
                                        AppLocalizations.of(context)!.app_presentation_donation_page_section_1_subtitle,

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
                                  'assets/images/ads.png',
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
                                        AppLocalizations.of(context)!.app_presentation_donation_page_section_2_title,

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
                                        AppLocalizations.of(context)!.app_presentation_donation_page_section_2_subtitle,

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
                                  'assets/images/github.png',
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
                                        AppLocalizations.of(context)!.app_presentation_donation_page_section_3_title,

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
                                        AppLocalizations.of(context)!.app_presentation_donation_page_section_3_subtitle,

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
                            onPressed: () => open_link(donation_page_link),

                            // BUTTON CONTENT
                            child: Text(

                              // TEXT
                              AppLocalizations.of(context)!.donation_reminder_page_donate_button_label,

                              // TEXT ALIGNMENT
                              textAlign: TextAlign.center,

                              // TEXT STYLE
                              style: TextStyle(

                                fontSize: 17,
                                fontWeight: FontWeight.normal,

                              ),

                            ),

                          )

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
