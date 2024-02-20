import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';
import 'package:berean_bible_app/pages/BibleReaderPage.dart';
import 'package:berean_bible_app/pages/MarginEditorPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Berean Bible App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.lightBlue),
        ),
        home: MyHomePage(title: 'Berean Bible Home Page'),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  late PageController pageController = PageController(initialPage: 0);

  void changePage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    /*DEBUG*/print("Snapped to new pag via _changePage()");
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MyAppState appState;

  @override
  void initState() {
    super.initState();
    appState = Provider.of<MyAppState>(context, listen: false);
    appState.pageController.addListener(_handlePageChange);
  }

  @override
  void dispose() {
    appState.pageController.dispose();
    super.dispose();
  }

  void _handlePageChange() {
    setState(() {});
    /*DEBUG*/print(appState.pageController.page!.round());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType != DeviceScreenType.desktop) {
            // Main Mobile View
            return PageView(
              controller: appState.pageController,
              physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
              children: [
                MarginEditorPage(),
                BibleReaderPage(),
              ],
            );
          } else {
            // Desktop View
            return Row(
              children: [
                Expanded(child: MarginEditorPage()),
                Expanded(child: BibleReaderPage()),
              ],
            );
          }
        },
      ),
    );
  }
}