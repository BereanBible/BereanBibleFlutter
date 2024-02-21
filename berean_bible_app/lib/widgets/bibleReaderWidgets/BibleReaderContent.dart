import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:berean_bible_app/BibleReference.dart';
import 'package:berean_bible_app/main.dart';
import 'package:berean_bible_app/getPassage.dart';

class BibleReaderContent extends StatefulWidget {
  @override
  State<BibleReaderContent> createState() => _BibleReaderContentState();
}

class _BibleReaderContentState extends State<BibleReaderContent> {
  late BibleReference reference;
  late Future<String> passage;

  @override
  Widget build(BuildContext context) {
    reference = Provider.of<MyAppState>(context, listen: false).getReaderRef();
    passage = getPassage(reference);
    return Scaffold(
      body: Center(
        child: FutureBuilder<String>(
          future: passage,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Select Reference');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                if (snapshot.hasError){
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('Passage: ${snapshot.data}');
                }
            }
          },
        ),
      ),
    );
  }
}