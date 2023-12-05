import 'package:flutter/material.dart';

class CustomTextConAllLine extends StatelessWidget {
  final Widget child;
  const CustomTextConAllLine({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
    );
  }
}
