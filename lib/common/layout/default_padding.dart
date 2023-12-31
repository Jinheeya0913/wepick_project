import 'package:flutter/material.dart';

class DefaultPadding extends StatelessWidget {
  final Widget child;
  const DefaultPadding({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: child,
    );
  }
}
