import 'package:flutter/material.dart';
import 'package:berean_bible_app/widgets/BibleReaderContent.dart';
import 'package:berean_bible_app/widgets/BibleBottomNavBar.dart';


class BibleReaderPage extends StatefulWidget {
  @override
  State<BibleReaderPage> createState() => _BibleReaderPageState();
}

class _BibleReaderPageState extends State<BibleReaderPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      // Column is also a layout widget. It takes a list of children and
      // arranges them vertically. By default, it sizes itself to fit its
      // children horizontally, and tries to be as tall as its parent.
      //
      // Column has various properties to control how it sizes itself and
      // how it positions its children. Here we use mainAxisAlignment to
      // center the children vertically; the main axis here is the vertical
      // axis because Columns are vertical (the cross axis would be
      // horizontal).
      //
      // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
      // action in the IDE, or press "p" in the console), to see the
      // wireframe for each widget.
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: BibleReaderContent()),
        SafeArea(
          child: BibleBottomNavBar()
        )
      ],
    );
  }
}