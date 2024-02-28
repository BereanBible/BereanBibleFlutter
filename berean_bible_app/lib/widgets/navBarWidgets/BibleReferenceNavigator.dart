import 'package:berean_bible_app/classes/BibleReference.dart';
import 'package:berean_bible_app/functions/bibleUtilFunctions.dart';
import 'package:flutter/cupertino.dart';

class BibleReferenceNavigator extends StatefulWidget {
  final BibleReference reference;

  BibleReferenceNavigator({required this.reference});

  @override
  _BibleReferenceNavigatorState createState() => _BibleReferenceNavigatorState();
}

class _BibleReferenceNavigatorState extends State<BibleReferenceNavigator> {
  late BibleReference _reference;

  @override
  void initState() {
    super.initState();
    _reference = widget.reference;
  }

  @override
  void didUpdateWidget(covariant BibleReferenceNavigator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.reference != oldWidget.reference) {
      setState(() {
        _reference = widget.reference;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(getBookName(_reference.bookNum) + " " + _reference.chapter.toString());
  }
}