// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/const/colors.dart';
import 'package:wepick/common/utils/datetimeUtil.dart';
import 'package:wepick/partner/component/partner_simple_card.dart';
import 'package:wepick/user/component/user_info_tab.dart';
import 'package:wepick/user/component/weding_menu.dart';
import 'package:wepick/user/component/weding_toggle_menu.inactive';
import 'package:wepick/user/component/user_simple_card.dart';
import 'package:wepick/partner/model/partner_model.dart';
import 'package:wepick/partner/provider/partner_provider.dart';

import '../model/user_model.dart';
import '../provider/user_provider.dart';

class MyWedingScreen extends ConsumerStatefulWidget {
  static String get routeName => 'me';
  const MyWedingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MyWedingScreen> createState() => _MyWedingScreenState();
}

class _MyWedingScreenState extends ConsumerState<MyWedingScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userProvider);
    final partner = ref.watch(partnerProvider);

    state as UserModel;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Todo : User & Partner Info
                children: [
                  Flexible(
                    flex: 3,
                    child: UserSimpleCard(userModel: state),
                  ),
                  // if (partner is PartnerInfoModel)
                  Flexible(
                    flex: 2,
                    child: partnerLinkInfo(partner),
                  ),
                  Flexible(
                      flex: 3,
                      child: PartnerSimpleCard(
                        // 파트너 카드
                        partnerModel: partner,
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
          ),
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: WedingMenu(),
              ),
            ),
          ),
        ],
      ),
    );
  } // _UserInfoScreenState

  Widget partnerLinkInfo(PartnerInfoModelBase? partnerInfo) {
    return Column(
      children: [
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // color: Colors.pink,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                color:
                    partnerInfo is PartnerInfoModel ? Colors.pink : Colors.grey,
              ),
              if (partnerInfo is PartnerInfoModel && partnerInfo.meetDt != null)
                Text('+${DateTimeUtil.calDDayPlus(partnerInfo.meetDt!)}')
            ],
          ),
        ),
      ],
    );
  }
}
