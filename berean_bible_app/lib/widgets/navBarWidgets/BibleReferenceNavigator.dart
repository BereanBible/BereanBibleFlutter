import 'package:berean_bible_app/classes/BibleReference.dart';
import 'package:berean_bible_app/functions/bibleUtilFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:berean_bible_app/widgets/OutlineBox.dart';
// import 'package:berean_bible_app/widgets/navBarWidgets/CustomSearchTextField.dart';
import 'package:flutter/widgets.dart';
import 'package:berean_bible_app/widgets/navBarWidgets/RefSelector.dart';

class BibleReferenceNavigator extends StatefulWidget {
  final BibleReference reference;

  BibleReferenceNavigator({required this.reference});

  @override
  _BibleReferenceNavigatorState createState() => _BibleReferenceNavigatorState();
}

class _BibleReferenceNavigatorState extends State<BibleReferenceNavigator> {
  bool _selecting = false;
  late BibleReference _reference;
  String text = "t";

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
    return GestureDetector(
      onTap: () {
        setState(() {
          _selecting = true;
        });
      },
      child: _selecting ? 
        OutlineBox(child: 
          RefSelector(ref: _reference, /*DEBUG*/formatStyle: TextStyle(color: CupertinoColors.systemPurple))
        )
        :
        TextButton(
          child: RefText(ref: _reference, /*DEBUG*/formatStyle: TextStyle(color: CupertinoColors.destructiveRed)),
          onPressed: () {
            print("BibleRefPressed");
            setState(() {
              _selecting = true;
            });
          },
        ),
    );

    // if (_selecting) {
    //   return Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
    //     Expanded(child: OutlineBox(child: 
    //       RefSelector(ref: _reference, /*DEBUG*/formatStyle: TextStyle(color: CupertinoColors.systemPurple))
    //     )),
    //     // // Expanded(child: OutlineBox(child: CupertinoSearchTextField(
    //     // //   placeholder: Row(
    //     // //     children: [
    //     // //       TextButton( // Book button
    //     // //         onPressed: () {
    //     // //           print("Book pressed");
    //     // //           setState(() {
    //     // //             selecting = true;
    //     // //           });
    //     // //         },
    //     // //         style: TextButton.styleFrom(
    //     // //           minimumSize: Size.zero,
    //     // //           padding: EdgeInsets.zero,
    //     // //         ),
    //     // //         child: RefBookTitleTxt(ref: _reference, /*DEBUG*/formatStyle: TextStyle(color: CupertinoColors.activeBlue)),
    //     // //       )
    //     // //     ]
    //     // //   ),
    //     // //   onChanged: (query) {
    //     // //     // Handle search query changes
    //     // //     print('Search query: $query');
    //     // //   },
    //     // //   onSubmitted: (query) {
    //     // //     // Handle search submission
    //     // //     print('Submitted query: $query');
    //     // //   },
    //     // // )
    //     // // )),
        
    //     // Expanded(child: OutlineBox(child: CustomSearchTextField(
    //     //   // fieldValue: (String value) {
    //     //   //   setState(() {
    //     //   //     text = value;
    //     //   //   });
    //     //   // },
    //     //   placeholder: Row(
    //     //     children: [
    //     //       TextButton( // Book button
    //     //         onPressed: () {
    //     //           print("Book pressed");
    //     //           setState(() {
    //     //             selecting = true;
    //     //           });
    //     //         },
    //     //         style: TextButton.styleFrom(
    //     //           minimumSize: Size.zero,
    //     //           padding: EdgeInsets.zero,
    //     //         ),
    //     //         child: RefBookTitleTxt(ref: _reference, /*DEBUG*/formatStyle: TextStyle(color: CupertinoColors.activeBlue)),
    //     //       )
    //     //     ]
    //     //   )
    //     // ))),
    //     // TextButton( // Book button
    //     //   onPressed: () {
    //     //     print("Book pressed");
    //     //     setState(() {
    //     //       selecting = true;
    //     //     });
    //     //   },
    //     //   style: TextButton.styleFrom(
    //     //     minimumSize: Size.zero,
    //     //     padding: EdgeInsets.zero,
    //     //   ),
    //     //   child: RefBookTitleTxt(ref: _reference, /*DEBUG*/formatStyle: TextStyle(color: CupertinoColors.activeBlue)),
    //     // ),
    //     // Text(" "),
    //     // TextButton( // Chapter button
    //     //   onPressed: () {
    //     //     print("Chapter pressed");
    //     //     setState(() {
    //     //       selecting = true;
    //     //     });
    //     //   },
    //     //   style: TextButton.styleFrom(
    //     //     minimumSize: Size.zero,
    //     //     padding: EdgeInsets.zero,
    //     //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //     //   ),
    //     //   child: RefChapterNumTxt(ref: _reference, /*DEBUG*/formatStyle: TextStyle(color: CupertinoColors.activeBlue))
    //     // ),
    //   ]);
    // } else {
    //   return TextButton(
    //     child: RefText(ref: _reference, /*DEBUG*/formatStyle: TextStyle(color: CupertinoColors.destructiveRed)),
    //     onPressed: () {
    //       print("BibleRefPressed");
    //       setState(() {
    //         _selecting = true;
    //       });
    //     },
    //   );
    // }
  }
}




// Text displays
class RefText extends StatelessWidget {
  const RefText({
    super.key,
    required BibleReference ref,
    TextStyle? formatStyle,
  }) : _reference = ref, txtFormatStyle = formatStyle;

  final BibleReference _reference;
  final TextStyle? txtFormatStyle;

  @override
  Widget build(BuildContext context) {
    return
    
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      RefBookTitleTxt(ref: _reference, formatStyle: (txtFormatStyle != null) ? txtFormatStyle : null),
      Text(" ", style: (txtFormatStyle != null) ? txtFormatStyle : TextStyle(color: CupertinoTheme.of(context).primaryContrastingColor)),
      RefChapterNumTxt(ref: _reference, formatStyle: (txtFormatStyle != null) ? txtFormatStyle : null),
    ]);
  }
}



class RefBookTitleTxt extends StatelessWidget {
  const RefBookTitleTxt({
    super.key,
    required BibleReference ref,
    TextStyle? formatStyle,
  }) : _reference = ref, txtFormatStyle = formatStyle;

  final BibleReference _reference;
  final TextStyle? txtFormatStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      getBookName(_reference.bookNum),
      style: (
        (txtFormatStyle != null) ? txtFormatStyle : 
        TextStyle(color: CupertinoTheme.of(context).primaryContrastingColor)
      ),
    );
  }
}

class RefChapterNumTxt extends StatelessWidget {
  const RefChapterNumTxt({
    super.key,
    required BibleReference ref,
    TextStyle? formatStyle,
  }) : _reference = ref, txtFormatStyle = formatStyle;

  final BibleReference _reference;
  final TextStyle? txtFormatStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      _reference.chapter.toString(),
      style: (
        (txtFormatStyle != null) ? txtFormatStyle : 
        TextStyle(color: CupertinoTheme.of(context).primaryContrastingColor)
      ),
    );
  }
}