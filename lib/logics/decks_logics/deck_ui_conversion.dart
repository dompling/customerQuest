//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';

//------------------------------------------------------------------------------



// DEFINING THE CLASS TO CONVERT ALL THE DIFFICULTY INFO IN AN OBJECT
class DifficultyInfo {

  // CLASS ATTRIBUTES
  final String label;
  final Color background_color;
  final Color border_color;

  DifficultyInfo(this.label, this.background_color, this.border_color);

}



//------------------------------------------------------------------------------



// FUNCTION TO GET ALL THE INFO FROM THE DECK DIFFICULTY
DifficultyInfo get_difficulty_info(int deck_difficulty) {

  // GETTING THE CASE USING DIFFICULTY NUMBER
  switch (deck_difficulty) {
    case 1:
      return DifficultyInfo("Facile", Color(0xff436237), Color(0xff698b5e));
    case 2:
      return DifficultyInfo("Medio", Color(0xff7b5d44), Color(0xff947661));
    case 3:
      return DifficultyInfo("Difficile", Color(0xff884949), Color(0xff9d5858));
    default:
      return DifficultyInfo("Non specificata", Color(0xff4e4e4e), Color(0xff909090));
  }

}




//------------------------------------------------------------------------------



// DEFINING THE CLASS TO CONVERT ALL THE TOOLS INFO IN AN OBJECT
class ToolsInfo {

  // CLASS ATTRIBUTES
  final String label;
  final Color background_color;
  final Color border_color;

  ToolsInfo(this.label, this.background_color, this.border_color);

}



//------------------------------------------------------------------------------



// FUNCTION TO GET ALL THE INFO FROM THE DECK DIFFICULTY
ToolsInfo get_tools_info(List<String> deck_tools_list) {

  // CHECKING IF THERE ARE REQUIRED TOOLS
  if (deck_tools_list.isEmpty) {

    return ToolsInfo("Non richiede strumenti", Color(0xff375362), Color(0xff5e728b));

  } else {

    return ToolsInfo("Richiede strumenti", Color(0xff5f447b), Color(0xff7b6194));

  }

}




//------------------------------------------------------------------------------




