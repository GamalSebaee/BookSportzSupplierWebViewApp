import 'package:intl/intl.dart';

//String phonePattern = r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$';
String phonePattern =
    r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$';
String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
String passwordPattern = r'^(?=.*?[a-z])(?=.*?[!@#\$&*~0-9]).{8,}$';
int nameMinLength = 3;
int nameMaxLength = 20;
int minAge = 18;

bool validatePhone(String? mobileNumber) {
  /*
    Group1: Country Code (+20)
    Group2: Area Code (ex: 127)
    Group3: Exchange (ex: 480)
    Group4: Subscriber Number (ex: 1256)
    Group5: Extension
   */
  if (mobileNumber != null && mobileNumber.isNotEmpty) {
    RegExp regExp = new RegExp(phonePattern);
    return regExp.hasMatch(mobileNumber);
  } else {
    return false;
  }
}

bool validateEmail(String? email) {
  if (email != null && email.isNotEmpty) {
    RegExp regExp = new RegExp(emailPattern);
    return regExp.hasMatch(email);
  } else {
    return false;
  }
}

bool validateName(String? name) {
  if (name != null  && name.trim().isNotEmpty && name.trim().length >= nameMinLength && name.trim().length <= nameMaxLength) {
    return true;
  } else {
    return false;
  }
}

bool validateNameWithoutSpecialChar(String? name) {
  if (name != null  && name.trim().isNotEmpty && name.trim().length >= nameMinLength && name.trim().length <= nameMaxLength
      && (!AppValidator.hasSpecialCharacters(name))) {
    return true;
  } else {
    return false;
  }
}

bool validatePassword(String? password) {
  // password should have be at least 8 characters,
  //  must have at least one symbol or number, can’t contain spaces
  if (password != null && password.isNotEmpty && !password.contains(" ")) {
    RegExp regExp = new RegExp(passwordPattern);
    return regExp.hasMatch(password);
  } else {
    return false;
  }
}

bool isNullOrEmpty(dynamic obj) =>
    obj == null ||
        ((obj is String || obj is List || obj is Map) && obj.isEmpty);

bool validateAge(String? birthDateString) {
  if (birthDateString != null && birthDateString.isNotEmpty) {
    String datePattern = "dd-MM-yyyy";

    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;

    return ((yearDiff > minAge) ||
        ((yearDiff == 18) && (monthDiff >= 0) && (dayDiff >= 0)));
  } else {
    return false;
  }
}

class AppValidator {
  static const numberOfDaysInYear = 365.2425;
  static const emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const phoneNumberRegex = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  static const decimalDigitsRegex = r'[0-9]';
  static const specialCharactersRegex = r'[!@#\$&*~.]';
  static const whitespaceFreeRegex = r'^\S*$';

  static bool isNotBlank(
    String? value,
  ) =>
      value?.trim().isNotEmpty ?? false;

  static bool isLengthValid(
    String? value,
    int min, [
    int? max,
  ]) {
    int length = value?.length ?? 0;
    return length >= min && (max == null || length <= max);
  }

  static bool isAgeValid(
    DateTime dateOfBirth,
    int min,
  ) {
    final currentDateTime = DateTime.now();
    return DateTime(
              currentDateTime.year,
              currentDateTime.month,
              currentDateTime.day,
            ).difference(dateOfBirth).inDays /
            numberOfDaysInYear <
        min;
  }

  static bool isEmail(
    String? value,
  ) =>
      RegExp(emailRegex).hasMatch(value!);

  static bool isPhoneNumber(
    String? value,
  ) =>
      RegExp(phoneNumberRegex).hasMatch(value!);

  static bool isContaining(
    String? value,
    Set<String?> strings,
  ) {
    if (value == null || strings.isEmpty) {
      return false;
    }

    final regex = strings
        .where(
          (string) => AppValidator.isNotBlank(string),
        )
        .join('|');
    return regex.isNotEmpty
        ? value.contains(
            RegExp(regex, caseSensitive: false),
          )
        : false;
  }

  static bool hasDigits(
    String? value,
  ) =>
      value?.contains(
        RegExp(decimalDigitsRegex),
      ) ??
      false;

  static bool hasSpecialCharacters(
    String? value,
  ) =>
      value?.contains(
        RegExp(specialCharactersRegex),
      ) ??
      false;

  static bool isWhitespaceFree(
    String? value,
  ) =>
      value?.contains(
        RegExp(whitespaceFreeRegex),
      ) ??
      false;

  static bool isSvgIcon(String? imageName) {
    if (imageName == null || imageName.isEmpty) {
      return false;
    } else {
      return ((imageName.endsWith(".svg") ||
          imageName.endsWith(".SVG") ||
          imageName.endsWith(".Svg")));
    }
  }
}
