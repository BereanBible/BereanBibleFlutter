import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:berean_bible_app/main.dart';

class MarginTitle extends StatefulWidget {
  @override
  _MarginTitleState createState() => _MarginTitleState();
}

class _MarginTitleState extends State<MarginTitle> {
  var reference = "";

  @override
  Widget build(BuildContext context) {
    return Text("Margin Title");
  }
}