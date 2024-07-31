enum LanguageType {ENGLISH, HINDI}

const String HINDI = "hi";
const String ENGLISH = "en";

extension LanguageTypeExtension on LanguageType{
  String getValue(){
    switch(this){

      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.HINDI:
        return HINDI;
    }
  }
}