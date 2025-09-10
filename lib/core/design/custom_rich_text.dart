import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../utils/text_style_theme.dart';

class CustomRichText extends StatelessWidget {
  final String? text, subText,slash;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final TextStyle? subTextStyle;
  final TextAlign textAlign;

  const CustomRichText({
    super.key,
    required this.text,
    required this.subText,
    this.textAlign = TextAlign.center,
    this.onTap,
    this.slash,
    this.textStyle,
    this.subTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: textStyle,
          ),
          TextSpan(
            text: slash,
            style: TextStyleTheme.textStyle15Bold,
          ),
          TextSpan(
            text: subText,
            recognizer: TapGestureRecognizer()..onTap = onTap,
            style: subTextStyle,
          ),
        ],
      ),
    );
  }
}
