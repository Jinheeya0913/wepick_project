import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/layout/component/button/custom_text_button.dart';
import 'package:wepick/common/layout/component/custom_circleAvatar.dart';
import 'package:wepick/common/layout/default_layout.dart';
import 'package:wepick/common/layout/default_padding.dart';
import 'package:wepick/common/utils/datetimeUtil.dart';
import 'package:wepick/partner/model/partner_model.dart';
import 'package:wepick/partner/provider/partner_provider.dart';

class PartnerInfoScreen extends ConsumerStatefulWidget {
  static get routeName => 'partnerInfo';

  const PartnerInfoScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PartnerInfoScreen> createState() => _PartnerInfoScreenState();
}

class _PartnerInfoScreenState extends ConsumerState<PartnerInfoScreen> {
  DateTime? meetDt;
  String partnerNm = '';
  @override
  Widget build(BuildContext context) {
    final partnerInfo = ref.watch(partnerProvider) as PartnerInfoModel;

    meetDt ??= partnerInfo.meetDt;
    partnerNm = partnerInfo.partnerNm;

    return DefaultLayout(
        title: '파트너 정보',
        automaticallyImplyLeading: true,
        child: DefaultPadding(
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: ColoredBox(
                      color: Colors.blue,
                      child: Hero(
                        tag: partnerInfo.partnerId,
                        child: CustomCircleAvatar(
                          radius: 80,
                          networkImgUrl: partnerInfo.partnerImgUrl,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '이름',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              partnerNm,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '만난일',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            meetDt != null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateTimeUtil.simpleFormatDateTime(
                                            meetDt!),
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      CustomTextButton(
                                        onPressed: () {
                                          _selectMeetDate();
                                        },
                                        inputText: '변경 하기',
                                      ),
                                    ],
                                  )
                                : CustomTextButton(
                                    onPressed: () async {
                                      // 날짜 선택
                                      _selectMeetDate();
                                    },
                                    inputText: '날짜 선택',
                                    fontSize: 16.0,
                                  )
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '만난지',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '    ',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> _selectMeetDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      final resp = await ref
          .read(partnerProvider.notifier)
          .setPartnerMeetDt(selectedDate.toLocal());

      setState(() {
        meetDt = selectedDate;
      });
    }
  }
}
