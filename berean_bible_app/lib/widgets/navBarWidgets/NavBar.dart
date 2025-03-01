import 'package:berean_bible_app/classes/BibleReference.dart';
import 'package:berean_bible_app/widgets/navBarWidgets/MarginTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // For the text buttons & theme
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:berean_bible_app/main.dart';
/*DEBUG*/import 'package:berean_bible_app/widgets/OutlineBox.dart';
import 'package:berean_bible_app/widgets/navBarWidgets/RefSelector.dart';

class NavBar extends StatefulWidget implements ObstructingPreferredSizeWidget {
  final String? title;

  const NavBar({Key? key, this.title}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();

  @override
  Size get preferredSize => const Size.fromHeight(44.0); // Manually setting height

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ValueListenableBuilder<int>(
      valueListenable: Provider.of<MyAppState>(context).pageIndexNotifier,
      builder: (context, value, child) {
        return ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if (sizingInformation.deviceScreenType != DeviceScreenType.desktop) {
              // Main Mobile View
              return CupertinoNavigationBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                leading: LeftButton(),
                middle: TopNavBarTitle(),
                trailing: SettingsButton(),
              );
            } else {
              // Desktop View
              return CupertinoNavigationBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                leading: MarginFolderButton(),
                middle: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // WORKHERE: fix spacing of desktop nav bar elements
                  children: [MarginTitle(), Flexible(fit: FlexFit.loose, child: BibleReferenceNavigatorWrapper())]
                ),
                trailing: SettingsButton(),
              );
            }
          },
        ); // Rebuilds whenever the pageController changes
      },
    ));
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
        return RefSelector(ref: value);/*BibleReferenceNavigator(reference: value);*/
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
        color: Theme.of(context).colorScheme.onPrimary
      ),
      onPressed: () {
        print("Settings Button Pressed");
      },
    );
  }
}

class MarginFolderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Icon(
        CupertinoIcons.folder_circle,
        color: Theme.of(context).colorScheme.onPrimary,
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
        CupertinoIcons.textformat,
        color: Theme.of(context).colorScheme.onPrimary,
      ), 
      onPressed: () {
        print("BibleAaButton pressed");
      },
    );
  }
}