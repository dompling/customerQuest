//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// CUSTOM FILES
import 'package:loverquest/main.dart';

import 'package:loverquest/pages/homepage_pages/01_play_main_page.dart';
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

// APP PAGE ROUTING SYSTEM
final GoRouter app_router = GoRouter(

  // SETTING THE HOME PAGE
  initialLocation: '/play',

  routes: [

    //------------------------------------------------------------------------------

    // PLAY MAIN PAGE
    GoRoute(

      // PAGE PATH
      path: '/play',

      // PAGE NAME
      name: 'play',

      // PAGE CONTENT
      builder: (context, state) => const AppSkeleton(
        child: PlayMainPage(),
      ),

      // SUBROUTES
      routes: [

        // 01 SELECT GAME TYPE PAGE - game_type
        GoRoute(

          // PAGE PATH
          path: 'game_type',

          // PAGE NAME
          name: 'game_type',

          // PAGE CONTENT
          builder: (context, state) => const AppSkeleton(
            child: SelectGameTypePage(),
          ),

        ),

        // 02 SELECT PLAYERS TYPE PAGE - players_type
        GoRoute(

          // PAGE PATH
          path: 'players_type',

          // PAGE NAME
          name: 'players_type',

          // PAGE CONTENT
          builder: (context, state) {

            // ACQUIRING THE MATCH DATA OBJECT VAR
            final match_data_object = Provider.of<MatchDataProvider>(context).matchData;

            if (match_data_object == null) {
              Future.microtask(() => context.go('/play'));
              return const SizedBox.shrink();
            }

            return SelectPlayersTypePage(match_data: match_data_object);

          },

        ),

        // 03 DEFINE PLAYERS ALIAS PAGE - players_alias
        GoRoute(

          // PAGE PATH
          path: 'players_alias',

          // PAGE NAME
          name: 'players_alias',

          // PAGE CONTENT
          builder: (context, state) {

            // ACQUIRING THE MATCH DATA OBJECT VAR
            final match_data_object = Provider.of<MatchDataProvider>(context).matchData;

            if (match_data_object == null) {
              Future.microtask(() => context.go('/play'));
              return const SizedBox.shrink();
            }

            return DefinePlayersNamesPage(match_data: match_data_object);

          },

        ),

        // 04 SELECT START PLAYER PAGE - start_player
        GoRoute(

          // PAGE PATH
          path: 'start_player',

          // PAGE NAME
          name: 'start_player',

          // PAGE CONTENT
          builder: (context, state) {

            // ACQUIRING THE MATCH DATA OBJECT VAR
            final match_data_object = Provider.of<MatchDataProvider>(context).matchData;

            if (match_data_object == null) {
              Future.microtask(() => context.go('/play'));
              return const SizedBox.shrink();
            }

            return SelectStartPlayerPage(match_data: match_data_object);

          },

        ),

        // 05 SELECT DECK TO PLAY PAGE - play_deck_choice
        GoRoute(

          // PAGE PATH
          path: 'play_deck_choice',

          // PAGE NAME
          name: 'play_deck_choice',

          // PAGE CONTENT
          builder: (context, state) {

            // ACQUIRING THE MATCH DATA OBJECT VAR
            final match_data_object = Provider.of<MatchDataProvider>(context).matchData;

            if (match_data_object == null) {
              Future.microtask(() => context.go('/play'));
              return const SizedBox.shrink();
            }

            return DeckSelectionPage(match_data: match_data_object);

          },

        ),

        // 06 DECK INFO PAGE - play_deck_info
        GoRoute(

          // PAGE PATH
          path: 'play_deck_info',

          // PAGE NAME
          name: 'play_deck_info',

          // PAGE CONTENT
          builder: (context, state) {

            // ACQUIRING THE MATCH DATA OBJECT VAR
            final match_data_object = Provider.of<MatchDataProvider>(context).matchData;

            if (match_data_object == null) {
              Future.microtask(() => context.go('/play'));
              return const SizedBox.shrink();
            }

            return PlayDeckInfoPage(match_data: match_data_object);

          },

        ),

        // 07 SELECT GAME PACE PAGE - game_pace
        GoRoute(

          // PAGE PATH
          path: 'game_pace',

          // PAGE NAME
          name: 'game_pace',

          // PAGE CONTENT
          builder: (context, state) {

            // ACQUIRING THE MATCH DATA OBJECT VAR
            final match_data_object = Provider.of<MatchDataProvider>(context).matchData;

            if (match_data_object == null) {
              Future.microtask(() => context.go('/play'));
              return const SizedBox.shrink();
            }

            return SelectGameSpeed(match_data: match_data_object);

          },

        ),

        // 08 PLAY PAGE - play_game
        GoRoute(

          // PAGE PATH
          path: 'game',

          // PAGE NAME
          name: 'game',

          // PAGE CONTENT
          builder: (context, state) {

            // ACQUIRING THE MATCH DATA OBJECT VAR
            final match_data_object = Provider.of<MatchDataProvider>(context).matchData;

            if (match_data_object == null) {
              Future.microtask(() => context.go('/play'));
              return const SizedBox.shrink();
            }

            return PlayPage(initial_match_data: match_data_object,);

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
      builder: (context, state) => AppSkeleton(
        child: DeckSelectionMainPage(),
      ),

      // SUBROUTES
      routes: [

        // 01 DECK LIST PAGE - deck_list
        GoRoute(

          // PAGE PATH
          path: 'list',

          // PAGE NAME
          name: 'list',

          // PAGE CONTENT
          builder: (context, state) {

            // GETTING THE DECK WRAPPER
            DeckPagesWrapper? deck_pages_wrapper_object = Provider.of<DeckWrapperProvider>(context).wrapperData;

            // CHECKING IF IS POSSIBLE TO OPEN THE PAGE
            if (deck_pages_wrapper_object == null || deck_pages_wrapper_object.load_default_decks_flag == null) {

              // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
              Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(null);

              Future.microtask(() => context.go('/decks'));
              return const SizedBox.shrink();
            }

            return DeckManagementPage();

          }

        ),

        // 02 STOCK DECK INSPECTOR PAGE - deck_list
        GoRoute(

          // PAGE PATH
          path: 'stock_inspector',

          // PAGE NAME
          name: 'stock_inspector',

          // PAGE CONTENT
          builder: (context, state) {

            // GETTING THE DECK WRAPPER
            DeckPagesWrapper? deck_pages_wrapper_object = Provider.of<DeckWrapperProvider>(context).wrapperData;

            // CHECKING IF IS POSSIBLE TO OPEN THE PAGE
            if (deck_pages_wrapper_object == null || deck_pages_wrapper_object.load_default_decks_flag == null || deck_pages_wrapper_object.selected_deck == null) {

              // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
              Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(null);

              Future.microtask(() => context.go('/decks'));
              return const SizedBox.shrink();
            }

            return StockDeckInfoPage();

          }

        ),

        // 03 DECK EDITOR MAIN PAGE - deck_list
        GoRoute(

          // PAGE PATH
          path: 'editor_main',

          // PAGE NAME
          name: 'editor_main',

          // PAGE CONTENT
          builder: (context, state) {

            // GETTING THE DECK WRAPPER
            DeckPagesWrapper? deck_pages_wrapper_object = Provider.of<DeckWrapperProvider>(context).wrapperData;

            // CHECKING IF IS POSSIBLE TO OPEN THE PAGE
            if (deck_pages_wrapper_object == null || deck_pages_wrapper_object.load_default_decks_flag == null || deck_pages_wrapper_object.selected_deck == null) {

              // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
              Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(null);

              Future.microtask(() => context.go('/decks'));
              return const SizedBox.shrink();
            }

            return DeckEditMainPage();

          }

        ),

        // 04 EDIT DECK SUMMARY PAGE - deck_list
        GoRoute(

          // PAGE PATH
          path: 'editor_summary',

          // PAGE NAME
          name: 'editor_summary',

          // PAGE CONTENT
          builder: (context, state) {

            // GETTING THE DECK WRAPPER
            DeckPagesWrapper? deck_pages_wrapper_object = Provider.of<DeckWrapperProvider>(context).wrapperData;

            // CHECKING IF IS POSSIBLE TO OPEN THE PAGE
            if (deck_pages_wrapper_object == null || deck_pages_wrapper_object.load_default_decks_flag == null ||deck_pages_wrapper_object.selected_deck == null) {

              // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
              Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(null);

              Future.microtask(() => context.go('/decks'));
              return const SizedBox.shrink();
            }

            return DeckSummaryEditPage();

          }

        ),

        // 05 EDIT QUEST PAGE - deck_list
        GoRoute(

          // PAGE PATH
          path: 'editor_quest',

          // PAGE NAME
          name: 'editor_quest',

          // PAGE CONTENT
          builder: (context, state) {

            // GETTING THE DECK WRAPPER
            DeckPagesWrapper? deck_pages_wrapper_object = Provider.of<DeckWrapperProvider>(context).wrapperData;

            // CHECKING IF IS POSSIBLE TO OPEN THE PAGE
            if (deck_pages_wrapper_object == null || deck_pages_wrapper_object.load_default_decks_flag == null || deck_pages_wrapper_object.show_delete_button == null || deck_pages_wrapper_object.selected_deck == null) {

              // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
              Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(null);

              Future.microtask(() => context.go('/decks'));
              return const SizedBox.shrink();
            }

            return QuestEditPage();

          }

        ),

      ],
      /*
      // REDIRECT CHECK TO AVOID ERRORS
      redirect: (context, state) {

        // ACQUIRING THE DECK WRAPPER OBJECT VAR
        DeckPagesWrapper? deck_pages_wrapper_object = Provider.of<DeckWrapperProvider>(context, listen: false).wrapperData;

        print("DEBUG - IS CORRECT: ${deck_pages_wrapper_object?.is_correct ?? "Null"}");

        if (!(deck_pages_wrapper_object?.is_correct ?? true)) {

          // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
          Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(null);

          // REDIRECTING TO A SAFE PAGE
          return '/decks';

        }

        // CONTINUING WITHOUT ISSUES
        return null;

      }
      */
    ),

    //------------------------------------------------------------------------------

    // SETTING MAIN PAGE
    GoRoute(

      // PAGE PATH
      path: '/settings',

      // PAGE NAME
      name: 'settings',

      // PAGE CONTENT
      builder: (context, state) => const AppSkeleton(
        child: SettingsMainPage(),
      ),

    ),

    //------------------------------------------------------------------------------

  ],

);