// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/const/colors.dart';
import 'package:wepick/user/component/partner_info_card.dart';
import 'package:wepick/user/component/user_info_tab.dart';
import 'package:wepick/user/view/popup/image_popup.dart';
import 'package:wepick/common/layout/component/custom_circleAvatar.dart';
import 'package:wepick/common/layout/default_layout.dart';
import 'package:wepick/user/component/user_info_card.dart';
import 'package:wepick/user/model/partner_model.dart';
import 'package:wepick/user/provider/partner_provider.dart';

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
    final state = ref.read(userProvider);
    final partner = ref.read(partnerProvider);

    if (partner is PartnerInfoEmptyModel) {
      print('[userInfoSc] >> 파트너 없음');
    }

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
                UserInfoCard(userModel: state),
                if (partner is PartnerInfoModel)
                  Center(child: Icon(Icons.favorite, color: Colors.grey)),
                PartnerInfoCard(partnerModel: partner!),
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
