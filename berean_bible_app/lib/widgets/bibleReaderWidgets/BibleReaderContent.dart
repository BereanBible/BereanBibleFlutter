import 'package:berean_bible_app/classes/BiblePassage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:berean_bible_app/classes/BibleReference.dart';
import 'package:berean_bible_app/main.dart';
import 'package:berean_bible_app/getPassageFunction.dart';

class BibleReaderContent extends StatefulWidget {
  @override
  State<BibleReaderContent> createState() => _BibleReaderContentState();
}

class _BibleReaderContentState extends State<BibleReaderContent> {
  late BibleReference reference;
  late Future<BiblePassage> passage;

  @override
  Widget build(BuildContext context) {
    reference = Provider.of<MyAppState>(context, listen: false).getReaderRef();
    passage = getPassage(reference);
    return Scaffold(
      body: Center(
        child: FutureBuilder<BiblePassage>(
          future: passage,
          builder: (BuildContext context, AsyncSnapshot<BiblePassage> snapshot) {
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
                  return SingleChildScrollView(
                    child: Padding(padding: EdgeInsets.all(15.0),
                      child: Wrap(
                        children: <Widget>[
                          Text(snapshot.data.toString())
                        ]
                      )
                    )
                  );
                }
            }
          },
        ),
      ),
    );
  }
}