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
  late BibleReference _newReference;

  int selectedBookInt = 1;
  bool showPrevRef = true;

  bool showingTextEntry = false;
  FocusNode _textEntryFocusNode = FocusNode();

  var _textEntryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _reference = widget._currentReference;
    _newReference = BibleReference(_reference.bookNum, _reference.chapter, _reference.verseNum);
    _textEntryFocusNode.addListener(() {
      if (showingTextEntry) {
        _textEntryFocusNode.requestFocus();
      } else {
        _textEntryFocusNode.unfocus();
      }
    });
  }

  @override
  void didUpdateWidget(covariant RefSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._currentReference != oldWidget._currentReference) {
      setState(() {
        _reference = widget._currentReference;
        _newReference = BibleReference(_reference.bookNum, _reference.chapter, _reference.verseNum);
      });
    }
  }
  
  void _showDialog(Widget child) {
    showPrevRef = false;

    // /*DEBUG*/print('Unfocusing');
    // _textEntryFocusNode.unfocus();
    // showingTextEntry = false;

    showCupertinoModalPopup<void>(
      context: context,
      barrierColor: Colors.transparent,
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
      /*DEBUG*/print('Modal Dismissed');
      if (selectedBookInt != widget._currentReference.bookNum) {
        _bookWasChosen();
      } else {
        /*DEBUG*/print('Book unchanged: selectedBookInt=${getBookName(selectedBookInt)} == _currentReference=${getBookName(widget._currentReference.bookNum)}');
      }
    });
  }

  void _bookWasChosen() {
    // Add a space to the text
    _textEntryController.text = _textEntryController.text + ' ';
    // Move cursor to end of text
    _textEntryController.selection = TextSelection.fromPosition(TextPosition(offset: _textEntryController.text.length));
    /*DEBUG*/print('Book was chosen');
  }

  void _refWasChosen() {
    // Handle refrence choice
    /*DEBUG*/print('Handling refrence with NewRef= ${_newReference}');
    setState(() {
      Provider.of<MyAppState>(context, listen: false).setReference(BibleReference(_newReference.bookNum, _newReference.chapter, 0));
    });

    // Clear text field
    _textEntryController.clear();
    setState(() {
      showingTextEntry = false;
      _textEntryController.clear();
      _textEntryFocusNode.unfocus();
      showPrevRef = true;
    });
    /*DEBUG*/print('Ref was chosen');
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
      (showingTextEntry) ? 
      OutlineBox(child:
        Container(child: CupertinoTextField(
          controller: _textEntryController,
          focusNode: _textEntryFocusNode,
          onChanged: (String value) {
            setState(() {
              if (value != '')
                showPrevRef = false;
              else
                showPrevRef = true;
            });
          },
          onSubmitted: (String value) {
            int? selectedBookNum = getBookNum(value);
            if (selectedBookNum != null) {
              setState(() {
                selectedBookInt = selectedBookNum;
                _newReference.bookNum = selectedBookInt;
                // DEBUG OLD: Provider.of<MyAppState>(context, listen: false).setReference(BibleReference(selectedBookInt, 1, 0));
                showPrevRef = true;
                /*DEBUG*/print('NewRef Book updated via text entry to: '+getBookName(selectedBookInt));
                /*DEBUG*/print('NewRef is: ${_newReference}');
                _refWasChosen();
              });
            } else {
              /*DEBUG*/print('No book found for: '+value);
            }
            /*DEBUG*/print('Submitted text: $value');
            // Clear scrollable if needed
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          cursorColor: CupertinoTheme.of(context).primaryContrastingColor,
          maxLines: 1,
          // placeholder: '',
        ))
      )
      :
      Container(height: 1,/*Empty*/)
      ,

      (showPrevRef) ? Row(mainAxisAlignment: (showingTextEntry) ? MainAxisAlignment.start : MainAxisAlignment.center, children: [
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
                      /*DEBUG*/print('Check1: selectedBookInt=${getBookName(selectedBookInt)} == _currentReference=${getBookName(widget._currentReference.bookNum)}');
                      setState(() {
                        /*DEBUG*/print('Check2: selectedBookInt=${getBookName(selectedBookInt)} == _currentReference=${getBookName(widget._currentReference.bookNum)}');
                        selectedBookInt = index+1;
                        /*DEBUG*/print('Check3: selectedBookInt=${getBookName(selectedBookInt)} == _currentReference=${getBookName(widget._currentReference.bookNum)}');
                        _newReference.bookNum = selectedBookInt;
                        /*DEBUG*/print('Check4: selectedBookInt=${getBookName(selectedBookInt)} == _currentReference=${getBookName(widget._currentReference.bookNum)}');
                        // _textEntryFocusNode.unfocus();
                        _textEntryController.text = getBookName(selectedBookInt);
                        /*DEBUG*/print("NewRef Book selected: "+(selectedBookInt).toString());
                        /*DEBUG*/print('NewRef is: ${_newReference}');
                        /*DEBUG*/print('Check5: selectedBookInt=${getBookName(selectedBookInt)} == _currentReference=${getBookName(widget._currentReference.bookNum)}');
                      });
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
      Container(height: 1,/*Empty*/),
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