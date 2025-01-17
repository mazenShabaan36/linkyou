class InputConverter {
  int stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return integer;
    } on FormatException {
      throw const FormatException();
    }
  }
}