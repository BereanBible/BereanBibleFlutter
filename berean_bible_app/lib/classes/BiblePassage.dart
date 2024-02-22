import 'package:berean_bible_app/classes/BibleReference.dart';
import 'package:berean_bible_app/classes/BibleVerse.dart';

class BiblePassage {
  BibleReference reference;
  List<BibleVerse> verses;
  
  BiblePassage(this.reference, this.verses);

  @override
  String toString() {
    // TODO: implement toString
    String strForm = (reference.toString() + "--\n");
    for (var v in verses) {
      strForm += v.reference.verseNum.toString() + " " + v.verseText + " ";
    }
    return strForm;
  }
}