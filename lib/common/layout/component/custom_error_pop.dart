import 'package:flutter/material.dart';

class CustomErrorPop extends StatefulWidget {
  final String title;
  final String? errorMsg;

  const CustomErrorPop({
    required this.title,
    this.errorMsg,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomErrorPop> createState() => _CustomErrorPopState();
}

class _CustomErrorPopState extends State<CustomErrorPop> {
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
        children: [
          if (widget.errorMsg != null) Text(widget.errorMsg!),
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
