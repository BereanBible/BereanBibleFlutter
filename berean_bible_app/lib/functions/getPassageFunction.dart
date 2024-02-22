import 'package:berean_bible_app/classes/BibleReference.dart';
import 'package:berean_bible_app/classes/BibleVerse.dart';
import 'package:berean_bible_app/classes/BiblePassage.dart';
import 'package:berean_bible_app/functions/bibleUtilFunctions.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<BiblePassage> getPassage(BibleReference ref) async {  
  String url = 'https://bible-api.com/';
  url += getBookName(ref.bookNum) + " " + ref.chapter.toString() + ((ref.verseNum!=0)? (":"+ref.verseNum.toString()) : ""); // Format refrence for the API's url schema;
  Map jsonData = await _fetchURL(url);

  final verses = <BibleVerse>[];

  final jsonVerses = jsonData['verses'] as List<dynamic>;

  for (var v in jsonVerses) {
    BibleReference vRef = BibleReference(ref.bookNum, ref.chapter, v['verse']);
    String vText = v['text'].trim();
    verses.add(BibleVerse(vRef, vText));
  }

  return BiblePassage(ref, verses);
}

Future<Map> _fetchURL(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return json.decode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Bible source connection error');
  }
}