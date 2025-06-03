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

// STANDARD LIBRARIES IMPORT
import 'package:flutter/material.dart';

//------------------------------------------------------------------------------

// INFO SNACK BAR
void show_info_snackbar(BuildContext context, String content_text) {

  // SNACKBAR DEFINITION
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(

      // BEHAVIOR
      behavior: SnackBarBehavior.floating,

      // MARGINS
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

      // SHAPE
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      // BACKGROUND COLOR
      backgroundColor: Color(0xFF285780),

      // CONTENT
      content: Row(
        children: [

          // ICON
          Icon(Icons.info_outline, color: Colors.white, size: 30),

          // SPACER
          SizedBox(width: 15),

          // TEXT CONTAINER
          Expanded(

            child: Text(
              content_text,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),

          ),

        ],

      ),

      // VISIBILITY DURATION
      duration: Duration(seconds: 10),

    ),

  );

}

//------------------------------------------------------------------------------

// WARNING SNACK BAR
void show_warning_snackbar(BuildContext context, String content_text) {

  // SNACKBAR DEFINITION
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(

      // BEHAVIOR
      behavior: SnackBarBehavior.floating,

      // MARGINS
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

      // SHAPE
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      // BACKGROUND COLOR
      backgroundColor: Color(0xFF885D36),

      // CONTENT
      content: Row(
        children: [

          // ICON
          Icon(Icons.warning_amber, color: Colors.white, size: 30),

          // SPACER
          SizedBox(width: 15),

          // TEXT CONTAINER
          Expanded(

            child: Text(
              content_text,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),

          ),

        ],

      ),

      // VISIBILITY DURATION
      duration: Duration(seconds: 10),

    ),

  );

}

//------------------------------------------------------------------------------

// ERROR SNACK BAR
void show_error_snackbar(BuildContext context, String content_text) {

  // SNACKBAR DEFINITION
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(

      // BEHAVIOR
      behavior: SnackBarBehavior.floating,

      // MARGINS
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

      // SHAPE
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      // BACKGROUND COLOR
      backgroundColor: Color(0xFF682525),

      // CONTENT
      content: Row(
        children: [

          // ICON
          Icon(Icons.block, color: Colors.white, size: 30),

          // SPACER
          SizedBox(width: 15),

          // TEXT CONTAINER
          Expanded(

            child: Text(
              content_text,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),

          ),

        ],

      ),

      // VISIBILITY DURATION
      duration: Duration(seconds: 10),

    ),

  );

}