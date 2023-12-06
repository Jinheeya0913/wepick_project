// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/layout/component/custom_alert_pop.dart';
import 'package:wepick/common/layout/component/text/custom_text_con_bottom_ln.dart';
import 'package:wepick/common/layout/component/text/custom_text_form_field.dart';
import 'package:wepick/user/model/user_model.dart';
import 'package:wepick/user/provider/partner_provider.dart';
import 'package:wepick/user/view/popup/partner_search_result_popup.dart';

class PartnerSearchPopup extends ConsumerStatefulWidget {
  const PartnerSearchPopup({Key? key}) : super(key: key);

  @override
  ConsumerState<PartnerSearchPopup> createState() => _PartnerSearchPopupState();
}

class _PartnerSearchPopupState extends ConsumerState<PartnerSearchPopup> {
  String searchCd = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.read(partnerProvider.notifier);
    return AlertDialog(
      title: CustomTextConBottom(
        text: '파트너 찾기',
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Flexible(
                flex: 8,
                child: CustomTextFormField(
                  borderColor: Colors.black,
                  filled: false,
                  hintText: '코드를 입력해주세요',
                  onChanged: (String value) {
                    searchCd = value;
                    print(searchCd);
                  },
                ),
              ),
              Flexible(
                  flex: 2,
                  child: IconButton(
                      onPressed: () async {
                        print(searchCd);
                        final result = await state!
                            .searchPartnerWithCode(ptTempRegCd: searchCd);
                        if (result is UserModelError) {
                          showDialog(
                              context: context,
                              builder: (_) =>
                                  CustomSimpleAlertPop(title: '조회 실패'));
                        } else if (result is UserModel) {
                          Navigator.of(context).pop();
                          showDialog(
                              context: context,
                              builder: (_) => PartnerSearchResultPopup());
                        } else {}
                      },
                      icon: Icon(Icons.search))),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                color: Colors.lightGreen,
              ),
              SizedBox(
                width: 16.0,
              ),
              Icon(
                Icons.circle_outlined,
                color: Colors.lightGreen,
              ),
            ],
          )
        ],
      ),
    );
  }

  AlertDialog renderSearch(PartnerStateNotifier state) {
    return AlertDialog(
      title: CustomTextConBottom(
        text: '파트너 찾기',
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Flexible(
                flex: 8,
                child: CustomTextFormField(
                  borderColor: Colors.black,
                  filled: false,
                  hintText: '코드를 입력해주세요',
                  onChanged: (String value) {
                    searchCd = value;
                    print(searchCd);
                  },
                ),
              ),
              Flexible(
                  flex: 2,
                  child: IconButton(
                      onPressed: () async {
                        print(searchCd);
                        final result = await state!
                            .searchPartnerWithCode(ptTempRegCd: searchCd);
                        if (result is UserModelError) {
                          showDialog(
                              context: context,
                              builder: (_) =>
                                  CustomSimpleAlertPop(title: '조회 실패'));
                        } else if (result is UserModel) {
                        } else {}
                      },
                      icon: Icon(Icons.search))),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                color: Colors.lightGreen,
              ),
              SizedBox(
                width: 16.0,
              ),
              Icon(
                Icons.circle_outlined,
                color: Colors.lightGreen,
              ),
            ],
          )
        ],
      ),
    );
  }
}
