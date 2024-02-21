import 'package:flutter/material.dart';

class MarginEditorContent extends StatefulWidget {
  @override
  State<MarginEditorContent> createState() => _MarginEditorContentState();
}

class _MarginEditorContentState extends State<MarginEditorContent> {
  var reference = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Margin Home Page'),
      ),
    );
  }
}