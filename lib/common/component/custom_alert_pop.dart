import 'package:flutter/material.dart';

class CustomSimpleAlertPop extends StatefulWidget {
  final String title;
  final String? content;

  const CustomSimpleAlertPop({
    required this.title,
    this.content,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomSimpleAlertPop> createState() => _CustomSimpleAlertPopState();
}

class _CustomSimpleAlertPopState extends State<CustomSimpleAlertPop> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.content != null) Text(widget.content!),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('돌아가기'),
        )
      ],
    );
  }
}
