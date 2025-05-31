//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

// CUSTOM FILES
import 'package:loverquest/main.dart';

import 'package:loverquest/pages/first_start_pages/01_welcome_presentation_page.dart';
import 'package:loverquest/pages/first_start_pages/02_play_modes_presentation_page.dart';
import 'package:loverquest/pages/first_start_pages/03_custom_decks_presentation_page.dart';
import 'package:loverquest/pages/first_start_pages/04_security_presentation_page.dart';
import 'package:loverquest/pages/first_start_pages/05_web_app_presentation_page.dart';
import 'package:loverquest/pages/first_start_pages/06_donation_presentation_page.dart';

import 'package:loverquest/pages/homepage_pages/01_play_main_page.dart';
import 'package:loverquest/pages/homepage_pages/dialogs/01_donation_dialog.dart';
import 'package:loverquest/pages/homepage_pages/dialogs/02_review_dialog.dart';
import 'package:loverquest/pages/homepage_pages/02_decks_main_page.dart';
import 'package:loverquest/pages/homepage_pages/03_settings_main_page.dart';

import 'package:loverquest/pages/play_pages/01_select_game_type_page.dart';
import 'package:loverquest/pages/play_pages/02_select_players_type_page.dart';
import 'package:loverquest/pages/play_pages/03_define_players_names_page.dart';
import 'package:loverquest/pages/play_pages/04_select_start_player_page.dart';
import 'package:loverquest/pages/play_pages/05_select_deck_to_play_page.dart';
import 'package:loverquest/pages/play_pages/06_deck_info_page.dart';
import 'package:loverquest/pages/play_pages/07_select_game_speed.dart';
import 'package:loverquest/pages/play_pages/08_play_page.dart';

import 'package:loverquest/pages/decks_pages/01_deck_list_management_page.dart';
import 'package:loverquest/pages/decks_pages/02_stock_deck_inspector_page.dart';
import 'package:loverquest/pages/decks_pages/03_deck_editor_main_page.dart';
import 'package:loverquest/pages/decks_pages/04_edit_deck_summary_page.dart';
import 'package:loverquest/pages/decks_pages/05_edit_quest_page.dart';

import 'package:loverquest/logics/play_logics/01_match_data_class.dart';

import 'package:loverquest/logics/general/app_router_wrapper_classes.dart';




//------------------------------------------------------------------------------

// DEFINING THE ROUTE OBSERVER
final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

// APP PAGE ROUTING SYSTEM
final GoRouter app_router = GoRouter(

    // SETTING THE HOME PAGE
    initialLocation: '/presentation',

    // SETTING THE OBSERVER
    observers: [routeObserver],

    // DISABLING BROWSER HISTORY NAVIGATION
    routerNeglect: true,

    routes: [

      // WELCOME CAROUSEL PAGE
      GoRoute(

          // PAGE PATH
          path: '/presentation',

          // PAGE NAME
          name: 'presentation',

          // PAGE REDIRECT CONDITIONS
          redirect: (context, state) async {

            // DEFINING THE APP PREFERENCE VAR
            SharedPreferences prefs = await SharedPreferences.getInstance();

            // GETTING THE SPLASH SCREEN PREFERENCE, IF THERE ARE NOT SETTING IT TO ZERO
            bool show_splash_screen = prefs.getBool('show_splash_screen') ?? true;

            // CHECKING IF IS NECESSARY TO REDIRECT THE PAGE
            if (!show_splash_screen) {

              return '/play';

            }

            return null;

          },

          // PAGE CONTENT
          pageBuilder: (context, state) {
            return CustomTransitionPage(

              // PAGE KEY - AUTOMATICALLY GENERATED
              key: state.pageKey,

              // PAGE TO OPEN
              child: PresentationWelcomePage(),

              // TRANSITION
              transitionsBuilder: (context, animation, secondaryAnimation, child) {

                return FadeTransition(opacity: animation, child: child,);

              },

            );

          },

          // SUBROUTES
          routes: [

            // 02 GAME MODE PRESENTATION - game_modes
            GoRoute(

              // PAGE PATH
              path: 'game_modes',

              // PAGE NAME
              name: 'game_modes',

              // PAGE CONTENT
              pageBuilder: (context, state) {
                return CustomTransitionPage(

                  // PAGE KEY - AUTOMATICALLY GENERATED
                  key: state.pageKey,

                  // PAGE TO OPEN
                  child: PresentationGameModesPage(),

                  // TRANSITION
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );

                  },

                );

              },

            ),

            // 03 CUSTOM DECK PRESENTATION - custom_decks_presentation
            GoRoute(

              // PAGE PATH
              path: 'customization_presentation',

              // PAGE NAME
              name: 'customization_presentation',

              // PAGE CONTENT
              pageBuilder: (context, state) {
                return CustomTransitionPage(

                  // PAGE KEY - AUTOMATICALLY GENERATED
                  key: state.pageKey,

                  // PAGE TO OPEN
                  child: PresentationCustomizationPage(),

                  // TRANSITION
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );

                  },

                );

              },

            ),

            // 04 OTHER FEATURES PRESENTATION - features_presentation
            GoRoute(

              // PAGE PATH
              path: 'safety_presentation',

              // PAGE NAME
              name: 'safety_presentation',

              // PAGE CONTENT
              pageBuilder: (context, state) {
                return CustomTransitionPage(

                  // PAGE KEY - AUTOMATICALLY GENERATED
                  key: state.pageKey,

                  // PAGE TO OPEN
                  child: PresentationPrivacyPage(),

                  // TRANSITION
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );

                  },

                );

              },

            ),

            // 05 WEB APP PRESENTATION - web_app_presentation
            GoRoute(

              // PAGE PATH
              path: 'web_app_presentation',

              // PAGE NAME
              name: 'web_app_presentation',

              // PAGE CONTENT
              pageBuilder: (context, state) {
                return CustomTransitionPage(

                  // PAGE KEY - AUTOMATICALLY GENERATED
                  key: state.pageKey,

                  // PAGE TO OPEN
                  child: PresentationWebAppPage(),

                  // TRANSITION
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );

                  },

                );

              },

            ),

            // 06 DONATION PRESENTATION - donation_presentation
            GoRoute(

              // PAGE PATH
              path: 'donation_presentation',

              // PAGE NAME
              name: 'donation_presentation',

              // PAGE CONTENT
              pageBuilder: (context, state) {

                return CustomTransitionPage(

                  // PAGE KEY - AUTOMATICALLY GENERATED
                  key: state.pageKey,

                  // PAGE TO OPEN
                  child: PresentationDonationPage(),

                  // TRANSITION
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );

                  },

                );

              },

            ),

          ]

      ),

      //------------------------------------------------------------------------------

      // PLAY MAIN PAGE
      GoRoute(

          // PAGE PATH
          path: '/play',

          // PAGE NAME
          name: 'play',

          // PAGE REDIRECT CONDITIONS
          redirect: (context, state) async {

            // DEFINING THE APP PREFERENCE VAR
            SharedPreferences prefs = await SharedPreferences.getInstance();

            // GETTING THE SPLASH SCREEN PREFERENCE, IF THERE ARE NOT SETTING IT TO ZERO
            bool show_splash_screen = prefs.getBool('show_splash_screen') ?? true;

            // CHECKING IF IS NECESSARY TO REDIRECT THE PAGE
            if (show_splash_screen) {

              return '/presentation';

            }

            return null;

          },

          // PAGE CONTENT
          pageBuilder: (context, state) {
            return CustomTransitionPage(

              // PAGE KEY - AUTOMATICALLY GENERATED
              key: state.pageKey,

              // PAGE TO OPEN
              child: AppSkeleton(child: PlayMainPage()),

              // TRANSITION
              transitionsBuilder: (context, animation, secondaryAnimation, child) {

                return FadeTransition(opacity: animation, child: child,);

              },

            );

          },

          // SUBROUTES
          routes: [

            // 01 DONATION REMINDER PAGE - donation_reminder
            GoRoute(

              // PAGE PATH
              path: 'donation_reminder_page',

              // PAGE NAME
              name: 'donation_reminder_page',

              // PAGE CONTENT
              pageBuilder: (context, state) {
                return CustomTransitionPage(

                  // PAGE KEY - AUTOMATICALLY GENERATED
                  key: state.pageKey,

                  // PAGE TO OPEN
                  child: DonationReminderPage(),

                  // TRANSITION
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0, 1), // Cambia per la direzione
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );


                  },

                );

              },

            ),

            // 01 SELECT GAME TYPE PAGE - game_type
            GoRoute(

              // PAGE PATH
              path: 'game_type',

              // PAGE NAME
              name: 'game_type',

              // PAGE CONTENT
              pageBuilder: (context, state) {
                return CustomTransitionPage(

                  // PAGE KEY - AUTOMATICALLY GENERATED
                  key: state.pageKey,

                  // PAGE TO OPEN
                  child: SelectGameTypePage(),

                  // TRANSITION
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    return FadeTransition(opacity: animation, child: child,);

                  },

                );

              },

            ),

            // 02 SELECT PLAYERS TYPE PAGE - players_type
            GoRoute(

              // PAGE PATH
              path: 'players_type',

              // PAGE NAME
              name: 'players_type',

              // PAGE REDIRECT CONDITIONS
              redirect: (context, state) {

                // GETTING THE DATA WRAPPER
                final match_data_object = Provider.of<MatchDataProvider>(context, listen: false).matchData;

                // CHECKING IF IS NECESSARY TO REDIRECT THE PAGE
                if (match_data_object == null) {
                  return '/play';
                }

                return null;

              },

              // PAGE CONTENT
              pageBuilder: (context, state) {
                return CustomTransitionPage(

                  // PAGE KEY - AUTOMATICALLY GENERATED
                  key: state.pageKey,

                  // PAGE TO OPEN
                  child: SelectPlayersTypePage(),

                  // TRANSITION
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    return FadeTransition(opacity: animation, child: child,);

                  },

                );

              },

            ),

            // 03 DEFINE PLAYERS ALIAS PAGE - players_alias
            GoRoute(

              // PAGE PATH
              path: 'players_alias',

              // PAGE NAME
              name: 'players_alias',

              // PAGE REDIRECT CONDITIONS
              redirect: (context, state) {

                // GETTING THE DATA WRAPPER
                final match_data_object = Provider.of<MatchDataProvider>(context, listen: false).matchData;

                // CHECKING IF IS NECESSARY TO REDIRECT THE PAGE
                if (match_data_object == null) {
                  return '/play';
                }

                return null;

              },

              // PAGE CONTENT
              pageBuilder: (context, state) {
                return CustomTransitionPage(

                  // PAGE KEY - AUTOMATICALLY GENERATED
                  key: state.pageKey,

                  // PAGE TO OPEN
                  child: DefinePlayersNamesPage(),

                  // TRANSITION
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    return FadeTransition(opacity: animation, child: child,);

                  },

                );

              },

            ),

            // 04 SELECT START PLAYER PAGE - start_player
            GoRoute(

              // PAGE PATH
              path: 'start_player',

              // PAGE NAME
              name: 'start_player',

              // PAGE REDIRECT CONDITIONS
              redirect: (context, state) {

                // GETTING THE DATA WRAPPER
                final match_data_object = Provider.of<MatchDataProvider>(context, listen: false).matchData;

                // CHECKING IF IS NECESSARY TO REDIRECT THE PAGE
                if (match_data_object == null) {
                  return '/play';
                }

                return null;

              },

              // PAGE CONTENT
              pageBuilder: (context, state) {
                return CustomTransitionPage(

                  // PAGE KEY - AUTOMATICALLY GENERATED
                  key: state.pageKey,

                  // PAGE TO OPEN
                  child: SelectStartPlayerPage(),

                  // TRANSITION
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    return FadeTransition(opacity: animation, child: child,);

                  },

                );

              },

            ),

            // 05 SELECT DECK TO PLAY PAGE - play_deck_choice
            GoRoute(

              // PAGE PATH
              path: 'play_deck_choice',

              // PAGE NAME
              name: 'play_deck_choice',

              // PAGE REDIRECT CONDITIONS
              redirect: (context, state) {

                // GETTING THE DATA WRAPPER
                final match_data_object = Provider.of<MatchDataProvider>(context, listen: false).matchData;

                // CHECKING IF IS NECESSARY TO REDIRECT THE PAGE
                if (match_data_object == null) {
                  return '/play';
                }

                return null;

              },

              // PAGE CONTENT
              pageBuilder: (context, state) {
                return CustomTransitionPage(

                  // PAGE KEY - AUTOMATICALLY GENERATED
                  key: state.pageKey,

                  // PAGE TO OPEN
                  child: DeckSelectionPage(),

                  // TRANSITION
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    return FadeTransition(opacity: animation, child: child,);

                  },

                );

              },

            ),

            // 06 DECK INFO PAGE - play_deck_info
            GoRoute(

              // PAGE PATH
              path: 'play_deck_info',

              // PAGE NAME
              name: 'play_deck_info',

              // PAGE REDIRECT CONDITIONS
              redirect: (context, state) {

                // GETTING THE DATA WRAPPER
                final match_data_object = Provider.of<MatchDataProvider>(context, listen: false).matchData;

                // CHECKING IF IS NECESSARY TO REDIRECT THE PAGE
                if (match_data_object == null) {
                  return '/play';
                }

                return null;

              },

              // PAGE CONTENT
              pageBuilder: (context, state) {
                return CustomTransitionPage(

                  // PAGE KEY - AUTOMATICALLY GENERATED
                  key: state.pageKey,

                  // PAGE TO OPEN
                  child: PlayDeckInfoPage(),

                  // TRANSITION
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    return FadeTransition(opacity: animation, child: child,);

                  },

                );

              },

            ),

            // 07 SELECT GAME PACE PAGE - game_pace
            GoRoute(

              // PAGE PATH
              path: 'game_pace',

              // PAGE NAME
              name: 'game_pace',

              // PAGE REDIRECT CONDITIONS
              redirect: (context, state) {

                // GETTING THE DATA WRAPPER
                final match_data_object = Provider.of<MatchDataProvider>(context, listen: false).matchData;

                // CHECKING IF IS NECESSARY TO REDIRECT THE PAGE
                if (match_data_object == null) {
                  return '/play';
                }

                return null;

              },

              // PAGE CONTENT
              pageBuilder: (context, state) {
                return CustomTransitionPage(

                  // PAGE KEY - AUTOMATICALLY GENERATED
                  key: state.pageKey,

                  // PAGE TO OPEN
                  child: SelectGameSpeed(),

                  // TRANSITION
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    return FadeTransition(opacity: animation, child: child,);

                  },

                );

              },

            ),

            // 08 PLAY PAGE - play_game
            GoRoute(

              // PAGE PATH
              path: 'game',

              // PAGE NAME
              name: 'game',

              // PAGE REDIRECT CONDITIONS
              redirect: (context, state) {

                // GETTING THE DATA WRAPPER
                final match_data_object = Provider.of<MatchDataProvider>(context, listen: false).matchData;

                // CHECKING IF IS NECESSARY TO REDIRECT THE PAGE
                if (match_data_object == null) {
                  return '/play';
                }

                return null;

              },

              // PAGE CONTENT
              pageBuilder: (context, state) {
                return CustomTransitionPage(

                  // PAGE KEY - AUTOMATICALLY GENERATED
                  key: state.pageKey,

                  // PAGE TO OPEN
                  child: PlayPage(),

                  // TRANSITION
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    return FadeTransition(opacity: animation, child: child,);

                  },

                );

              },

            ),

          ]

      ),

      //------------------------------------------------------------------------------

      // DECK MAIN PAGE
      GoRoute(

        // PAGE PATH
        path: '/decks',

        // PAGE NAME
        name: 'decks',

        // PAGE CONTENT
        pageBuilder: (context, state) {
          return CustomTransitionPage(

            // PAGE KEY - AUTOMATICALLY GENERATED
            key: state.pageKey,

            // PAGE TO OPEN
            child: AppSkeleton(child: DeckSelectionMainPage()),

            // TRANSITION
            transitionsBuilder: (context, animation, secondaryAnimation, child) {

              return FadeTransition(opacity: animation, child: child,);

            },

          );

        },

        // SUBROUTES
        routes: [

          // STOCK DECK ROUTE - DECK LIST PAGE - stock/default_decks_list
          GoRoute(

              // PAGE PATH
              path: 'stock/default_decks_list',

              // PAGE NAME
              name: 'default_decks_list',

              // PAGE REDIRECT CONDITIONS
              redirect: (context, state) {

                // GETTING THE DECK WRAPPER
                final deck_pages_wrapper_object = Provider.of<DeckWrapperProvider>(context, listen: false).wrapperData;

                // CHECKING IF IS NECESSARY TO REDIRECT THE PAGE
                if (deck_pages_wrapper_object == null || deck_pages_wrapper_object.load_default_decks_flag != true) {
                  return '/decks';
                }

                return null;

              },

              // PAGE CONTENT
              pageBuilder: (context, state) {
                return CustomTransitionPage(

                  // PAGE KEY - AUTOMATICALLY GENERATED
                  key: state.pageKey,

                  // PAGE TO OPEN
                  child: DeckManagementPage(),

                  // TRANSITION
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    return FadeTransition(opacity: animation, child: child,);

                  },

                );

              },

              routes: [

                // STOCK DECK INSPECTOR PAGE - deck_inspector
                GoRoute(

                  // PAGE PATH
                  path: 'deck_inspector',

                  // PAGE NAME
                  name: 'deck_inspector',

                  // PAGE REDIRECT CONDITIONS
                  redirect: (context, state) {

                    // GETTING THE DECK WRAPPER
                    final deck_pages_wrapper_object = Provider.of<DeckWrapperProvider>(context, listen: false).wrapperData;

                    // CHECKING IF IS NECESSARY TO REDIRECT THE PAGE
                    if (deck_pages_wrapper_object == null || deck_pages_wrapper_object.load_default_decks_flag != true || deck_pages_wrapper_object.selected_deck == null) {
                      return '/decks';
                    }

                    return null;

                  },

                  // PAGE CONTENT
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(

                      // PAGE KEY - AUTOMATICALLY GENERATED
                      key: state.pageKey,

                      // PAGE TO OPEN
                      child: StockDeckInfoPage(),

                      // TRANSITION
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {

                        return FadeTransition(opacity: animation, child: child,);

                      },

                    );

                  },

                ),

              ]

          ),

          // CUSTOM DECK ROUTE - DECK LIST -/user/custom_decks_list
          GoRoute(

              // PAGE PATH
              path: 'user/custom_decks_list',

              // PAGE NAME
              name: 'custom_decks_list',

              // PAGE REDIRECT CONDITIONS
              redirect: (context, state) {

                // GETTING THE DECK WRAPPER
                final deck_pages_wrapper_object = Provider.of<DeckWrapperProvider>(context, listen: false).wrapperData;

                // CHECKING IF IS NECESSARY TO REDIRECT THE PAGE
                if (deck_pages_wrapper_object == null || deck_pages_wrapper_object.load_default_decks_flag != false) {
                  return '/decks';
                }

                return null;

              },

              // PAGE CONTENT
              pageBuilder: (context, state) {
                return CustomTransitionPage(

                  // PAGE KEY - AUTOMATICALLY GENERATED
                  key: state.pageKey,

                  // PAGE TO OPEN
                  child: DeckManagementPage(),

                  // TRANSITION
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {

                    return FadeTransition(opacity: animation, child: child,);

                  },

                );

              },

              routes: [

                // CREATE NEW DECK SUBROUTE - NEW DECK SUMMARY EDITOR - create/new_deck_editor
                GoRoute(

                  // PAGE PATH
                  path: 'create/new_deck_editor',

                  // PAGE NAME
                  name: 'new_deck_editor',

                  // PAGE REDIRECT CONDITIONS
                  redirect: (context, state) {

                    // GETTING THE DECK WRAPPER
                    final deck_pages_wrapper_object = Provider.of<DeckWrapperProvider>(context, listen: false).wrapperData;

                    // CHECKING IF IS NECESSARY TO REDIRECT THE PAGE
                    if (deck_pages_wrapper_object == null || deck_pages_wrapper_object.load_default_decks_flag != false || deck_pages_wrapper_object.new_deck_creation != true) {
                      return '/decks';
                    }

                    return null;

                  },

                  // PAGE CONTENT
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(

                      // PAGE KEY - AUTOMATICALLY GENERATED
                      key: state.pageKey,

                      // PAGE TO OPEN
                      child: DeckSummaryEditPage(),

                      // TRANSITION
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {

                        return FadeTransition(opacity: animation, child: child,);

                      },

                    );

                  },

                ),

                // DECK EDIT SUBROUTE - DECK EDITOR MAIN PAGE - edit/deck_main_editor
                GoRoute(

                    // PAGE PATH
                    path: 'edit/deck_main_editor',

                    // PAGE NAME
                    name: 'deck_main_editor',

                    // PAGE REDIRECT CONDITIONS
                    redirect: (context, state) {

                      // GETTING THE DECK WRAPPER
                      final deck_pages_wrapper_object = Provider.of<DeckWrapperProvider>(context, listen: false).wrapperData;

                      // CHECKING IF IS NECESSARY TO REDIRECT THE PAGE
                      if (deck_pages_wrapper_object == null || deck_pages_wrapper_object.load_default_decks_flag != false || deck_pages_wrapper_object.selected_deck == null) {
                        return '/decks';
                      }

                      return null;

                    },

                    // PAGE CONTENT
                    pageBuilder: (context, state) {
                      return CustomTransitionPage(

                        // PAGE KEY - AUTOMATICALLY GENERATED
                        key: state.pageKey,

                        // PAGE TO OPEN
                        child: DeckEditMainPage(),

                        // TRANSITION
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {

                          return FadeTransition(opacity: animation, child: child,);

                        },

                      );

                    },

                    routes: [

                      // DECK SUMMARY EDITOR - deck_summary_editor
                      GoRoute(

                        // PAGE PATH
                        path: 'deck_summary_editor',

                        // PAGE NAME
                        name: 'deck_summary_editor',

                        // PAGE REDIRECT CONDITIONS
                        redirect: (context, state) {

                          // GETTING THE DECK WRAPPER
                          final deck_pages_wrapper_object = Provider.of<DeckWrapperProvider>(context, listen: false).wrapperData;

                          // CHECKING IF IS NECESSARY TO REDIRECT THE PAGE
                          if (deck_pages_wrapper_object == null || deck_pages_wrapper_object.load_default_decks_flag != false || deck_pages_wrapper_object.new_deck_creation != false || deck_pages_wrapper_object.selected_deck == null) {
                            return '/decks';
                          }

                          return null;

                        },

                        // PAGE CONTENT
                        pageBuilder: (context, state) {
                          return CustomTransitionPage(

                            // PAGE KEY - AUTOMATICALLY GENERATED
                            key: state.pageKey,

                            // PAGE TO OPEN
                            child: DeckSummaryEditPage(),

                            // TRANSITION
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {

                              return FadeTransition(opacity: animation, child: child,);

                            },

                          );

                        },

                      ),

                      // EDIT/CREATE QUEST PAGE - deck_quest_editor
                      GoRoute(

                        // PAGE PATH
                        path: 'deck_quest_editor',

                        // PAGE NAME
                        name: 'deck_quest_editor',

                        // PAGE REDIRECT CONDITIONS
                        redirect: (context, state) {

                          // GETTING THE DECK WRAPPER
                          final deck_pages_wrapper_object = Provider.of<DeckWrapperProvider>(context, listen: false).wrapperData;

                          // CHECKING IF IS NECESSARY TO REDIRECT THE PAGE
                          if (deck_pages_wrapper_object == null || deck_pages_wrapper_object.load_default_decks_flag != false || deck_pages_wrapper_object.selected_deck == null) {
                            return '/decks';
                          }
                          return null;
                        },

                        // PAGE CONTENT
                        pageBuilder: (context, state) {
                          return CustomTransitionPage(

                            // PAGE KEY - AUTOMATICALLY GENERATED
                            key: state.pageKey,

                            // PAGE TO OPEN
                            child: QuestEditPage(),

                            // TRANSITION
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {

                              return FadeTransition(opacity: animation, child: child,);

                            },

                          );

                        },

                      ),

                    ]

                ),

              ]

          ),

        ],

      ),

      //------------------------------------------------------------------------------

      // SETTING MAIN PAGE
      GoRoute(

        // PAGE PATH
        path: '/settings',

        // PAGE NAME
        name: 'settings',

        // PAGE CONTENT
        pageBuilder: (context, state) {
          return CustomTransitionPage(

            // PAGE KEY - AUTOMATICALLY GENERATED
            key: state.pageKey,

            // PAGE TO OPEN
            child: AppSkeleton(child: SettingsMainPage()),

            // TRANSITION
            transitionsBuilder: (context, animation, secondaryAnimation, child) {

              return FadeTransition(opacity: animation, child: child,);

            },

          );

        },

      ),


    ],

);

