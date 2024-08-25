import 'dart:ui';

enum LanguageType { ENGLISH, HINDI }

const String HINDI = "हिन्दी";
const String ENGLISH = "en";
const String ASSETS_PATH_LOCALISATIONS = "assets/";
const Locale HINDI_LOCAL = Locale("हिन्दी","Bharat");
const Locale ENGLISH_LOCAL = Locale("en","US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.HINDI:
        return HINDI;
    }
  }
}
