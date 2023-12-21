// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/const/colors.dart';
import 'package:wepick/partner/component/partner_simple_card.dart';
import 'package:wepick/user/component/user_info_tab.dart';
import 'package:wepick/user/view/popup/image_popup.dart';
import 'package:wepick/common/layout/component/custom_circleAvatar.dart';
import 'package:wepick/common/layout/default_layout.dart';
import 'package:wepick/user/component/user_simple_card.dart';
import 'package:wepick/partner/model/partner_model.dart';
import 'package:wepick/partner/provider/partner_provider.dart';

import '../model/user_model.dart';
import '../provider/user_provider.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  static String get routeName => 'me';
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userProvider);
    final partner = ref.watch(partnerProvider);

    state as UserModel;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
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
          ColoredBox(
            // Todo : Other Option
            color: Colors.pinkAccent,
            child: UserInfoTab(),
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
          child: Icon(
            Icons.favorite,
            color: partnerInfo is PartnerInfoModel ? Colors.pink : Colors.grey,
          ),
        ),
      ],
    );
  }
}
