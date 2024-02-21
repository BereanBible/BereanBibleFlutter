import 'package:berean_bible_app/BibleReference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:berean_bible_app/main.dart';

class BibleReferenceNavigator extends StatefulWidget {
  @override
  _BibleReferenceNavigatorState createState() => _BibleReferenceNavigatorState();
}

class _BibleReferenceNavigatorState extends State<BibleReferenceNavigator> {
  late BibleReference reference;

  @override
  Widget build(BuildContext context) {
    reference = Provider.of<MyAppState>(context, listen: false).getReaderRef();
    return Text(reference.book() + " " + reference.chapter.toString());
  }
}