import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String inputText;
  final VoidCallback? onPressed;
  final double? fontSize;

  const CustomTextButton({
    required this.onPressed,
    required this.inputText,
    this.fontSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        inputText,
        style: TextStyle(
          fontSize: fontSize,
        ),
      ),
    );
  }
}
