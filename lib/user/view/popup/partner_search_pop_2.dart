// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:wepick/common/layout/component/custom_circleAvatar.dart';
import 'package:wepick/common/layout/component/text/custom_text_con_bottom_ln.dart';
import 'package:wepick/user/model/partner_req_que_model.dart';
import 'package:wepick/user/model/partner_search_result_model.dart';

class PartnerSearchResult2 extends StatelessWidget {
  static String get routeName => 'partnerSearchResultPop';

  final PartnerSearchResultModel searchResultModel;

  const PartnerSearchResult2({
    required this.searchResultModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final partnerInfo = searchResultModel.partnerInfo;
    final reqInfo = searchResultModel.reqQueInfo;

    return AlertDialog(
      title: CustomTextConBottom(text: '파트너 찾기'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ColoredBox(
                color: Colors.black,
                child: Center(
                  child: CustomCircleAvatar(
                    networkImgUrl: searchResultModel.partnerInfo!.userImgUrl,
                    radius: 80,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(searchResultModel.partnerInfo!.userNm)],
          ),
          renderRequestButton(reqInfo),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle_outlined,
                color: Colors.lightGreen,
              ),
              SizedBox(
                width: 16.0,
              ),
              Icon(
                Icons.circle,
                color: Colors.lightGreen,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget renderRequestButton(PartnerReqQueModel? reqInfo) {
    String result = '';
    if (reqInfo == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('요청'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('취소'),
          ),
        ],
      );
    } else {}

    return Text(result);
  }
}
