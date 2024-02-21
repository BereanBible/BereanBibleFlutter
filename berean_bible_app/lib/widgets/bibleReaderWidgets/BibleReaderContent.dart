import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:berean_bible_app/BibleReference.dart';
import 'package:berean_bible_app/main.dart';

class BibleReaderContent extends StatefulWidget {
  @override
  State<BibleReaderContent> createState() => _BibleReaderContentState();
}

class _BibleReaderContentState extends State<BibleReaderContent> {
  late BibleReference reference;

  @override
  Widget build(BuildContext context) {
    reference = Provider.of<MyAppState>(context, listen: false).getReaderRef();
    return Scaffold(
      body: Center(
        child: Text("Ref=" + reference.book() + " " + reference.chapter.toString()),
      ),
    );
  }
}