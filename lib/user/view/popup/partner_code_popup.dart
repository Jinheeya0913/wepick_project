// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/layout/component/custom_alert_pop.dart';
import 'package:wepick/user/provider/partner_provider.dart';

class PartnerCodePopup extends ConsumerStatefulWidget {
  const PartnerCodePopup({Key? key}) : super(key: key);

  @override
  ConsumerState<PartnerCodePopup> createState() => _PartnerCodePopupState();
}

class _PartnerCodePopupState extends ConsumerState<PartnerCodePopup> {
  late String code;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('파트너 코드 생성'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(code),
              IconButton(
                onPressed: () async {
                  final partnerCode = await ref
                      .read(partnerProvider.notifier)
                      .getMyPartnerCode();
                  // final partnerCode = null;
                  if (partnerCode != null) {
                    setState(() {
                      code = partnerCode;
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (_) => CustomSimpleAlertPop(
                        title: '코드발급 실패',
                      ),
                    );
                  }
                },
                icon: Icon(Icons.refresh_outlined),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    code = '코드를 생성해주세요';
  }
}
