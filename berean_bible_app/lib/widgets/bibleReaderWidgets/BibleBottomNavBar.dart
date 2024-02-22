import 'package:berean_bible_app/classes/BibleReference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:berean_bible_app/main.dart';
import 'package:berean_bible_app/functions/bibleUtilFunctions.dart';

class BibleBottomNavBar extends StatefulWidget {
  final BibleReference reference;

  BibleBottomNavBar({required this.reference});

  @override
  State<BibleBottomNavBar> createState() => _BibleBottomNavBarState();
}

class _BibleBottomNavBarState extends State<BibleBottomNavBar> {
  late BibleReference _reference;

  @override
  void initState() {
    super.initState();
    _reference = widget.reference;
  }

  @override
  void didUpdateWidget(covariant BibleBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.reference != oldWidget.reference) {
      setState(() {
        _reference = widget.reference;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        tooltip: 'Back a chapter',
        onPressed: () {
          var ref = _reference;
          BibleReference newRef = BibleReference(ref.bookNum, ref.chapter, 0);
          if (ref.chapter > 1) {
            newRef.chapter--;
          } else if (ref.bookNum > 1) {
            newRef.bookNum--;
            newRef.chapter = getNumChapters((ref.bookNum)-1);
          }
          Provider.of<MyAppState>(context, listen: false).setReference(newRef);     
        },
      ),
      Spacer(),
      IconButton(
        icon: const Icon(Icons.arrow_forward_ios),
        tooltip: 'Forward a chapter',
        onPressed: () {
          var ref = _reference;
          BibleReference newRef = BibleReference(ref.bookNum, ref.chapter, 0);
          if (ref.chapter + 1 <= getNumChapters(ref.bookNum)) {
            // if book has another chapter
            newRef.chapter++;
          } else if (ref.bookNum < 66) {
            // if there is a next book
            newRef.bookNum++;
            newRef.chapter = 1;
          }
          Provider.of<MyAppState>(context, listen: false).setReference(newRef);
        },
      ),
    ]);
  }
}