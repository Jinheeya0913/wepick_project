import 'package:flutter/material.dart';

class CustomTextConBottom extends StatelessWidget {
  final String text;
  final double borderWidth;
  final Color borderColor;

  const CustomTextConBottom({
    required this.text,
    this.borderWidth = 1,
    this.borderColor = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderColor,
            width: borderWidth,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
