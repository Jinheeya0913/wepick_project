import 'package:flutter/material.dart';

class GiftWriteLayout extends StatefulWidget {
  const GiftWriteLayout({Key? key}) : super(key: key);

  @override
  State<GiftWriteLayout> createState() => _GiftWriteLayoutState();
}

class _GiftWriteLayoutState extends State<GiftWriteLayout> {
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
            'gift',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // 여기에 각 폼 필드를 추가하세요.
        ],
      ),
    );
  }
}
