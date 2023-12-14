// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/const/colors.dart';
import 'package:wepick/partner/component/partner_info_card.dart';
import 'package:wepick/user/component/user_info_tab.dart';
import 'package:wepick/user/view/popup/image_popup.dart';
import 'package:wepick/common/layout/component/custom_circleAvatar.dart';
import 'package:wepick/common/layout/default_layout.dart';
import 'package:wepick/user/component/user_info_card.dart';
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
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // Todo : User & Partner Info
              children: [
                Flexible(
                  flex: 4,
                  child: UserInfoCard(userModel: state),
                ),
                // if (partner is PartnerInfoModel)
                Flexible(
                  flex: 2,
                  child: ColoredBox(
                    color: Colors.green,
                    child: Icon(Icons.favorite, color: Colors.grey),
                  ),
                ),
                Flexible(
                    flex: 4,
                    child: PartnerInfoCard(
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
}
