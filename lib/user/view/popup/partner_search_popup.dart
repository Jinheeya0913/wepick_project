// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wepick/common/layout/component/text/custom_text_con_bottom_ln.dart';
import 'package:wepick/common/layout/component/text/custom_text_form_field.dart';

class PartnerSearchPopup extends StatefulWidget {
  const PartnerSearchPopup({Key? key}) : super(key: key);

  @override
  State<PartnerSearchPopup> createState() => _PartnerSearchPopupState();
}

class _PartnerSearchPopupState extends State<PartnerSearchPopup> {
  String searchCd = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomTextConBottom(
        text: '파트너 찾기',
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Flexible(
                flex: 8,
                child: CustomTextFormField(
                  borderColor: Colors.black,
                  filled: false,
                  hintText: '코드를 입력해주세요',
                  onChanged: (String value) {
                    searchCd = value;
                  },
                ),
              ),
              Flexible(
                  flex: 2,
                  child:
                      IconButton(onPressed: () {}, icon: Icon(Icons.search))),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                color: Colors.lightGreen,
              ),
              SizedBox(
                width: 16.0,
              ),
              Icon(
                Icons.circle_outlined,
                color: Colors.lightGreen,
              ),
            ],
          )
        ],
      ),
    );
  }
}
