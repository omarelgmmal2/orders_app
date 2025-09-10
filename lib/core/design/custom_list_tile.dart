import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Function()? onTap;
  final Widget? trailing;
  final Widget? leading;
  final String titleText;
  final String subTitleText;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;

  const CustomListTile({
    super.key,
    this.onTap,
    this.trailing,
    this.leading,
    required this.titleText,
    required this.subTitleText,
    required this.titleStyle,
    required this.subTitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      trailing: trailing,
      leading: leading,
      title: Text(
        titleText,
        style: titleStyle,
      ),
      subtitle: Text(
        subTitleText,
        style: subTitleStyle,
      ),
    );
  }
}
