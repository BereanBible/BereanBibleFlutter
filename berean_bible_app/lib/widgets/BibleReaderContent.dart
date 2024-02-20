import 'package:flutter/material.dart';

class BibleReaderContent extends StatefulWidget {
  @override
  State<BibleReaderContent> createState() => _BibleReaderContentState();
}

class _BibleReaderContentState extends State<BibleReaderContent> {
  var reference = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Bible Home Page'),
      ),
    );
  }
}