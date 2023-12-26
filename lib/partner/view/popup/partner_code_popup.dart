// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/partner/provider/partner_provider.dart';

import '../../../common/layout/custom/custom_alert_pop.dart';
import '../../../common/layout/custom/text/custom_text_con_alll_ln.dart';

class PartnerCodePopup extends ConsumerStatefulWidget {
  const PartnerCodePopup({Key? key}) : super(key: key);

  @override
  ConsumerState<PartnerCodePopup> createState() => _PartnerCodePopupState();
}

class _PartnerCodePopupState extends ConsumerState<PartnerCodePopup> {
  late String code;
  late String copyMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // icon: Icon(Icons.abc),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('파트너 코드 생성'),
          IconButton(
            onPressed: () async {
              final partnerCode =
                  await ref.read(partnerProvider.notifier).getMyPartnerCode();
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
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            '닫기',
          ),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextConAllLine(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            copyToClipboard(code);
                          },
                          icon: Icon(Icons.copy),
                        ),
                        SizedBox(width: 8.0),
                        Text(code),
                        SizedBox(width: 8.0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  copyMessage,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.right,
                ),
              ),
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
    copyMessage = '';
  }

  void copyToClipboard(String text) {
    String copyResult = '';
    if (text == '코드를 생성해주세요') {
      copyResult = '코드를 먼저 생성해주십시오.';
    } else {
      copyResult = '복사가 완료되었습니다.';
      Clipboard.setData(ClipboardData(text: text));
    }

    setState(() {
      copyMessage = copyResult;
    });
  }
}
