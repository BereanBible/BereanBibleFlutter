import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:berean_bible_app/widgets/MarginEditorContent.dart';
import 'package:berean_bible_app/widgets/BibleBottomNavBar.dart';
import 'package:berean_bible_app/main.dart';

class MarginEditorPage extends StatefulWidget {
  @override
  State<MarginEditorPage> createState() => _MarginEditorPageState();
}

class _MarginEditorPageState extends State<MarginEditorPage> {

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
        Expanded(child: MarginEditorContent()),
        SafeArea(
          child: ElevatedButton(
            onPressed: () {
              // Accessing MyHomePage state from MyApp state and calling _changePage function
              Provider.of<MyAppState>(context, listen: false).changePage(1);
            },
            child: Text('Go to Bible Reader Page'),
          ),
        ),
        SafeArea(
          child: BibleBottomNavBar()
        )
      ],
    );
  }
}