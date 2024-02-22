// Utility functions

String getBookName(int bkNum) {
  String bookName;
  
  switch (bkNum) {
    case 1: // Genesis
      bookName = "Genesis";
      break;
    case 2: // Exodus
      bookName = "Exodus";
      break;
    case 3: // Leviticus
      bookName = "Leviticus";
      break;
    case 4: // Numbers
      bookName = "Numbers";
      break;
    case 5: // Deuteronomy
      bookName = "Deuteronomy";
      break;
    case 6: // Joshua
      bookName = "Joshua";
      break;
    case 7: // Judges
      bookName = "Judges";
      break;
    case 8: // Ruth
      bookName = "Ruth";
      break;
    case 9: // 1 Samuel
      bookName = "1 Samuel";
      break;
    case 10: // 2 Samuel
      bookName = "2 Samuel";
      break;
    case 11: // 1 Kings
      bookName = "1 Kings";
      break;
    case 12: // 2 Kings
      bookName = "2 Kings";
      break;
    case 13: // 1 Chronicles
      bookName = "1 Chronicles";
      break;
    case 14: // 2 Chronicles
      bookName = "2 Chronicles";
      break;
    case 15: // Ezra
      bookName = "Ezra";
      break;
    case 16: // Nehemiah
      bookName = "Nehemiah";
      break;
    case 17: // Esther
      bookName = "Esther";
      break;
    case 18: // Job
      bookName = "Job";
      break;
    case 19: // Psalms
      bookName = "Psalms";
      break;
    case 20: // Proverbs
      bookName = "Proverbs";
      break;
    case 21: // Ecclesiastes
      bookName = "Ecclesiastes";
      break;
    case 22: // Song of Solomon
      bookName = "Song of Solomon";
      break;
    case 23: // Isaiah
      bookName = "Isaiah";
      break;
    case 24: // Jeremiah
      bookName = "Jeremiah";
      break;
    case 25: // Lamentations
      bookName = "Lamentations";
      break;
    case 26: // Ezekiel
      bookName = "Ezekiel";
      break;
    case 27: // Daniel
      bookName = "Daniel";
      break;
    case 28: // Hosea
      bookName = "Hosea";
      break;
    case 29: // Joel
      bookName = "Joel";
      break;
    case 30: // Amos
      bookName = "Amos";
      break;
    case 31: // Obadiah
      bookName = "Obadiah";
      break;
    case 32: // Jonah
      bookName = "Jonah";
      break;
    case 33: // Micah
      bookName = "Micah";
      break;
    case 34: // Nahum
      bookName = "Nahum";
      break;
    case 35: // Habakkuk
      bookName = "Habakkuk";
      break;
    case 36: // Zephaniah
      bookName = "Zephaniah";
      break;
    case 37: // Haggai
      bookName = "Haggai";
      break;
    case 38: // Zechariah
      bookName = "Zechariah";
      break;
    case 39: // Malachi
      bookName = "Malachi";
      break;
    case 40: // Matthew
      bookName = "Matthew";
      break;
    case 41: // Mark
      bookName = "Mark";
      break;
    case 42: // Luke
      bookName = "Luke";
      break;
    case 43: // John
      bookName = "John";
      break;
    case 44: // Acts
      bookName = "Acts";
      break;
    case 45: // Romans
      bookName = "Romans";
      break;
    case 46: // 1 Corinthians
      bookName = "1 Corinthians";
      break;
    case 47: // 2 Corinthians
      bookName = "2 Corinthians";
      break;
    case 48: // Galatians
      bookName = "Galatians";
      break;
    case 49: // Ephesians
      bookName = "Ephesians";
      break;
    case 50: // Philippians
      bookName = "Philippians";
      break;
    case 51: // Colossians
      bookName = "Colossians";
      break;
    case 52: // 1 Thessalonians
      bookName = "1 Thessalonians";
      break;
    case 53: // 2 Thessalonians
      bookName = "2 Thessalonians";
      break;
    case 54: // 1 Timothy
      bookName = "1 Timothy";
      break;
    case 55: // 2 Timothy
      bookName = "2 Timothy";
      break;
    case 56: // Titus
      bookName = "Titus";
      break;
    case 57: // Philemon
      bookName = "Philemon";
      break;
    case 58: // Hebrews
      bookName = "Hebrews";
      break;
    case 59: // James
      bookName = "James";
      break;
    case 60: // 1 Peter
      bookName = "1 Peter";
      break;
    case 61: // 2 Peter
      bookName = "2 Peter";
      break;
    case 62: // 1 John
      bookName = "1 John";
      break;
    case 63: // 2 John
      bookName = "2 John";
      break;
    case 64: // 3 John
      bookName = "3 John";
      break;
    case 65: // Jude
      bookName = "Jude";
      break;
    case 66: // Revelation
      bookName = "Revelation";
      break;
    default:
      bookName = "Unimplemnted_Book_Number";
  }
  
  return bookName;
}

int getNumChapters(int bkNum) {
  int numOfChapters;
  switch (bkNum) {
    case 1: // Genesis
      numOfChapters = 50;
      break;
    case 2: // Exodus
      numOfChapters = 40;
      break;
    case 3: // Leviticus
      numOfChapters = 27;
      break;
    case 4: // Numbers
      numOfChapters = 36;
      break;
    case 5: // Deuteronomy
      numOfChapters = 34;
      break;
    case 6: // Joshua
      numOfChapters = 24;
      break;
    case 7: // Judges
      numOfChapters = 21;
      break;
    case 8: // Ruth
      numOfChapters = 4;
      break;
    case 9: // 1 Samuel
      numOfChapters = 31;
      break;
    case 10: // 2 Samuel
      numOfChapters = 24;
      break;
    case 11: // 1 Kings
      numOfChapters = 22;
      break;
    case 12: // 2 Kings
      numOfChapters = 25;
      break;
    case 13: // 1 Chronicles
      numOfChapters = 29;
      break;
    case 14: // 2 Chronicles
      numOfChapters = 36;
      break;
    case 15: // Ezra
      numOfChapters = 10;
      break;
    case 16: // Nehemiah
      numOfChapters = 13;
      break;
    case 17: // Esther
      numOfChapters = 10;
      break;
    case 18: // Job
      numOfChapters = 42;
      break;
    case 19: // Psalms
      numOfChapters = 150;
      break;
    case 20: // Proverbs
      numOfChapters = 31;
      break;
    case 21: // Ecclesiastes
      numOfChapters = 12;
      break;
    case 22: // Song of Solomon
      numOfChapters = 8;
      break;
    case 23: // Isaiah
      numOfChapters = 66;
      break;
    case 24: // Jeremiah
      numOfChapters = 52;
      break;
    case 25: // Lamentations
      numOfChapters = 5;
      break;
    case 26: // Ezekiel
      numOfChapters = 48;
      break;
    case 27: // Daniel
      numOfChapters = 12;
      break;
    case 28: // Hosea
      numOfChapters = 14;
      break;
    case 29: // Joel
      numOfChapters = 3;
      break;
    case 30: // Amos
      numOfChapters = 9;
      break;
    case 31: // Obadiah
      numOfChapters = 1;
      break;
    case 32: // Jonah
      numOfChapters = 4;
      break;
    case 33: // Micah
      numOfChapters = 7;
      break;
    case 34: // Nahum
      numOfChapters = 3;
      break;
    case 35: // Habakkuk
      numOfChapters = 3;
      break;
    case 36: // Zephaniah
      numOfChapters = 3;
      break;
    case 37: // Haggai
      numOfChapters = 2;
      break;
    case 38: // Zechariah
      numOfChapters = 14;
      break;
    case 39: // Malachi
      numOfChapters = 4;
      break;
    case 40: // Matthew
      numOfChapters = 28;
      break;
    case 41: // Mark
      numOfChapters = 16;
      break;
    case 42: // Luke
      numOfChapters = 24;
      break;
    case 43: // John
      numOfChapters = 21;
      break;
    case 44: // Acts
      numOfChapters = 28;
      break;
    case 45: // Romans
      numOfChapters = 16;
      break;
    case 46: // 1 Corinthians
      numOfChapters = 16;
      break;
    case 47: // 2 Corinthians
      numOfChapters = 13;
      break;
    case 48: // Galatians
      numOfChapters = 6;
      break;
    case 49: // Ephesians
      numOfChapters = 6;
      break;
    case 50: // Philippians
      numOfChapters = 4;
      break;
    case 51: // Colossians
      numOfChapters = 4;
      break;
    case 52: // 1 Thessalonians
      numOfChapters = 5;
      break;
    case 53: // 2 Thessalonians
      numOfChapters = 3;
      break;
    case 54: // 1 Timothy
      numOfChapters = 6;
      break;
    case 55: // 2 Timothy
      numOfChapters = 4;
      break;
    case 56: // Titus
      numOfChapters = 3;
      break;
    case 57: // Philemon
      numOfChapters = 1;
      break;
    case 58: // Hebrews
      numOfChapters = 13;
      break;
    case 59: // James
      numOfChapters = 5;
      break;
    case 60: // 1 Peter
      numOfChapters = 5;
      break;
    case 61: // 2 Peter
      numOfChapters = 3;
      break;
    case 62: // 1 John
      numOfChapters = 5;
      break;
    case 63: // 2 John
      numOfChapters = 1;
      break;
    case 64: // 3 John
      numOfChapters = 1;
      break;
    case 65: // Jude
      numOfChapters = 1;
      break;
    case 66: // Revelation
      numOfChapters = 22;
      break;
    default:
      numOfChapters = -1; // or some other default value
  }
  return numOfChapters;
}