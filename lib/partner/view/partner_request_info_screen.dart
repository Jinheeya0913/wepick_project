import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/layout/default_layout.dart';
import 'package:wepick/partner/component/partner_request_card.dart';
import 'package:wepick/partner/model/partner_req_que_model.dart';
import 'package:wepick/partner/model/partner_search_result_model.dart';
import 'package:wepick/partner/provider/partner_provider.dart';
import 'package:wepick/user/model/user_model.dart';

import '../../common/component/custom_alert_pop.dart';
import '../model/partner_model.dart';

class PartnerRequestInfoScreen extends ConsumerStatefulWidget {
  static String get routeName => 'PartnerReqInfo';

  const PartnerRequestInfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<PartnerRequestInfoScreen> createState() =>
      _PartnerRequestInfoScreenState();
}

class _PartnerRequestInfoScreenState
    extends ConsumerState<PartnerRequestInfoScreen> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    late List<PartnerSearchInfoModel?> reqList;
    final dataModel = ref.read(partnerProvider);

    if (dataModel is PartnerInfoEmptyModel) {
      reqList = dataModel.requestInfoList!;
      return DefaultLayout(
        title: '요청목록',
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: RefreshIndicator(
            onRefresh: () async {
              final respReq = await ref
                  .read(partnerProvider.notifier)
                  .getMyPartnerRequestQue();
              if (respReq != null) reqList = respReq;
            },
            child: ListView.separated(
              physics: AlwaysScrollableScrollPhysics(),
              controller: controller,
              itemCount: dataModel.requestInfoList!.length + 1,
              itemBuilder: (_, index) {
                if (index == dataModel.requestInfoList!.length) {
                  return const Text('마지막 데이터 입니다');
                }
                final userData = reqList[index];

                if (userData == null) {
                  return const Text('오류 발생');
                }

                PartnerReqQueModel? queModel = userData.reqQueInfo;
                UserModel? userModel = userData.partnerInfo;

                if (queModel == null || userModel == null) {
                  return const Text('오류 발생');
                }

                return PartnerRequestCard(
                  userModel: userModel,
                  queModel: queModel,
                );
              },
              separatorBuilder: (_, index) {
                return SizedBox(
                  height: 16.0,
                );
              },
            ),
          ),
        ),
      );
    } else {
      return const CustomSimpleAlertPop(
        title: '2',
      );
    }
  }
}
