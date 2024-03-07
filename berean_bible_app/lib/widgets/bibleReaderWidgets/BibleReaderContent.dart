import 'package:berean_bible_app/classes/BiblePassage.dart';
import 'package:flutter/cupertino.dart';
import 'package:berean_bible_app/classes/BibleReference.dart';
import 'package:berean_bible_app/functions/getPassageFunction.dart';
import 'package:flutter/material.dart';

class BibleReaderContent extends StatefulWidget {
  final BibleReference reference;

  BibleReaderContent({required this.reference});

  @override
  State<BibleReaderContent> createState() => _BibleReaderContentState();
}

class _BibleReaderContentState extends State<BibleReaderContent> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late BibleReference _reference;
  late Future<BiblePassage> passage;

  @override
  void initState() {
    super.initState();
    _reference = widget.reference;
  }

  @override
  void didUpdateWidget(covariant BibleReaderContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.reference != oldWidget.reference) {
      setState(() {
        _reference = widget.reference;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Needed for AutomaticKeepAliveClientMixin

    // reference = Provider.of<MyAppState>(context, listen: false).getReaderRef();
    passage = getPassage(_reference);
    
    return CupertinoPageScaffold(
      child: Center(
        child: FutureBuilder<BiblePassage>(
          future: passage,
          builder: (BuildContext context, AsyncSnapshot<BiblePassage> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Select Reference');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return CupertinoActivityIndicator();
              case ConnectionState.done:
                if (snapshot.hasError){
                  return Text('Error: ${snapshot.error}');
                } else {
                  return SingleChildScrollView(
                    child: Padding(padding: EdgeInsets.all(15.0),
                      child: Wrap(
                        children: <Widget>[
                          Text(snapshot.data.toString(), style: Theme.of(context).textTheme.bodyMedium,)
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