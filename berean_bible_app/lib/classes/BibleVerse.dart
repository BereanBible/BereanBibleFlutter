import 'package:berean_bible_app/classes/BibleReference.dart';

class BibleVerse {  
  BibleReference reference;
  String verseText;
  
  BibleVerse(this.reference, this.verseText);

  @override
  String toString() {
    String strForm = (reference.toString() + "\"" + verseText + "\"");
    return strForm;
  }
}