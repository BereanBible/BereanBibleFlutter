import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // For the text buttons
import 'package:berean_bible_app/classes/BibleReference.dart';
import 'package:berean_bible_app/functions/bibleUtilFunctions.dart';
import 'package:provider/provider.dart';
import 'package:berean_bible_app/main.dart';

class RefSelector extends StatefulWidget {
  const RefSelector({
    super.key,
    required BibleReference ref,
    TextStyle? formatStyle,
    // required this.child,
  }) : _current_reference = ref, txtFormatStyle = formatStyle;

  final BibleReference _current_reference;
  final TextStyle? txtFormatStyle;
  
  @override
  _RefSelectorState createState() => _RefSelectorState();
}

class _RefSelectorState extends State<RefSelector> {
  int selectedBookInt = 0;
  String selectedBookStr = getBookName(1);
  bool showPastRef = true;

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      
      CupertinoSearchTextField(
        onChanged: (String value) {
          setState(() {
            if (value != '')
              showPastRef = false;
            else
              showPastRef = true;
          });
        },
        onSubmitted: (String value) {
          int? bookNum = getBookNum(value);
          if (bookNum != null) {
            setState(() {
              selectedBookInt = bookNum;
              Provider.of<MyAppState>(context, listen: false).setReference(BibleReference(selectedBookInt, 1, 0));
              showPastRef = true;
              /*DEBUG*/print('Ref Book updated via text entry to: '+getBookName(selectedBookInt));
            });
          } else {
            /*DEBUG*/print('No book found for: '+value);
          }
          
          print('Submitted text: $value');
        },
      ),
      
      (showPastRef) ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      
        // Book title
        Stack(children: <Widget>[
          TextButton(
            child: RefBookTitleTxt(ref: widget._current_reference, formatStyle: widget.txtFormatStyle),
            onPressed: () {
              print("Bible Book Pressed");
              _showDialog(
                
                CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedBookInt,
                  ),
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      selectedBookInt = index+1;
                      Provider.of<MyAppState>(context, listen: false).setReference(BibleReference(selectedBookInt, 1, 0));
                    });
                    print("Book selected: "+(selectedBookInt).toString());
                  },
                  children: getAllBookNames().map((item) => Text(item)).toList(),
                )

                /*Example picker*/
                // CupertinoPicker(
                //   magnification: 1.22,
                //   squeeze: 1.2,
                //   useMagnifier: true,
                //   itemExtent: _kItemExtent,
                //   // This sets the initial item.
                //   scrollController: FixedExtentScrollController(
                //     initialItem: _selectedFruit,
                //   ),
                //   // This is called when selected item is changed.
                //   onSelectedItemChanged: (int selectedItem) {
                //     setState(() {
                //       _selectedFruit = selectedItem;
                //     });
                //   },
                //   children:
                //       List<Widget>.generate(_fruitNames.length, (int index) {
                //     return Center(child: Text(_fruitNames[index]));
                //   }),
                // )


              );
            },
          )
        ]),

        Text(" ", style: widget.txtFormatStyle ?? TextStyle(color: CupertinoTheme.of(context).primaryContrastingColor)),
        RefChapterNumTxt(ref: widget._current_reference, formatStyle: widget.txtFormatStyle),
      
      ])
      :
      Text('pie'),
      
      
      
      // Row(
      //   children: [
          // Flexible(child: CupertinoPicker(
          //   itemExtent: 32.0,
          //   onSelectedItemChanged: (int index) {
          //     setState(() {
          //       selectedBookInt = index;
          //     });
          //   },
          //   children: const <Widget>[
          //     Text('Genesis'),
          //     Text('Exodus'),
          //     Text('Leviticus'),
          //     Text('Numbers'),
          //     Text('Deuteronomy'),
          //     // Add the rest of the books here...
          //   ],
          // )),
      //     TextButton( // Book button
      //       onPressed: () {
      //         print("Book pressed");
      //       },
      //       style: TextButton.styleFrom(
      //         minimumSize: Size.zero,
      //         padding: EdgeInsets.zero,
      //       ),
      //       child: RefBookTitleTxt(ref: widget._current_reference, /*DEBUG*/formatStyle: TextStyle(color: CupertinoColors.activeBlue)),
      //     )
      //   ]
      // )
    ])
    ;
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










// class Selector extends StatefulWidget {
//   const Selector({
//     super.key,
//     required BibleReference ref,
//     TextStyle? formatStyle,
//     // required this.child,
//   }) : _current_reference = ref, txtFormatStyle = formatStyle;

//   final BibleReference _current_reference;
//   final TextStyle? txtFormatStyle;

//   // final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: <Widget>[
//       CupertinoSearchTextField(
//         onChanged: (String value) {
//           print('The text has changed to: $value');
//         },
//         onSubmitted: (String value) {
//           print('Submitted text: $value');
//         },
//       ),
//       Row(
//         children: [
//           DropdownButton<String>(
//           value: dropdownValue,
//           onChanged: (String? newValue) {
//             setState(() {
//               dropdownValue = newValue!;
//             });
//           },
//           items: <String>['Genesis', 'Exodus', 'Leviticus', 'Numbers', 'Deuteronomy'].map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//           TextButton( // Book button
//             onPressed: () {
//               print("Book pressed");
//             },
//             style: TextButton.styleFrom(
//               minimumSize: Size.zero,
//               padding: EdgeInsets.zero,
//             ),
//             child: RefBookTitleTxt(ref: _current_reference, /*DEBUG*/formatStyle: TextStyle(color: CupertinoColors.activeBlue)),
//           )
//         ]
//       )
//     ])
    
//     ;
//   }
// }