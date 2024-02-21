class BibleReference {
  int bookNum;
  int chapter;
  
  BibleReference(this.bookNum, this.chapter);

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
}