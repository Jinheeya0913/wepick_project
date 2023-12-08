import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/partner/model/partner_model.dart';
import 'package:wepick/user/view/popup/partner_code_popup.dart';
import 'package:wepick/user/view/popup/partner_search_pop_1.dart';

class PartnerInfoCard extends ConsumerStatefulWidget {
  final PartnerInfoModelBase partnerModel;

  const PartnerInfoCard({
    required this.partnerModel,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<PartnerInfoCard> createState() => _PartnerInfoCardState();
}

class _PartnerInfoCardState extends ConsumerState<PartnerInfoCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: ColoredBox(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColoredBox(
                  color: Colors.blueAccent,
                  child: Container(
                      child: TextButton(onPressed: () {}, child: Text('0건')))),
              ColoredBox(
                color: Colors.blueAccent,
                child: Container(
                    child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return PartnerSearchPop2();
                              });
                        },
                        child: Text('요청하기'))),
              ),
              ColoredBox(
                color: Colors.blueAccent,
                child: Container(
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return PartnerCodePopup();
                          },
                        );
                      },
                      child: Text('코드 생성')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget hasPartnerInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [Text('data')]),
        Row(children: [Text('data')]),
        Row(children: [Text('data')]),
      ],
    );
  }
}
