import 'package:berean_bible_app/widgets/NavBar/BibleReferenceNavigator.dart';
import 'package:berean_bible_app/widgets/NavBar/MarginTitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:berean_bible_app/main.dart';

class TopNavBar extends StatefulWidget implements PreferredSizeWidget {
  // TopNavBar({required Key key}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize = Size.fromHeight(kToolbarHeight); // default is 56.0

  @override
  _TopNavBarState createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  var reference = "";

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType != DeviceScreenType.desktop) {
            // Main Mobile View
            return AppBar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              leading: LeftButton(),
              title: TopNavBarTitle(),
              actions: [
                SettingsButton(),
              ],
            );
          } else {
            // Desktop View
            return AppBar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              leading: MarginFolderButton(),
              title: Row(
                children: [MarginTitle(), BibleReferenceNavigator()]
              ),
              actions: [
                SettingsButton(),
              ],
            );
          }
        },
      );
  }
}



class LeftButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(
      builder: (context, appState, child) {
        return (appState.getPage() == 0) ? 
          MarginFolderButton()
          :
          IconButton(icon: const Icon(Icons.circle), tooltip: 'Nothing', onPressed: () {print("Nothing");});
      },
    );
  }
}



class TopNavBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(
      builder: (context, appState, child) {
        return (appState.getPage() == 0) ? 
          Text("Margin Title 0")
          :
          Text("Bible Title 1");
      },
    );
  }
}



class SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      tooltip: 'Settings',
      onPressed: () {
        print("Hi");
      },
    );
  }
}



class MarginFolderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.folder),
      tooltip: 'Open Margin',
      onPressed: () {
        print("MarginFolderPressed");
      },
    );
  }
}