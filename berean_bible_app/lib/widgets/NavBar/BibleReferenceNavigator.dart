import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:berean_bible_app/main.dart';

class BibleReferenceNavigator extends StatefulWidget {
  @override
  _BibleReferenceNavigatorState createState() => _BibleReferenceNavigatorState();
}

class _BibleReferenceNavigatorState extends State<BibleReferenceNavigator> {
  var reference = "";

  @override
  Widget build(BuildContext context) {
    return Text("1 John 1:1");
  }
}