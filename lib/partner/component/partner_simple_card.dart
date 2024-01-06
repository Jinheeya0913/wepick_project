import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/partner/model/partner_model.dart';
import 'package:wepick/partner/view/partnerInfo_screen.dart';
import 'package:wepick/partner/view/popup/partner_code_popup.dart';
import 'package:wepick/partner/view/partner_request_info_screen.dart';
import 'package:wepick/partner/view/popup/partner_search_pop_1.dart';

import '../../common/layout/custom/custom_circleAvatar.dart';

class PartnerSimpleCard extends ConsumerStatefulWidget {
  final PartnerInfoModelBase? partnerModel;

  const PartnerSimpleCard({
    required this.partnerModel,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<PartnerSimpleCard> createState() => _PartnerSimpleCardState();
}

class _PartnerSimpleCardState extends ConsumerState<PartnerSimpleCard> {
  @override
  Widget build(BuildContext context) {
    final partnerInfo = widget.partnerModel;

    if (partnerInfo != null && partnerInfo is PartnerInfoEmptyModel) {
      return ColoredBox(
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ColoredBox(
              color: Colors.blueAccent,
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
            ColoredBox(
              color: Colors.blueAccent,
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return const PartnerSearchPop2();
                      },
                    );
                  },
                  child: const Text('요청하기')),
            ),
            ColoredBox(
              color: Colors.blueAccent,
              child: Container(
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return const PartnerCodePopup();
                        },
                      );
                    },
                    child: const Text('코드 생성')),
              ),
            )
          ],
        ),
      );
    } else if (partnerInfo is PartnerInfoModel) {
      return Column(
        children: [
          Hero(
            tag: partnerInfo.partnerId,
            child: GestureDetector(
              child: renderAvatar(partnerInfo),
              onTap: () {
                context.pushNamed(PartnerInfoScreen.routeName);
              },
            ),
          ),
          TextButton(
            child: partnerInfo.partnerAlias != null
                ? Text(partnerInfo.partnerAlias!)
                : Text(partnerInfo.partnerNm),
            onPressed: () {},
          ),
        ],
      );
    } else {
      return const Text('data');
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
    return const Column(
      children: [Text('data')],
    );
  }
}
