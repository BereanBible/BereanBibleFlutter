import 'package:berean_bible_app/functions/bibleUtilFunctions.dart';

class BibleReference {
  int bookNum;
  int chapter;
  int verseNum;
  
  BibleReference(this.bookNum, this.chapter, this.verseNum);

  @override
  String toString() {
    String strForm = getBookName(bookNum) + " " + chapter.toString() + ((verseNum!=0)? (":"+verseNum.toString()) : "");
    return strForm;
  }
}