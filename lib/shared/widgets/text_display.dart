import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextDisplay extends StatelessWidget {
  final Color color;
  final double fontSize;
  final String? text;
  final FontWeight fontWeight;
  final TextStyle? style;
  final TextAlign textAlign;
  final bool isUpper;
  final bool softWrap;
  final int maxLines;
  final TextOverflow overflow;
  final TextDecoration? decoration;

  const AppTextDisplay({
    Key? key,
    this.color = Colors.white,
    this.fontSize = 15.0,
    this.text,
    this.decoration,
    this.overflow = TextOverflow.ellipsis,
    this.style,
    this.softWrap = false,
    this.maxLines = 2,
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.normal,
    this.isUpper = false,
  }) : super(key: key);

  static double getFontSize(double size) {
    double newSize = size;
    if (newSize <= 12) {
      newSize = 12;
    }
    return newSize;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? _style = style != null? style : GoogleFonts.poppins(
        decoration: decoration,
        color: color,
        fontSize: getFontSize(fontSize),
        fontWeight: fontWeight);

    _style = _style!.copyWith(fontSize: getFontSize(_style.fontSize!));


    return Text(text!,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: _style,
    );
  }
}