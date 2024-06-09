import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

abstract class BottomSheetItem {
  String? get label;
}

enum Language implements BottomSheetItem {
  english(
    code: Constants.englishLanguageCode,
    name: 'English',
  ),
  arabic(
    code: Constants.arabicLanguageCode,
    name: 'العربية',
  );

  final String code;
  final String name;

  const Language({
    required this.code,
    required this.name,
  });

  static Language? fromCode(
    String code,
  ) =>
      Language.values.firstWhereOrNull(
        (language) => language.code == code,
      );

  Locale asLocale() => Locale(
        code,
      );

  @override
  String? get label => name;
}

class LocalizationsUtils {
  final BuildContext context;

  static late LocalizationsUtils _instance;

  static AppLocalizations? get appLocalizations =>
      AppLocalizations.of(_instance.context);

  static Language? get currentLanguage => Language.fromCode(
        Intl.getCurrentLocale(),
      );

  const LocalizationsUtils._internal(
    this.context,
  );

  static void init(
    BuildContext context,
  ) =>
      _instance = LocalizationsUtils._internal(
        context,
      );
}
