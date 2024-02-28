import 'package:berean_bible_app/classes/BibleReference.dart';
import 'package:berean_bible_app/widgets/navBarWidgets/BibleReferenceNavigator.dart';
import 'package:berean_bible_app/widgets/navBarWidgets/MarginTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:berean_bible_app/main.dart';

class TopNavBar extends StatefulWidget implements ObstructingPreferredSizeWidget {
  final String? title;

  const TopNavBar({Key? key, this.title}) : super(key: key);

  @override
  _TopNavBarState createState() => _TopNavBarState();

  @override
  Size get preferredSize => const Size.fromHeight(44.0); // Manually setting height

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}

class _TopNavBarState extends State<TopNavBar> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: Provider.of<MyAppState>(context).pageIndexNotifier,
      builder: (context, value, child) {
        return ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if (sizingInformation.deviceScreenType != DeviceScreenType.desktop) {
              // Main Mobile View
              return CupertinoNavigationBar(
                backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
                leading: LeftButton(),
                middle: TopNavBarTitle(),
                trailing: SettingsButton(),
              );
            } else {
              // Desktop View
              return CupertinoNavigationBar(
                backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
                leading: MarginFolderButton(),
                middle: Row(
                  children: [MarginTitle(), BibleReferenceNavigatorWrapper()]
                ),
                trailing: SettingsButton(),
              );
            }
          },
        ); // Rebuilds whenever the pageController changes
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
          BibleAaButton();
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
          MarginTitle()
          :
          BibleReferenceNavigatorWrapper();
      },
    );
  }
}



class BibleReferenceNavigatorWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Provider.of<MyAppState>(context).readerReference,
      builder: (context, BibleReference value, child) {
        return BibleReferenceNavigator(reference: value);
      }
    );
  }
}


class SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Icon(
        CupertinoIcons.settings, 
        color: CupertinoTheme.of(context).primaryContrastingColor
      ),
      onPressed: () {
        print("Hi");
      },
    );
  }
}

class MarginFolderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Icon(
        CupertinoIcons.folder,
        color: CupertinoTheme.of(context).primaryContrastingColor,
      ),
      onPressed: () {
        print("MarginFolderPressed");
      },
    );
  }
}

class BibleAaButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Icon(
        CupertinoIcons.textformat_abc,
        color: CupertinoTheme.of(context).primaryContrastingColor,
      ), 
      onPressed: () {
        print("BibleAaButton pressed");
      },
    );
  }
}