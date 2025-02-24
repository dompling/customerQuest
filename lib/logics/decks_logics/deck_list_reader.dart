//------------------------------------------------------------------------------



// DEFAULT DECKS MANAGER
class DefaultDeckListReader {

  // CLASS ATTRIBUTES
  static final List<String> default_decks_files = [

    // DEFAULT DECKS LIST
    "presence/hetero/01_presence_hetero_deck_easy_no_tools.json",
    "presence/hetero/02_presence_hetero_deck_medium_no_tools.json",
    "presence/hetero/03_presence_hetero_deck_medium_with_tools.json",
    "presence/hetero/04_presence_hetero_deck_hard_no_tools.json",
    "presence/hetero/05_presence_hetero_deck_hard_with_tools.json",

    "presence/lesbian/lesbian_deck.json",

    "presence/gay/gay_deck.json",

    "distance/hetero/01_distance_hetero_deck_easy_no_tools.json",
    "distance/hetero/02_distance_hetero_deck_medium_no_tools.json",
    "distance/hetero/03_distance_hetero_deck_medium_with_tools.json",
    "distance/hetero/04_distance_hetero_deck_hard_no_tools.json",
    "distance/hetero/05_distance_hetero_deck_hard_with_tools.json",

  ];

  // RETURNING FILE PATH LIST
  static List<String> get_deck_paths() {
    return default_decks_files.map((file) => "assets/default_decks/$file").toList();
  }

}



//------------------------------------------------------------------------------