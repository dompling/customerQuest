//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:loverquest/logics/settings_logics/language_switch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

//------------------------------------------------------------------------------



// SETTINGS MAIN PAGE DEFINITION
class SettingsMainPage extends StatefulWidget {

  // CLASS CONSTRUCTOR
  const SettingsMainPage({super.key});

  @override
  State<SettingsMainPage> createState() => _SettingsMainPageState();

}



//------------------------------------------------------------------------------



// SETTINGS MAIN PAGE CONTENT
class _SettingsMainPageState extends State<SettingsMainPage> {

  // APP VERSION STRING
  String app_version = '';

  //------------------------------------------------------------------------------

  // CHOOSE LANGUAGE DIALOG CONTENT
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {

        // DIALOG CONTENT
        return AlertDialog(

          // DIALOG TITLE
          title: Text(AppLocalizations.of(context)!.settings_main_page_language_button_label, textAlign: TextAlign.center,),

          // DIALOG CONTENT
          content: SingleChildScrollView(

            // SCROLLABLE VIEW CONTENT
            child: Column(

              // SIZE
              mainAxisSize: MainAxisSize.min,

              //COLUMN CONTENT
              children: [

                //------------------------------------------------------------------------------

                // ENGLISH OPTION
                ListTile(

                  // LANGUAGE LABEL
                  title: Text(AppLocalizations.of(context)!.deck_language_en, textAlign: TextAlign.center,),

                  // ON TAP FUNCTION CALL
                  onTap: () {

                    // SETTING THE UI LANGUAGE
                    Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale('en', ''));

                    // CLOSING THE DIALOG
                    Navigator.pop(context);

                  },
                ),

                //------------------------------------------------------------------------------

                // ITALIAN OPTION
                ListTile(

                  // LANGUAGE LABEL
                  title: Text(AppLocalizations.of(context)!.deck_language_it, textAlign: TextAlign.center,),

                  // ON TAP FUNCTION CALL
                  onTap: () {

                    // SETTING THE UI LANGUAGE
                    Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale('it', ''));

                    // CLOSING THE DIALOG
                    Navigator.pop(context);

                  },
                ),

                //------------------------------------------------------------------------------

                // FRENCH OPTION
                ListTile(

                  // LANGUAGE LABEL
                  title: Text(AppLocalizations.of(context)!.deck_language_fr, textAlign: TextAlign.center,),

                  // ON TAP FUNCTION CALL
                  onTap: () {

                    // SETTING THE UI LANGUAGE
                    Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale('fr', ''));

                    // CLOSING THE DIALOG
                    Navigator.pop(context);

                  },
                ),

                //------------------------------------------------------------------------------

                // SPANISH OPTION
                ListTile(

                  // LANGUAGE LABEL
                  title: Text(AppLocalizations.of(context)!.deck_language_es, textAlign: TextAlign.center,),

                  // ON TAP FUNCTION CALL
                  onTap: () {

                    // SETTING THE UI LANGUAGE
                    Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale('es', ''));

                    // CLOSING THE DIALOG
                    Navigator.pop(context);

                  },
                ),

                //------------------------------------------------------------------------------

                // GERMAN OPTION
                ListTile(

                  // LANGUAGE LABEL
                  title: Text(AppLocalizations.of(context)!.deck_language_de, textAlign: TextAlign.center,),

                  // ON TAP FUNCTION CALL
                  onTap: () {

                    // SETTING THE UI LANGUAGE
                    Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale('de', ''));

                    // CLOSING THE DIALOG
                    Navigator.pop(context);

                  },
                ),

                //------------------------------------------------------------------------------

              ],

            ),

          ),

        );

      },

    );

  }

  //------------------------------------------------------------------------------

  // FUNCTION TO OPEN THE LINKS IN THE DEFAULT SYSTEM BROWSER
  Future<void> open_link(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Impossible to open the  link: $url";
    }
  }
  
  //------------------------------------------------------------------------------

  // FUNCTION TO GET THE APP VERSION NUMBER
  Future<void> get_app_version() async {

    // GETTING THE APP INFO
    final info = await PackageInfo.fromPlatform();

    // TRANSLATING THE APP INFO IN STRING
    setState(() {
      app_version = '${info.version}+${info.buildNumber}';
    });

  }

  //------------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    get_app_version();
  }

  // PAGE WIDGET
  @override
  Widget build(BuildContext context) {

    //------------------------------------------------------------------------------

    // CONTENT ENTRY
    return Scaffold(

      // PAGE CONTENT
      body: SafeArea(

        // SAFE AREA CONTENT
        child: Container(

          // PAGE PADDING
          padding: EdgeInsets.all(10),

          // PAGE ALIGNMENT
          alignment: Alignment.topCenter,

          // PADDING CONTAINER CONTENT
          child: SingleChildScrollView(

            // SCROLLABLE CONTAINER CONTENT
            child: Align(

              // ALIGNMENT
              alignment: Alignment.center,

              // ALIGN CONTENT
              child: Container(

                // SETTING THE WIDTH LIMIT
                constraints: BoxConstraints(maxWidth: 600),

                // CONTAINER CONTENT
                child: Column(

                  // ALIGNMENT
                  crossAxisAlignment: CrossAxisAlignment.start,

                  // COLUMN CONTENT
                  children: [

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 80),

                    //------------------------------------------------------------------------------

                    // APP LOGO
                    Container(

                      // WIDTH
                      width: double.infinity,

                      // ALIGNMENT
                      alignment: Alignment.center,

                      // CONTENT
                      child: Image.asset(
                        'assets/images/settings_icon.png',
                        width: 140,
                        height: 140,
                        fit: BoxFit.contain,
                      ),

                    ),

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 30),

                    //------------------------------------------------------------------------------

                    // PAGE TITLE CONTAINER
                    Container(

                      // WIDTH
                      width: double.infinity,

                      // ALIGNMENT
                      alignment: Alignment.center,

                      // PAGE TITLE CONTAINER
                      child: FractionallySizedBox(

                        // DYNAMIC WIDTH
                        widthFactor: 0.8,

                        // TITLE
                        child: Text(
                          // TEXT
                          AppLocalizations.of(context)!.settings_main_page_title,

                          // TEXT ALIGNMENT
                          textAlign: TextAlign.center,

                          // TEXT STYLE
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,

                          ),
                        ),

                      ),

                    ),

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 45),

                    //------------------------------------------------------------------------------

                    // LANGUAGE SECTION TITLE LABEL
                    Text(

                      // TEXT
                        AppLocalizations.of(context)!.settings_main_page_language_section_label,

                        // TEXT STYLE
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        )

                    ),

                    // CHOOSE LANGUAGE BUTTON
                    ListTile(

                      // BUTTON LABEL
                      title: Text(AppLocalizations.of(context)!.settings_main_page_language_button_label),

                      // BUTTON ICON
                      leading: const Icon(Icons.language),

                      // ON TAP FUNCTION CALL
                      onTap: () => _showLanguageDialog(context),

                    ),

                    //------------------------------------------------------------------------------

                    // SECTION DIVIDER
                    Divider(

                      // COLOR
                      color: Theme.of(context).colorScheme.primary,

                      // THICKNESS
                      thickness: 2,

                    ),

                    //------------------------------------------------------------------------------

                    // SUPPORT SECTION TITLE LABEL
                    Text(

                      // TEXT
                        AppLocalizations.of(context)!.settings_main_page_support_section_label,

                        // TEXT STYLE
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        )

                    ),

                    // DONATE ON PAYPAL BUTTON
                    ListTile(

                      // BUTTON LABEL
                      title: Text(AppLocalizations.of(context)!.settings_main_page_donate_on_paypal_label),

                      // BUTTON ICON
                      leading: const Icon(Icons.paypal),

                      // ON TAP FUNCTION CALL
                      onTap: () => open_link("https://www.paypal.com/donate/?hosted_button_id=2BL8CVV4HTK3C"),

                    ),

                    // DONATE ON BUY ME A COFFEE BUTTON
                    ListTile(

                      // BUTTON LABEL
                      title: Text(AppLocalizations.of(context)!.settings_main_page_donate_on_buy_me_coffee_label),

                      // BUTTON ICON
                      leading: const Icon(Icons.coffee),

                      // ON TAP FUNCTION CALL
                      onTap: () => open_link("https://buymeacoffee.com/herzen"),

                    ),

                    //------------------------------------------------------------------------------

                    // SECTION DIVIDER
                    Divider(

                      // COLOR
                      color: Theme.of(context).colorScheme.primary,

                      // THICKNESS
                      thickness: 2,

                    ),

                    //------------------------------------------------------------------------------

                    // FEEDBACK SECTION TITLE LABEL
                    Text(

                      // TEXT
                        AppLocalizations.of(context)!.settings_main_page_feedback_section_label,

                        // TEXT STYLE
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        )

                    ),

                    // REPORT BUG BUTTON
                    ListTile(

                      // BUTTON LABEL
                      title: Text(AppLocalizations.of(context)!.settings_main_page_bug_report_label),

                      // BUTTON ICON
                      leading: const Icon(Icons.bug_report),

                      // OPEN LINK FUNCTION
                      onTap: () => open_link("https://github.com/H3rz3n/loverquest/issues"),

                    ),

                    // OPEN GITHUB PAGE BUTTON
                    ListTile(

                      // BUTTON LABEL
                      title: Text(AppLocalizations.of(context)!.settings_main_page_github_page_label),

                      // BUTTON ICON
                      leading: const Icon(Icons.web),

                      // OPEN LINK FUNCTION
                      onTap: () => open_link("https://github.com/H3rz3n/loverquest"),

                    ),

                    //------------------------------------------------------------------------------

                    // SECTION DIVIDER
                    Divider(

                      // COLOR
                      color: Theme.of(context).colorScheme.primary,

                      // THICKNESS
                      thickness: 2,

                    ),

                    //------------------------------------------------------------------------------

                    // CREDITS SECTION TITLE LABEL
                    Text(

                      // TEXT
                        AppLocalizations.of(context)!.settings_main_page_credits_section_label,

                        // TEXT STYLE
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        )

                    ),

                    // DEVELOPER BUTTON
                    ListTile(

                      // BUTTON LABEL
                      title: Text(AppLocalizations.of(context)!.settings_main_page_credits_label),

                      // BUTTON ICON
                      leading: Icon(Icons.favorite),

                    ),

                    //------------------------------------------------------------------------------

                    // SECTION DIVIDER
                    Divider(

                      // COLOR
                      color: Theme.of(context).colorScheme.primary,

                      // THICKNESS
                      thickness: 2,

                    ),

                    //------------------------------------------------------------------------------

                    // OTHER SECTION TITLE LABEL
                    Text(

                      // TEXT
                        AppLocalizations.of(context)!.settings_main_page_other_section_label,

                        // TEXT STYLE
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        )

                    ),

                    // LICENSE BUTTON
                    ListTile(

                      // BUTTON LABEL
                      title: Text(AppLocalizations.of(context)!.settings_main_page_license_label),

                      // BUTTON ICON
                      leading: Icon(Icons.find_in_page),

                      // OPEN LINK FUNCTION
                      onTap: () => open_link("https://github.com/H3rz3n/loverquest/blob/main/LICENSE"),

                    ),

                    // PRIVACY POLICY BUTTON
                    ListTile(

                      // BUTTON LABEL
                      title: Text(AppLocalizations.of(context)!.settings_main_page_privacy_policy_label),

                      // BUTTON ICON
                      leading: Icon(Icons.find_in_page),

                      // OPEN LINK FUNCTION
                      onTap: () => open_link("https://github.com/H3rz3n/loverquest/blob/main/github_pages/privacy_policy/access_to_privacy_policy.md"),

                    ),

                    // APP INFO BUTTON
                    ListTile(

                      // BUTTON LABEL
                      title: Text("${AppLocalizations.of(context)!.settings_main_page_app_info_label} $app_version"),

                      // BUTTON ICON
                      leading: Icon(Icons.settings),

                    ),

                    //------------------------------------------------------------------------------

                  ],

                ),

              ),

            ),

          ),

        )

      ),

    );

  }


}






































//------------------------------------------------------------------------------