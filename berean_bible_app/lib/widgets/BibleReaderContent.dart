import 'package:flutter/material.dart';
import 'package:berean_bible_app/BibleReference.dart';

class BibleReaderContent extends StatefulWidget {
  @override
  State<BibleReaderContent> createState() => _BibleReaderContentState();
}

class _BibleReaderContentState extends State<BibleReaderContent> {
  BibleReference reference = BibleReference(1, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Bible Home Page'),
      ),
    );
  }
}