import 'package:flutter/material.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';

class CustomOutlineButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  const CustomOutlineButton({
    super.key,
    required this.onPress,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPress,
      child: Text(
        title,
        style: TextStyleTheme.textStyle15Bold,
      ),
    );
  }
}