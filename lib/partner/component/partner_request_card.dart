// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/common/const/status.dart';
import 'package:wepick/common/layout/component/custom_alert_pop.dart';
import 'package:wepick/common/layout/component/custom_circleAvatar.dart';
import 'package:wepick/common/utils/datetimeUtil.dart';
import 'package:wepick/common/utils/statusConvertUtil.dart';
import 'package:wepick/partner/model/partner_model.dart';
import 'package:wepick/partner/provider/partner_provider.dart';
import 'package:wepick/user/view/userInfo_screen.dart';

import '../../user/model/user_model.dart';
import '../model/partner_req_que_model.dart';

class PartnerRequestCard extends ConsumerStatefulWidget {
  PartnerReqQueModel queModel;
  UserModel userModel;

  PartnerRequestCard({
    required this.queModel,
    required this.userModel,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<PartnerRequestCard> createState() => _PartnerRequestCardState();
}

class _PartnerRequestCardState extends ConsumerState<PartnerRequestCard> {
  @override
  Widget build(BuildContext context) {
    final ptReqStatus = widget.queModel.ptReqStatus;

    return Column(
      children: [
        Row(
          children: [
            // 임시 이미지
            CustomCircleAvatar(
              radius: 80.0,
              // defaultAssetUrl: 'assets/img/user/my_profile.jpeg',
              networkImgUrl: widget.userModel.userImgUrl,
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '이름',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      widget.userModel.userNm,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '요청일자',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      DateTimeUtil.simpleFormatDateTime(widget.queModel.regDt!),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '요청처리',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      StatusConvertUtil.statusConvert(ptReqStatus),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 18.0,
        ),
        renderButtonsRow(),
      ],
    );
  }

  Widget renderButtonsRow() {
    final ptReqStatus = widget.queModel.ptReqStatus;
    print(widget.queModel.ptTempCd);
    if (ptReqStatus == STAT_PROGRESSED) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                final resp = await ref
                    .read(partnerProvider.notifier)
                    .acceptPartnerRequest(widget.queModel);

                // '처리 완료'로 상태 변경
                setState(() {
                  widget.queModel.ptReqStatus = STAT_COMPLETED;
                });
              },
              child: Text('수락'),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(child: Text('정말로 거절하시겠습니까?')),
                        ),
                      ],
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () async {
                                final resp = await ref
                                    .read(partnerProvider.notifier)
                                    .refusePartnerRequest(widget.queModel);

                                if (resp) {
                                  showDialog(
                                      context: context,
                                      builder: (_) =>
                                          CustomSimpleAlertPop(title: '성공'));

                                  Navigator.of(context).pop();
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) =>
                                          CustomSimpleAlertPop(title: '거절실패'));
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.cancel_outlined),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              child: Text('거절'),
            ),
          ),
        ],
      );
    } else if (ptReqStatus == STAT_COMPLETED) {
      return Text('처리 완료');
    } else {
      return Text('오류');
    }
  }
}
