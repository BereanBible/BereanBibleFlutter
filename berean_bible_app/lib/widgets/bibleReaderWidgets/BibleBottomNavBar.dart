import 'package:berean_bible_app/classes/BibleReference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:berean_bible_app/main.dart';
import 'package:berean_bible_app/functions/bibleUtilFunctions.dart';

class BibleBottomNavBar extends StatefulWidget {
  @override
  State<BibleBottomNavBar> createState() => _BibleBottomNavBarState();
}

class _BibleBottomNavBarState extends State<BibleBottomNavBar> {
  var reference = "";

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        tooltip: 'Back a chapter',
        onPressed: () {
          
          var ref = Provider.of<MyAppState>(context, listen: false).readerReference;
          BibleReference newRef = BibleReference(ref.bookNum, ref.chapter, 0);
          
          if (ref.chapter > 1) {
            newRef.chapter--;
          } else if (ref.bookNum > 1) {
            newRef.bookNum--;
            newRef.chapter = getNumChapters((ref.bookNum)-1);
          }

          Provider.of<MyAppState>(context, listen: false).setReference(newRef);
          
          /*DEBUG*/print("Back a chapter pressed");
          /*DEBUG*/print("Ref="+ref.toString());        
        },
      ),
      Spacer(),
      IconButton(
        icon: const Icon(Icons.arrow_forward_ios),
        tooltip: 'Forward a chapter',
        onPressed: () {
          
          var ref = Provider.of<MyAppState>(context, listen: false).readerReference;
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
          
          /*DEBUG*/print("Forward a chapter pressed");
          /*DEBUG*/print("Ref="+ref.toString());
        },
      ),
    ]);
    // return BottomNavigationBar(
    //   type: BottomNavigationBarType.fixed,
    //   items: [
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home),
    //       label: 'Home',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.book),
    //       label: 'Bible Reader',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.explore),
    //       label: 'Explore Page',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.settings),
    //       label: 'Settings',
    //     ),
    //   ],
    //   currentIndex: 1,
    //   selectedItemColor: Colors.blue,
    //   unselectedItemColor: Colors.grey,
    //   showUnselectedLabels: true,
    //   onTap: (value) {
    //     setState(() {
    //       // selectedIndex = value;
    //     });
    //   },
    // );
  }
}