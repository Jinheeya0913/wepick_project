// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/layout/component/custom_circleAvatar.dart';
import 'package:wepick/common/layout/component/text/custom_text_con_bottom_ln.dart';
import 'package:wepick/user/model/partner_req_que_model.dart';
import 'package:wepick/user/model/partner_search_result_model.dart';
import 'package:wepick/user/model/user_model.dart';
import 'package:wepick/user/provider/partner_provider.dart';

class PartnerSearchResult2 extends ConsumerStatefulWidget {
  static String get routeName => 'partnerSearchResultPop';

  final PartnerSearchInfoModel searchResultModel;
  final String searchCd;

  const PartnerSearchResult2({
    required this.searchResultModel,
    required this.searchCd,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<PartnerSearchResult2> createState() =>
      _PartnerSearchResult2State();
}

class _PartnerSearchResult2State extends ConsumerState<PartnerSearchResult2> {
  @override
  Widget build(BuildContext context) {
    final acceptorModel = widget.searchResultModel.partnerInfo;
    final reqInfo = widget.searchResultModel.reqQueInfo;
    final tempRegCd = widget.searchCd;

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
                    networkImgUrl:
                        widget.searchResultModel.partnerInfo!.userImgUrl,
                    radius: 80,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(widget.searchResultModel.partnerInfo!.userNm)],
          ),
          /**
           *  요청 진행 중인 사항이 없다면
           */
          reqInfo == null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final ptSearchIfModel = PartnerSearchInfoModel(
                          partnerInfo: acceptorModel,
                        );

                        final resp = await ref
                            .read(partnerProvider.notifier)
                            .sendPartnerRequest(tempRegCd);
                      },
                      child: Text('요청'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('취소'),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Text(
                      '요청이 진행 중입니다',
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
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
}
