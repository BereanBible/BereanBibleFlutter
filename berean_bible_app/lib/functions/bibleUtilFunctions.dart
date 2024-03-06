// Utility functions

var bibleBooks = {
  'Genesis': {'bookNumber': 1, 'numberOfChapters': 50},
  'Exodus': {'bookNumber': 2, 'numberOfChapters': 40},
  'Leviticus': {'bookNumber': 3, 'numberOfChapters': 27},
  'Numbers': {'bookNumber': 4, 'numberOfChapters': 36},
  'Deuteronomy': {'bookNumber': 5, 'numberOfChapters': 34},
  'Joshua': {'bookNumber': 6, 'numberOfChapters': 24},
  'Judges': {'bookNumber': 7, 'numberOfChapters': 21},
  'Ruth': {'bookNumber': 8, 'numberOfChapters': 4},
  '1 Samuel': {'bookNumber': 9, 'numberOfChapters': 31},
  '2 Samuel': {'bookNumber': 10, 'numberOfChapters': 24},
  '1 Kings': {'bookNumber': 11, 'numberOfChapters': 22},
  '2 Kings': {'bookNumber': 12, 'numberOfChapters': 25},
  '1 Chronicles': {'bookNumber': 13, 'numberOfChapters': 29},
  '2 Chronicles': {'bookNumber': 14, 'numberOfChapters': 36},
  'Ezra': {'bookNumber': 15, 'numberOfChapters': 10},
  'Nehemiah': {'bookNumber': 16, 'numberOfChapters': 13},
  'Esther': {'bookNumber': 17, 'numberOfChapters': 10},
  'Job': {'bookNumber': 18, 'numberOfChapters': 42},
  'Psalms': {'bookNumber': 19, 'numberOfChapters': 150},
  'Proverbs': {'bookNumber': 20, 'numberOfChapters': 31},
  'Ecclesiastes': {'bookNumber': 21, 'numberOfChapters': 12},
  'Song of Solomon': {'bookNumber': 22, 'numberOfChapters': 8},
  'Isaiah': {'bookNumber': 23, 'numberOfChapters': 66},
  'Jeremiah': {'bookNumber': 24, 'numberOfChapters': 52},
  'Lamentations': {'bookNumber': 25, 'numberOfChapters': 5},
  'Ezekiel': {'bookNumber': 26, 'numberOfChapters': 48},
  'Daniel': {'bookNumber': 27, 'numberOfChapters': 12},
  'Hosea': {'bookNumber': 28, 'numberOfChapters': 14},
  'Joel': {'bookNumber': 29, 'numberOfChapters': 3},
  'Amos': {'bookNumber': 30, 'numberOfChapters': 9},
  'Obadiah': {'bookNumber': 31, 'numberOfChapters': 1},
  'Jonah': {'bookNumber': 32, 'numberOfChapters': 4},
  'Micah': {'bookNumber': 33, 'numberOfChapters': 7},
  'Nahum': {'bookNumber': 34, 'numberOfChapters': 3},
  'Habakkuk': {'bookNumber': 35, 'numberOfChapters': 3},
  'Zephaniah': {'bookNumber': 36, 'numberOfChapters': 3},
  'Haggai': {'bookNumber': 37, 'numberOfChapters': 2},
  'Zechariah': {'bookNumber': 38, 'numberOfChapters': 14},
  'Malachi': {'bookNumber': 39, 'numberOfChapters': 4},
  'Matthew': {'bookNumber': 40, 'numberOfChapters': 28},
  'Mark': {'bookNumber': 41, 'numberOfChapters': 16},
  'Luke': {'bookNumber': 42, 'numberOfChapters': 24},
  'John': {'bookNumber': 43, 'numberOfChapters': 21},
  'Acts': {'bookNumber': 44, 'numberOfChapters': 28},
  'Romans': {'bookNumber': 45, 'numberOfChapters': 16},
  '1 Corinthians': {'bookNumber': 46, 'numberOfChapters': 16},
  '2 Corinthians': {'bookNumber': 47, 'numberOfChapters': 13},
  'Galatians': {'bookNumber': 48, 'numberOfChapters': 6},
  'Ephesians': {'bookNumber': 49, 'numberOfChapters': 6},
  'Philippians': {'bookNumber': 50, 'numberOfChapters': 4},
  'Colossians': {'bookNumber': 51, 'numberOfChapters': 4},
  '1 Thessalonians': {'bookNumber': 52, 'numberOfChapters': 5},
  '2 Thessalonians': {'bookNumber': 53, 'numberOfChapters': 3},
  '1 Timothy': {'bookNumber': 54, 'numberOfChapters': 6},
  '2 Timothy': {'bookNumber': 55, 'numberOfChapters': 4},
  'Titus': {'bookNumber': 56, 'numberOfChapters': 3},
  'Philemon': {'bookNumber': 57, 'numberOfChapters': 1},
  'Hebrews': {'bookNumber': 58, 'numberOfChapters': 13},
  'James': {'bookNumber': 59, 'numberOfChapters': 5},
  '1 Peter': {'bookNumber': 60, 'numberOfChapters': 5},
  '2 Peter': {'bookNumber': 61, 'numberOfChapters': 3},
  '1 John': {'bookNumber': 62, 'numberOfChapters': 5},
  '2 John': {'bookNumber': 63, 'numberOfChapters': 1},
  '3 John': {'bookNumber': 64, 'numberOfChapters': 1},
  'Jude': {'bookNumber': 65, 'numberOfChapters': 1},
  'Revelation': {'bookNumber': 66, 'numberOfChapters': 22},
};



int? getBookNum(String bkName) {
  String bkNameQuery = bkName.trimRight();
  int? bookNum = bibleBooks[bkNameQuery]?['bookNumber'];
  if (bookNum == null) {
    for (var key in bibleBooks.keys) {
      if (key.contains(bkNameQuery)) {
        bookNum = bibleBooks[key]?['bookNumber'];
        break; // Exit the loop after finding the first match
      }
    }
  }
  /*DEBUG*/print('GetBookNum returing: ${bookNum.toString()} (${((bookNum==null) ? 'null' : getBookName(bookNum))}) for: $bkName');
  return bookNum;
}

String getBookName(int bkNum) {
  String? bookName;
  bookName = bibleBooks.keys.elementAt(bkNum-1).toString();
  // switch (bkNum) {
  //   case 1: // Genesis
  //     bookName = "Genesis";
  //     break;
  //   case 2: // Exodus
  //     bookName = "Exodus";
  //     break;
  //   case 3: // Leviticus
  //     bookName = "Leviticus";
  //     break;
  //   case 4: // Numbers
  //     bookName = "Numbers";
  //     break;
  //   case 5: // Deuteronomy
  //     bookName = "Deuteronomy";
  //     break;
  //   case 6: // Joshua
  //     bookName = "Joshua";
  //     break;
  //   case 7: // Judges
  //     bookName = "Judges";
  //     break;
  //   case 8: // Ruth
  //     bookName = "Ruth";
  //     break;
  //   case 9: // 1 Samuel
  //     bookName = "1 Samuel";
  //     break;
  //   case 10: // 2 Samuel
  //     bookName = "2 Samuel";
  //     break;
  //   case 11: // 1 Kings
  //     bookName = "1 Kings";
  //     break;
  //   case 12: // 2 Kings
  //     bookName = "2 Kings";
  //     break;
  //   case 13: // 1 Chronicles
  //     bookName = "1 Chronicles";
  //     break;
  //   case 14: // 2 Chronicles
  //     bookName = "2 Chronicles";
  //     break;
  //   case 15: // Ezra
  //     bookName = "Ezra";
  //     break;
  //   case 16: // Nehemiah
  //     bookName = "Nehemiah";
  //     break;
  //   case 17: // Esther
  //     bookName = "Esther";
  //     break;
  //   case 18: // Job
  //     bookName = "Job";
  //     break;
  //   case 19: // Psalms
  //     bookName = "Psalms";
  //     break;
  //   case 20: // Proverbs
  //     bookName = "Proverbs";
  //     break;
  //   case 21: // Ecclesiastes
  //     bookName = "Ecclesiastes";
  //     break;
  //   case 22: // Song of Solomon
  //     bookName = "Song of Solomon";
  //     break;
  //   case 23: // Isaiah
  //     bookName = "Isaiah";
  //     break;
  //   case 24: // Jeremiah
  //     bookName = "Jeremiah";
  //     break;
  //   case 25: // Lamentations
  //     bookName = "Lamentations";
  //     break;
  //   case 26: // Ezekiel
  //     bookName = "Ezekiel";
  //     break;
  //   case 27: // Daniel
  //     bookName = "Daniel";
  //     break;
  //   case 28: // Hosea
  //     bookName = "Hosea";
  //     break;
  //   case 29: // Joel
  //     bookName = "Joel";
  //     break;
  //   case 30: // Amos
  //     bookName = "Amos";
  //     break;
  //   case 31: // Obadiah
  //     bookName = "Obadiah";
  //     break;
  //   case 32: // Jonah
  //     bookName = "Jonah";
  //     break;
  //   case 33: // Micah
  //     bookName = "Micah";
  //     break;
  //   case 34: // Nahum
  //     bookName = "Nahum";
  //     break;
  //   case 35: // Habakkuk
  //     bookName = "Habakkuk";
  //     break;
  //   case 36: // Zephaniah
  //     bookName = "Zephaniah";
  //     break;
  //   case 37: // Haggai
  //     bookName = "Haggai";
  //     break;
  //   case 38: // Zechariah
  //     bookName = "Zechariah";
  //     break;
  //   case 39: // Malachi
  //     bookName = "Malachi";
  //     break;
  //   case 40: // Matthew
  //     bookName = "Matthew";
  //     break;
  //   case 41: // Mark
  //     bookName = "Mark";
  //     break;
  //   case 42: // Luke
  //     bookName = "Luke";
  //     break;
  //   case 43: // John
  //     bookName = "John";
  //     break;
  //   case 44: // Acts
  //     bookName = "Acts";
  //     break;
  //   case 45: // Romans
  //     bookName = "Romans";
  //     break;
  //   case 46: // 1 Corinthians
  //     bookName = "1 Corinthians";
  //     break;
  //   case 47: // 2 Corinthians
  //     bookName = "2 Corinthians";
  //     break;
  //   case 48: // Galatians
  //     bookName = "Galatians";
  //     break;
  //   case 49: // Ephesians
  //     bookName = "Ephesians";
  //     break;
  //   case 50: // Philippians
  //     bookName = "Philippians";
  //     break;
  //   case 51: // Colossians
  //     bookName = "Colossians";
  //     break;
  //   case 52: // 1 Thessalonians
  //     bookName = "1 Thessalonians";
  //     break;
  //   case 53: // 2 Thessalonians
  //     bookName = "2 Thessalonians";
  //     break;
  //   case 54: // 1 Timothy
  //     bookName = "1 Timothy";
  //     break;
  //   case 55: // 2 Timothy
  //     bookName = "2 Timothy";
  //     break;
  //   case 56: // Titus
  //     bookName = "Titus";
  //     break;
  //   case 57: // Philemon
  //     bookName = "Philemon";
  //     break;
  //   case 58: // Hebrews
  //     bookName = "Hebrews";
  //     break;
  //   case 59: // James
  //     bookName = "James";
  //     break;
  //   case 60: // 1 Peter
  //     bookName = "1 Peter";
  //     break;
  //   case 61: // 2 Peter
  //     bookName = "2 Peter";
  //     break;
  //   case 62: // 1 John
  //     bookName = "1 John";
  //     break;
  //   case 63: // 2 John
  //     bookName = "2 John";
  //     break;
  //   case 64: // 3 John
  //     bookName = "3 John";
  //     break;
  //   case 65: // Jude
  //     bookName = "Jude";
  //     break;
  //   case 66: // Revelation
  //     bookName = "Revelation";
  //     break;
  //   default:
  //     bookName = "Unimplemnted_Book_Number";
  // }
  return bookName;
}

int getNumChapters(int bkNum) {
  int? numOfChapters;
  numOfChapters = bibleBooks[bibleBooks.keys.elementAt(bkNum-1)]?['numberOfChapters'];
  return numOfChapters ?? 0;
}

List<String> getAllBookNames() {
  return bibleBooks.keys.toList();
}