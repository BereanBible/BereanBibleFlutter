class BibleReference {
  int bookNum;
  int chapter;
  int verseNum;
  
  BibleReference(this.bookNum, this.chapter, this.verseNum);

  String book() {
    String bookName;
    switch (bookNum) {
      case 1:
        bookName = "Genesis";
      default:
        bookName = "Unimplemnted_Book_Number";
    }
    return bookName;
  }

  @override
  String toString() {
    // TODO: implement toString
    String strForm = book() + " " + chapter.toString() + ((verseNum!=0)? (":"+verseNum.toString()) : "");
    return strForm;
  }
}