import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // For the text buttons
import 'package:berean_bible_app/classes/BibleReference.dart';
import 'package:berean_bible_app/functions/bibleUtilFunctions.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:berean_bible_app/main.dart';
/*DEBUG*/import 'package:berean_bible_app/widgets/OutlineBox.dart';

class RefSelector extends StatefulWidget {
  const RefSelector({
    super.key,
    required BibleReference ref,
    TextStyle? formatStyle,
  }) : _currentReference = ref, txtFormatStyle = formatStyle;

  final BibleReference _currentReference;
  final TextStyle? txtFormatStyle;
  
  @override
  _RefSelectorState createState() => _RefSelectorState();
}

class _RefSelectorState extends State<RefSelector> {
  late BibleReference _reference;

  @override
  void initState() {
    super.initState();
    _reference = widget._currentReference;
  }

  @override
  void didUpdateWidget(covariant RefSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._currentReference != oldWidget._currentReference) {
      setState(() {
        _reference = widget._currentReference;
      });
    }
  }
  
  int selectedBookInt = 1;
  bool showPastRef = true;
  bool showingTextEntry = false;
  FocusNode _textEntryFocusNode = FocusNode();

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
    ).then((value) {
      // Handle book choice
      _bookWasChosen();
    });
  }

  void _bookWasChosen() {
    // Handle book choice
    setState(() {
      showingTextEntry = false;
    });
    /*DEBUG*/print('Book was chosen');
  }

  void activateTextEntry() {
    setState(() {
      showingTextEntry = true;
      _textEntryFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[

      // Text Entry:
      (showingTextEntry) ? Container(child: CupertinoSearchTextField(
        focusNode: _textEntryFocusNode,
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
              _bookWasChosen();
            });
          } else {
            /*DEBUG*/print('No book found for: '+value);
          }
          /*DEBUG*/print('Submitted text: $value');
        },
      ))
      : 
      Container(/*Empty*/),

      (showPastRef) ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Book title
        Stack(children: <Widget>[
          TextButton(
            child: RefBookTitleTxt(ref: _reference, formatStyle: widget.txtFormatStyle),
            onPressed: () {
              /*DEBUG*/print("Bible Book Pressed");
              
              if (showingTextEntry) {
                // Display Book Picker
                _showDialog(
                  // Book Picker:
                  CupertinoPicker(
                    magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: true,
                    itemExtent: 32.0,
                    scrollController: FixedExtentScrollController(
                      initialItem: selectedBookInt-1,
                    ),
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        selectedBookInt = index+1;
                        Provider.of<MyAppState>(context, listen: false).setReference(BibleReference(selectedBookInt, 1, 0));
                      });
                      /*DEBUG*/print("Book selected: "+(selectedBookInt).toString());
                    },
                    children: getAllBookNames().map((item) => Text(item)).toList(),
                  )
                );
              } else {
                activateTextEntry();
              }
            },
          )
        ]),

        Text(" ", style: widget.txtFormatStyle ?? TextStyle(color: CupertinoTheme.of(context).primaryContrastingColor)),
        RefChapterNumTxt(ref: _reference, formatStyle: widget.txtFormatStyle),
      
      ])
      :
      Container(/*Empty*/),
    ]);
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