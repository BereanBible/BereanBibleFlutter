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
  int selectedChapter = 1;
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

  void setNewBook(int bkNum) {
    setState(() {
      selectedBookInt = bkNum;
      _newReference.bookNum = selectedBookInt;
    });
  }

  void setNewChapter(int ch) {
    setState(() {
      selectedChapter = ch;
      _newReference.chapter = selectedChapter;
    });
  }

  void setNewVerse(int v) { // DEBUG Omit?
    setState(() {
      // selectedVerse = v; // DEBUG no selectedVerse implemented
      _newReference.verseNum = v;
    });
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
      // Handle book/chapter choice
      
      /*DEBUG*/print('Modal Dismissed');
      
      if (selectedBookInt != widget._currentReference.bookNum) {
        _bookWasChosen();
      } else {
        /*DEBUG*/print('Book unchanged: selectedBookInt=${getBookName(selectedBookInt)} == _currentReference=${getBookName(widget._currentReference.bookNum)}');
      }
      
      if (selectedChapter != widget._currentReference.chapter) {
        _chapterWasChosen();
      } else {
        /*DEBUG*/print('Chapter unchanged: selectedChapter=${selectedChapter} == _currentReference=${widget._currentReference.chapter}');
      }
    });
  }

  void _bookWasChosen() {
    /*DEBUG*/print('Book was chosen');
  }

  void _chapterWasChosen() {
    // Move cursor to end of text
    _textEntryController.selection = TextSelection.fromPosition(TextPosition(offset: _textEntryController.text.length));
    /*DEBUG*/print('Chapter was chosen');
  }

  void _refWasChosen() {
    // Handle refrence choice
    /*DEBUG*/print('Handling refrence with NewRef= ${_newReference}');
    setState(() {
      Provider.of<MyAppState>(context, listen: false).setReference(BibleReference(_newReference.bookNum, _newReference.chapter, 0));
    });

    // Clear text field
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

            // Proccessing input
            int lastSpace = value.lastIndexOf(' ');
            String enteredBookStr = value.substring(0, lastSpace);
            String chAndVerseString = value.substring(lastSpace + 1);

            int? enteredBookNum = getBookNum(enteredBookStr);            
            int? enteredChapter = null;
            int? enteredVerse = null; // DEBUG: Remove? Unused?

            if (chAndVerseString != '') { // If more than a book name was input
              List<String> chAndVerseParts = chAndVerseString.split(':');
              enteredChapter = int.tryParse(chAndVerseParts[0]);
              if (chAndVerseParts.length > 1) { // If there was a ':' with something after it
                enteredVerse = int.tryParse(chAndVerseParts[1]);
              }
            }

            // Using input to set the new refrence
            if (enteredBookNum != null || enteredChapter != null) {
              setState(() {
                if (enteredBookNum != null) {
                  setNewBook(enteredBookNum);
                }
                if (enteredChapter != null) {
                  setNewChapter(enteredChapter);
                }
                if (enteredVerse != null) { // DEBUG Omit?
                  setNewVerse(enteredVerse);
                }
                showPrevRef = true;
                /*DEBUG*/print('NewRef updated via text entry to: ${_newReference}');
                _refWasChosen();
              });
            } else {
              /*DEBUG*/print('Invalid refrence: $value');
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
                  ScrollPicker(
                    onChange: (int index) {
                      // /*DEBUG*/print('Check1: selectedBookInt=${getBookName(selectedBookInt)} == _currentReference=${getBookName(widget._currentReference.bookNum)}');
                      setState(() {
                        setNewBook(index+1);
                        _textEntryController.text = getBookName(selectedBookInt) + ' ';
                        // Move cursor to end of text
                        _textEntryController.selection = TextSelection.fromPosition(TextPosition(offset: _textEntryController.text.length));
                        /*DEBUG*/print("NewRef Book selected: "+(selectedBookInt).toString());
                        /*DEBUG*/print('NewRef is: ${_newReference}');
                        /*DEBUG*/print('Check5: selectedBookInt=${getBookName(selectedBookInt)} == _currentReference=${getBookName(widget._currentReference.bookNum)}');
                      });
                    },
                    items: getAllBookNames().map((item) => Text(item)).toList(),
                    initIndex: selectedBookInt-1,
                  )
                );
              } else {
                activateTextEntry();
              }
            },
          )
        ]),

        Text(" ", style: widget.txtFormatStyle ?? TextStyle(color: CupertinoTheme.of(context).primaryContrastingColor)),
        
        // Book Chapter
        Stack(children: <Widget>[
          TextButton(
            child: RefChapterNumTxt(ref: _reference, formatStyle: widget.txtFormatStyle),
            onPressed: () {
              /*DEBUG*/print("Bible Chapter Pressed");
              
              if (showingTextEntry) {
                // Display Book Picker
                _showDialog(
                  // Book Picker:
                  ScrollPicker(
                    onChange: (int index) {
                      // /*DEBUG*/print('Check1: selectedBookInt=${getBookName(selectedBookInt)} == _currentReference=${getBookName(widget._currentReference.bookNum)}');
                      setState(() {
                        int ch = index+1;
                        setNewChapter(ch);
                        _textEntryController.text = getBookName(selectedBookInt) + ' ' + ch.toString();
                        // Move cursor to end of text
                        _textEntryController.selection = TextSelection.fromPosition(TextPosition(offset: _textEntryController.text.length));
                        /*DEBUG*/print("NewRef Chapter selected: "+(selectedBookInt).toString());
                        /*DEBUG*/print('NewRef is: ${_newReference}');
                        /*DEBUG*/print('Check5: selectedBookInt=${getBookName(selectedBookInt)} == _currentReference=${getBookName(widget._currentReference.bookNum)}');
                      });
                    },
                    items: List<Text>.generate(getNumChapters(selectedBookInt), (index) => Text((index + 1).toString())),
                    initIndex: selectedBookInt-1,
                  )
                );
              } else {
                activateTextEntry();
              }
            },
          )
        ]),

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

class ScrollPicker extends StatelessWidget {

  const ScrollPicker({
    super.key,
    required this.onChange,
    required this.items,
    int? initIndex,
  }) : initI = initIndex ?? 0;

  final void Function(int) onChange;
  final List<Widget> items;
  final int initI;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      magnification: 1.22,
      squeeze: 1.2,
      useMagnifier: true,
      itemExtent: 32.0,
      scrollController: FixedExtentScrollController(
        initialItem: initI,
      ),
      onSelectedItemChanged: (int index) {
        onChange(index);
      },
      children: items,
    );
  }
}