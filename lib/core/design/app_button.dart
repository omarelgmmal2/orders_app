import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final Widget? icon;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.style,
    this.textStyle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: style,
      onPressed: onPressed,
      icon: icon,
      label: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
