import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:berean_bible_app/widgets/marginWidgets/MarginEditorContent.dart';
import 'package:berean_bible_app/main.dart';

class MarginEditorPage extends StatefulWidget {
  @override
  State<MarginEditorPage> createState() => _MarginEditorPageState();
}

class _MarginEditorPageState extends State<MarginEditorPage> {

  @override
  Widget build(BuildContext context) {
    
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: MarginEditorContent()),
          (sizingInformation.deviceScreenType != DeviceScreenType.desktop) ? 
            SafeArea(
              child: /*DEBUG*/CupertinoButton(
                onPressed: () {
                  // Accessing MyHomePage state from MyApp state and calling _changePage function
                  if (sizingInformation.deviceScreenType != DeviceScreenType.desktop) {
                    Provider.of<MyAppState>(context, listen: false).changePage(1);
                  }
                },
                child: Text('Go to Bible Reader Page'),
              ),
            )
          :
          SafeArea(
            child: Text('Nothin')
          ),
        ],
      );
    });
  }
}