import 'package:flutter/cupertino.dart';

class OutlineBox extends StatelessWidget {
  const OutlineBox({
    super.key,
    required Widget child,
    Color? c,
  }) : widg = child, outlineColor = c ?? CupertinoColors.systemYellow;

  final Widget widg;
  final Color outlineColor;

  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.all(0), padding: const EdgeInsets.all(0), decoration: BoxDecoration(border: Border.all(color: outlineColor)), 
      child: widg
    );
  }
}