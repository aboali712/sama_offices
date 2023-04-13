// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

import '../values/colors.dart';

class TextWidget extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final double? textHeight;
  final int? maxLine;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? color;
  final Color? backcolor;

  const TextWidget({
    Key? key,
    this.title,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.color = textColor,
    this.backcolor, this.maxLine,
    this.textHeight = 1.5
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      overflow: TextOverflow.ellipsis,
      maxLines: maxLine ?? 2,
      style: TextStyle(
          height: textHeight,
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          backgroundColor: backcolor),
      textAlign: textAlign,
    );
  }
}
