

//------------------------------------------------------------------------------

// EXTENSION FOR CAPITALIZE ONLY THE FIRST LETTER OF A STRING
extension CapitalizeFirstExtension on String {

  String capitalize_first() {

    // IF THE STRING IS EMPTY RETURN THE STRING
    if (isEmpty) return this;

    // RETURNING THE EDITED STRING
    return '${this[0].toUpperCase()}${substring(1)}';

  }

}

