import 'package:berean_bible_app/classes/BibleReference.dart';
import 'package:flutter/cupertino.dart';
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
    return Container(
      color: CupertinoTheme.of(context).barBackgroundColor,
      child: Row(children: [
        CupertinoButton(
          child: Icon(
            CupertinoIcons.arrowshape_turn_up_left_circle_fill,
            color: CupertinoTheme.of(context).primaryContrastingColor,
          ),
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
        CupertinoButton(
          child: Icon(
            CupertinoIcons.arrowshape_turn_up_right_circle_fill,
            color: CupertinoTheme.of(context).primaryContrastingColor,
          ),
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
        )
      ])
    );
  }
}