import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/partner/model/partner_model.dart';
import 'package:wepick/partner/view/popup/partner_code_popup.dart';
import 'package:wepick/partner/view/partner_request_info_screen.dart';
import 'package:wepick/partner/view/popup/partner_search_pop_1.dart';

import '../../common/layout/component/custom_circleAvatar.dart';
import '../../user/model/user_model.dart';

class PartnerInfoCard extends ConsumerStatefulWidget {
  final PartnerInfoModelBase? partnerModel;

  const PartnerInfoCard({
    required this.partnerModel,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<PartnerInfoCard> createState() => _PartnerInfoCardState();
}

class _PartnerInfoCardState extends ConsumerState<PartnerInfoCard> {
  @override
  Widget build(BuildContext context) {
    final partnerInfo = widget.partnerModel;

    if (partnerInfo != null && partnerInfo is PartnerInfoEmptyModel) {
      return ColoredBox(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColoredBox(
                color: Colors.blueAccent,
                child: Container(
                  child: ElevatedButton(
                    onPressed: () async {
                      final requestInfo = partnerInfo.requestInfoList;
                      if (requestInfo != null && requestInfo.isNotEmpty) {
                        context.goNamed(PartnerRequestInfoScreen.routeName);
                      }
                    },
                    child: Text(partnerInfo.requestInfoList != null
                        ? '${partnerInfo.requestInfoList!.length} 건'
                        : '0 건'),
                  ),
                ),
              ),
              ColoredBox(
                color: Colors.blueAccent,
                child: Container(
                    child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return PartnerSearchPop2();
                            },
                          );
                        },
                        child: Text('요청하기'))),
              ),
              ColoredBox(
                color: Colors.blueAccent,
                child: Container(
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return PartnerCodePopup();
                          },
                        );
                      },
                      child: Text('코드 생성')),
                ),
              )
            ],
          ),
        ),
      );
    } else if (partnerInfo is PartnerInfoModel) {
      return Column(
        children: [
          GestureDetector(
            child: renderAvatar(partnerInfo),
            onTap: () {},
          ),
          // GestureDetector(
          //   onTap: () {
          //     Todo 유저면 사진 변경 가능, 파트너면 파트너 정보 상세보기
          // },
          // child:
          // ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
          TextButton(
            child: Text(partnerInfo.partnerNm),
            onPressed: () {},
          ),
        ],
      );
    } else {
      return Text('data');
    }
  }

  CustomCircleAvatar renderAvatar(PartnerInfoModel partner) {
    return CustomCircleAvatar(
      // 너비의 1/5 반지름
      radius: 80,
      networkImgUrl: partner.partnerImgUrl,
    );
  }

  Widget renderNoPartner() {
    return Column(
      children: [Text('data')],
    );
  }
}
