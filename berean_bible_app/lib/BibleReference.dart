class BibleReference {
  int bookNum;
  int chapter;
  int verse;
  
  BibleReference(this.bookNum, this.chapter, {this.verse = 0});

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
    String strForm = book() + " " + chapter.toString() + ((verse!=0)? (":"+verse.toString()) : "");
    return strForm;
  }
}