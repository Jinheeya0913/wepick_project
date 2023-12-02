import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PartnerSearchPopup extends StatefulWidget {
  const PartnerSearchPopup({Key? key}) : super(key: key);

  @override
  State<PartnerSearchPopup> createState() => _PartnerSearchPopupState();
}

class _PartnerSearchPopupState extends State<PartnerSearchPopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Column(
        children: [
          Text('data'),
        ],
      ),
    );
  }
}
