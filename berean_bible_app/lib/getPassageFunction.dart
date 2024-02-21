import 'package:berean_bible_app/BibleReference.dart';
import 'package:http/http.dart' as http;

Future<String> getPassage(BibleReference ref) async {
  await Future.delayed(Duration(seconds: 2));
  return ("Default getPassage() return: ref=" + ref.toString());
}

Future<String> _fetchURL(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.body.toString();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Bible source connection error');
  }
}