import 'package:flutter/material.dart';

class PackageWriteLayout extends StatefulWidget {
  const PackageWriteLayout({Key? key}) : super(key: key);

  @override
  State<PackageWriteLayout> createState() => _PackageWriteLayoutState();
}

class _PackageWriteLayoutState extends State<PackageWriteLayout> {
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
            '패키지',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // 여기에 각 폼 필드를 추가하세요.
        ],
      ),
    );
    ;
  }
}
