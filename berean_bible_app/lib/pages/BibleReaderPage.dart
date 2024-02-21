import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:berean_bible_app/widgets/bibleReaderWidgets/BibleReaderContent.dart';
import 'package:berean_bible_app/widgets/bibleReaderWidgets/BibleBottomNavBar.dart';
import 'package:berean_bible_app/main.dart';

class BibleReaderPage extends StatefulWidget {
  @override
  State<BibleReaderPage> createState() => _BibleReaderPageState();
}

class _BibleReaderPageState extends State<BibleReaderPage> {

  @override
  Widget build(BuildContext context) {
    
    return ResponsiveBuilder(builder: (context, sizingInformation) {
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
          (sizingInformation.deviceScreenType != DeviceScreenType.desktop) ? 
            SafeArea(
              child: ElevatedButton(
                    onPressed: () {
                      // Accessing MyHomePage state from MyApp state and calling _changePage function
                      if (sizingInformation.deviceScreenType != DeviceScreenType.desktop) {
                        Provider.of<MyAppState>(context, listen: false).changePage(0);
                      }
                    },
                    child: Text('Go to Margin Editor Page'),
              ),
            )
          :
          SafeArea(
            child: Text('Nothin')
          )
          ,
          SafeArea(
            child: BibleBottomNavBar()
          )
        ],
      );
    });
  }
}