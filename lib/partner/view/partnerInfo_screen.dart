import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/layout/default_layout.dart';
import 'package:wepick/common/layout/default_padding.dart';
import 'package:wepick/common/utils/datetimeUtil.dart';
import 'package:wepick/partner/model/partner_model.dart';
import 'package:wepick/partner/provider/partner_provider.dart';

import '../../common/layout/custom/custom_alert_pop.dart';
import '../../common/layout/custom/custom_circleAvatar.dart';
import '../../common/layout/custom/text/custom_text_form_field.dart';

class PartnerInfoScreen extends ConsumerStatefulWidget {
  static get routeName => 'partnerInfo';

  const PartnerInfoScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PartnerInfoScreen> createState() => _PartnerInfoScreenState();
}

class _PartnerInfoScreenState extends ConsumerState<PartnerInfoScreen> {
  DateTime? meetDt;
  String partnerNm = '';
  String? partnerAlias;
  int? dDayPlus;

  // 입력용
  String newPartnerAlias = '';

  @override
  Widget build(BuildContext context) {
    final partnerInfo = ref.watch(partnerProvider) as PartnerInfoModel;

    meetDt ??= partnerInfo.meetDt;
    partnerNm = partnerInfo.partnerNm;
    partnerAlias = partnerInfo.partnerAlias;

    if (meetDt != null) {
      dDayPlus = DateTimeUtil.calDDayPlus(meetDt!);
    }

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
                    child: Hero(
                      tag: partnerInfo.partnerId,
                      child: CustomCircleAvatar(
                        radius: 80,
                        networkImgUrl: partnerInfo.partnerImgUrl,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              '이름',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              partnerNm,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  '별명',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: const Text('별명등록'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                final result =
                                                    await _setPartnerAlias(
                                                        newPartnerAlias);

                                                if (result) {
                                                  Navigator.of(context).pop();
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) {
                                                        return const CustomSimpleAlertPop(
                                                            title: '변경 완료');
                                                      });
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) {
                                                        return const CustomSimpleAlertPop(
                                                          title: '변경 실패',
                                                          content: '다시 시도 바랍니다',
                                                        );
                                                      });
                                                }
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.green),
                                              ),
                                              child: const Text(
                                                '변경',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(
                                                height: 8.0,
                                              ),
                                              CustomTextFormField(
                                                hintText:
                                                    '등록할 별명을 입력해주세요 (최대 10글자)',
                                                maxLength: 10,
                                                contentPadding: 8.0,
                                                onChanged: (value) {
                                                  newPartnerAlias = value;
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    size: 18.0,
                                  ),
                                ),
                              ],
                            ),
                            Text(partnerAlias ?? '별명을 생성해주세요'),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  '만난일',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _selectMeetDate();
                                  },
                                  icon: Icon(Icons.edit_calendar_outlined),
                                ),
                              ],
                            ),
                            meetDt != null
                                ? Row(
                                    children: [
                                      Text(
                                        DateTimeUtil.simpleFormatDateTime(
                                            meetDt!),
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text(
                                    '날짜를 선택해주세요',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                  ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            const Text(
                              'D+',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${dDayPlus ?? '0'}',
                              style: const TextStyle(
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

  Future<bool> _setPartnerAlias(String alias) async {
    final resp =
        await ref.read(partnerProvider.notifier).setPartnerAlias(alias);

    if (resp) {
      setState(() {});
    }

    return resp;
  }
}
