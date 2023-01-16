// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:i_like_a_math/domain/entities/solution_entity.dart';
import '../../../locator_service.dart';

class Solution extends StatefulWidget {
  final bool hasSolution;
  final List<ExpressionElem> solutionElems;
  final Size parentSize;
  const Solution({Key? key, required this.hasSolution, required this.solutionElems, required this.parentSize}) : super(key: key);

  @override
  State<Solution> createState() => _SolutionState();
}

class _SolutionState extends State<Solution> with SingleTickerProviderStateMixin {
  static const fontSizeNorm = 95.0;
  static const fontSizeLevel1 = 0.6 * fontSizeNorm;
  static const fontSizeLevel2 = 0.4 * fontSizeNorm;
  static const paddingLevel1 = 0.5 * fontSizeNorm;
  static const paddingLevel2 = 0.7 * fontSizeNorm;
  late final TextStyle textStyleNorm, textStyleLevel1, textStyleLevel2;
  late final EdgeInsets textPaddingLevel1, textPaddingLevel2;
  late final AnimationController _controller;
  late final Animation<double> curve = CurvedAnimation(parent: _controller, curve: Curves.linear);
  late final Animation<int> animTextWrite;

  @override
  void initState() {
    final fontScale = _calcFullTextFontScale(widget.solutionElems, widget.parentSize);

    textStyleNorm = TextStyle(fontFamily: 'Rabiohead', fontSize: fontScale * fontSizeNorm, color: widget.hasSolution ? Colors.indigo : Colors.pink,);
    textStyleLevel1 = textStyleNorm.copyWith(fontSize: fontScale * fontSizeLevel1);
    textStyleLevel2 = textStyleNorm.copyWith(fontSize: fontScale * fontSizeLevel2);

    textPaddingLevel1 = EdgeInsets.only(bottom: paddingLevel1 * fontScale);
    textPaddingLevel2 = EdgeInsets.only(bottom: paddingLevel2 * fontScale);

    final int fullTextLen = _calcFullTextLen(widget.solutionElems);

    _controller = AnimationController(duration: Duration(milliseconds: fullTextLen*25 ), vsync: this);

    animTextWrite = IntTween(begin: 1, end: fullTextLen).animate(_controller)
    ..addListener(() {
      setState(() {});
    })
    ..addStatusListener((AnimationStatus status) {
      if      (status == AnimationStatus.forward)   playAudio();
      else if (status == AnimationStatus.completed) stopAudio();
    });
    _controller.forward();
    super.initState();
  }

  void playAudio() async {
    sl<AudioPlayer>().play(AssetSource('sfx/snap_wavX.mp3'));
    // audioPlayer.resume();
  }
  void stopAudio() async {
    sl<AudioPlayer>().stop();
  }
  void releaseAudio() async {
    sl<AudioPlayer>().release();
  }

  @override
  void dispose() {
     _controller.dispose();
     stopAudio();
     releaseAudio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<ExpressionElem>solutionElems = _getSubElems(widget.solutionElems, animTextWrite.value);
    final List<Widget>listWidgets = [];

    for(int i = 0; i < solutionElems.length; i ++) {
      ExpressionElem elem = solutionElems[i];
      final expression = elem.expression;
      switch(elem.level) {
        case 2:   listWidgets.add(
                      Padding(padding: textPaddingLevel1,
                          child: Text(expression, style: textStyleLevel1,))
                  );
                  break;
        case 3:   listWidgets.add(
                      Padding(padding: textPaddingLevel2,
                          child: Text(expression, style: textStyleLevel2,))
                  );
                  break;
        default:  listWidgets.add(Text(expression, style: textStyleNorm,));
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: listWidgets,
    );
  }

  int _calcFullTextLen(List<ExpressionElem> solutionElems) {
    int totalLen = 0;
    for(int i = 0; i < solutionElems.length; i ++) {
      ExpressionElem elem = solutionElems[i];
      totalLen += elem.expression.length;
    }
    return totalLen;
  }

  double _calcFullTextFontScale(List<ExpressionElem> solutionElems, Size parentSize) {
    double totalW = 0;
    double textH = 0;
    for(int i = 0; i < solutionElems.length; i ++) {
      ExpressionElem elem = solutionElems[i];
      final expression = elem.expression;
      final double fontSize;
      switch(elem.level) {
        case 2:   fontSize = fontSizeLevel1;  break;
        case 3:   fontSize = fontSizeLevel2;  break;
        default:  fontSize = fontSizeNorm;    break;
      }
      Size textSize = _calcTextSize(expression, fontSize);
      totalW += textSize.width;
      textH = textSize.height;
    }
    return min((0.9*parentSize.width) / totalW, (0.4*parentSize.height) / textH);
  }

  Size _calcTextSize(String text, double fontSize) {
    final TextPainter textPainter = TextPainter(
      maxLines: 1,
      text: TextSpan(text: text, style: TextStyle(fontFamily: 'Rabiohead', fontSize: fontSize)),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size;
  }

  List<ExpressionElem> _getSubElems(List<ExpressionElem> elems, int tgtLen) {
    var curLen = 0;
    final List<ExpressionElem> newElems = [];
    for(int i = 0; i < elems.length; i ++) {
      final oneElem = elems[i];
      final elemLen = oneElem.expression.length;
      if(curLen + elemLen < tgtLen) {
        newElems.add(oneElem);
      } else {
        final tailLen = tgtLen - curLen;
        String newEpression = oneElem.expression.substring(0, tailLen);
        ExpressionElem newElem = ExpressionElem(oneElem.level, newEpression);
        newElems.add(newElem);
        break;
      }
      curLen += elemLen;
    }
    return newElems;
  }
}
