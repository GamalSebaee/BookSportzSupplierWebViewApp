extension NumberParsing on String? {

  int? convertStringToInt({int? defaultValue}) {
    try {
      return int.tryParse(this ?? '0');
    } catch (e) {
      return defaultValue;
    }
  }
  
}
