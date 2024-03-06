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

  bool userIsTyping = false;
  FocusNode _textEntryFocusNode = FocusNode();

  var _textEntryController = TextEditingController();
  final GlobalKey _textFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _reference = widget._currentReference;
    _newReference = BibleReference(_reference.bookNum, _reference.chapter, _reference.verseNum);
  }

  @override
  void didUpdateWidget(covariant RefSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._currentReference != oldWidget._currentReference) {
      setState(() {
        _reference = widget._currentReference;
        _newReference = BibleReference(_reference.bookNum, _reference.chapter, 0);
      });
    }
  }

  void _setNewBook(int bkNum) {
    setState(() {
      selectedBookInt = bkNum;
      _newReference.bookNum = selectedBookInt;
    });
  }

  void _setNewChapter(int ch) {
    setState(() {
      selectedChapter = ch;
      _newReference.chapter = selectedChapter;
    });
  }

  void _setNewVerse(int v) { // DEBUG Omit?
    setState(() {
      // selectedVerse = v; // DEBUG no selectedVerse implemented
      _newReference.verseNum = v;
    });
  }

  void _activateTextEntry() {
    setState(() {
      userIsTyping = true;
      _textEntryFocusNode.requestFocus();
      _textEntryController.selection = TextSelection.fromPosition(TextPosition(offset: 0));
    });
  }

  void _deactivateTextEntry() {
    setState(() {
      userIsTyping = false;
      _textEntryController.clear();
      // _textEntryController.text = _newReference.toString() + "[%]";
      _textEntryFocusNode.unfocus();
    });
  }
  
  void _showDialog(Widget child) {
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
      if (selectedChapter != widget._currentReference.chapter) {
        _textEntryController.selection = TextSelection.fromPosition(TextPosition(offset: _textEntryController.text.length));
      }
    });
  }

  void _refWasChosen() {
    // Handle refrence choice
    setState(() {
      Provider.of<MyAppState>(context, listen: false).setReference(BibleReference(_newReference.bookNum, _newReference.chapter, _newReference.verseNum));
    });
    _deactivateTextEntry(); // Clear text field
  }

  int _calculateOffset(Offset localPosition) {
    RenderBox? box = _textFieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      double caretPositionFromLeft = localPosition.dx;

      TextSpan span = new TextSpan(style: new TextStyle(color: Colors.black), text: _textEntryController.text);
      TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
      tp.layout(maxWidth: box.size.width);

      int offset = tp.getPositionForOffset(new Offset(caretPositionFromLeft, 0)).offset;

      return offset;
    }
    return 0;
  }

  int _getTappedRefSection(String text, int offset) {
    // List<String> words = text.split(' ');
    int lastSpace = text.lastIndexOf(' ');
    String enteredBookStr = text.substring(0, lastSpace + 1);
    String chAndVerseString = text.substring(lastSpace + 1);
    List<String> words = [enteredBookStr, chAndVerseString];

    int sectionIndex = 0;
    int runningOffset = 0;

    for (String word in words) {
      runningOffset += word.length;
      if (offset <= runningOffset + 0/*addition here to ensure that taps at the end of the book register as the book*/) {
        break;
      }
      sectionIndex++;
      runningOffset++; // For the space
    }

    return sectionIndex;
  }

  String _procBookNames(String b, bool convertToSafe) {
    if (convertToSafe) {
      // Convert to space-safe book name
      return b.replaceAll('1st ', '1')
        .replaceAll('2nd ', '2')
        .replaceAll('3rd ', '3')
        .replaceAll('1 ', '1')
        .replaceAll('2 ', '2')
        .replaceAll('3 ', '3');
    } else {
      // Convert to proper book name
      return b.replaceAll('1', '1 ')
        .replaceAll('2', '2 ')
        .replaceAll('3', '3 ');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[

      Container(child: 
        (userIsTyping) ?
        // Text Entry:
        Container(
          margin: const EdgeInsets.all(0), 
          padding: const EdgeInsets.all(0), 
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: CupertinoTheme.of(context).scaffoldBackgroundColor), 
            borderRadius: BorderRadius.circular(10)), 
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Listener(child: 
                (userIsTyping) ? CupertinoTextField(
                key: _textFieldKey,
                controller: _textEntryController,
                focusNode: _textEntryFocusNode,
                placeholder: (_reference.toString()),
                cursorColor: CupertinoTheme.of(context).primaryContrastingColor,
                maxLines: 1,
                onSubmitted: (String value) {
                  // Proccessing input
                  String spaceSafeInput = _procBookNames(value, true);
                  int lastSpace = spaceSafeInput.lastIndexOf(' ');
                  String enteredBookStr;
                  String chAndVerseString;
                  if (lastSpace == -1 || lastSpace == spaceSafeInput.length - 1) {
                    // "Book" or "Book "
                    enteredBookStr = _procBookNames(spaceSafeInput.replaceAll(' ', ''), false);
                    chAndVerseString = "";
                  } else {
                    // "Book Ch..."
                    enteredBookStr = _procBookNames(spaceSafeInput.substring(0, lastSpace), false);
                    chAndVerseString = spaceSafeInput.substring(lastSpace + 1);
                  }

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
                        _setNewBook(enteredBookNum);
                      }
                      if (enteredChapter != null) {
                        _setNewChapter(enteredChapter);
                      } else {
                        _setNewChapter(1);
                      }
                      if (enteredVerse != null) { // DEBUG Omit?
                        _setNewVerse(enteredVerse);
                      }
                      _refWasChosen();
                    });
                  } else {
                    /*DEBUG*/print('Invalid refrence: $value');
                  }

                  // Clear scrollable if needed
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
              )
              :
              Container(child: RefText(ref: _reference, formatStyle: TextStyle(color: CupertinoColors.activeOrange)))
              ,
              onPointerDown: (PointerDownEvent details) {
                if (userIsTyping) {
                  // Handle Tap
                  RenderBox? box = _textFieldKey.currentContext?.findRenderObject() as RenderBox?;
                  if (box != null) {
                    Offset localPosition = box.globalToLocal(details.position);

                    int offset = _calculateOffset(localPosition);

                    int tappedSection = _getTappedRefSection(_textEntryController.text, offset);
                    if(tappedSection == 0) {
                      // Display Book Picker
                      _showDialog(
                        // Book Picker:
                        ScrollPicker(
                          onChange: (int index) {
                            setState(() {
                              _setNewBook(index+1);
                              _setNewChapter(1); // Reset the chapter to 1 when changing books;
                              _setNewVerse(0);
                              _textEntryController.text = getBookName(selectedBookInt) + ' ';
                              // Move cursor to end of text:
                              _textEntryController.selection = TextSelection.fromPosition(TextPosition(offset: _textEntryController.text.length));
                            });
                          },
                          items: getAllBookNames().map((item) => Text(item)).toList(),
                          initIndex: selectedBookInt-1,
                        )
                      );
                    } else if (tappedSection == 1) {
                      // Display Book Picker
                      _showDialog(
                        // Book Picker:
                        ScrollPicker(
                          onChange: (int index) {
                            setState(() {
                              int ch = index+1;
                              _setNewChapter(ch);
                              _textEntryController.text = getBookName(selectedBookInt) + ' ' + selectedChapter.toString();
                              // Move cursor to end of text:
                              _textEntryController.selection = TextSelection.fromPosition(TextPosition(offset: _textEntryController.text.length));
                            });
                          },
                          items: List<Text>.generate(getNumChapters(selectedBookInt), (index) => Text((index + 1).toString())),
                          initIndex: selectedChapter-1,
                        )
                      );
                    } else {
                      print('Yikes! Weird Refrence: tappedSection was ${tappedSection}');
                    }

                    _textEntryController.selection = TextSelection.collapsed(offset: offset);
                  }
                } else {
                  // Activate cursor and summon keyboard
                  _activateTextEntry();
                }
              },
            )
          )
        )
        :
        // Refrence Display
        Listener(
          child: Text(_reference.toString()),
          onPointerDown: (PointerDownEvent details) {
            _activateTextEntry();
          },
        )
      )
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