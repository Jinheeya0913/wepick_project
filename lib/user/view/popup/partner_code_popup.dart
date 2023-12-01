import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PartnerCodePopup extends StatefulWidget {
  const PartnerCodePopup({Key? key}) : super(key: key);

  @override
  State<PartnerCodePopup> createState() => _PartnerCodePopupState();
}

class _PartnerCodePopupState extends State<PartnerCodePopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('파트너 코드 생성'),
      content: Column(),
    );
  }
}
