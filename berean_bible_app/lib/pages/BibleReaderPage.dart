import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:berean_bible_app/classes/BibleReference.dart';
import 'package:berean_bible_app/widgets/bibleReaderWidgets/BibleReaderContent.dart';
import 'package:berean_bible_app/widgets/bibleReaderWidgets/BibleBottomNavBar.dart';
import 'package:berean_bible_app/main.dart';

class BibleReaderPage extends StatefulWidget {
  @override
  State<BibleReaderPage> createState() => _BibleReaderPageState();
}

class _BibleReaderPageState extends State<BibleReaderPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Needed for AutomaticKeepAliveClientMixin

    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return ValueListenableBuilder(
        valueListenable: Provider.of<MyAppState>(context).readerReference,
        builder: (context, BibleReference value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* DEBUG:
              SafeArea(
                child: (sizingInformation.deviceScreenType != DeviceScreenType.desktop) ? 
                  ElevatedButton(
                    onPressed: () {
                      // Accessing MyHomePage state from MyApp state and calling _changePage function
                      if (sizingInformation.deviceScreenType != DeviceScreenType.desktop) {
                        Provider.of<MyAppState>(context, listen: false).changePage(0);
                      }
                    },
                    child: Text('Go to Margin Editor Page'),
                  )
                :
                  Text('Nothin')
              ),
              */
              Expanded(
                child: BibleReaderContent(reference: value)
              ),
              SafeArea(
                child: BibleBottomNavBar(reference: value)
              )
            ],
          );
        }
      );
    });
  }
}