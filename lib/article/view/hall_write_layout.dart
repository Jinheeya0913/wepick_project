import 'package:flutter/material.dart';

class HallWriteLayout extends StatefulWidget {
  const HallWriteLayout({Key? key}) : super(key: key);

  @override
  State<HallWriteLayout> createState() => _HallWriteLayoutState();
}

class _HallWriteLayoutState extends State<HallWriteLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'formTitle',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // 여기에 각 폼 필드를 추가하세요.
        ],
      ),
    );
  }
}
