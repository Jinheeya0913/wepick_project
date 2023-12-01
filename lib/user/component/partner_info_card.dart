import 'package:flutter/material.dart';
import 'package:wepick/user/model/partner_model.dart';
import 'package:wepick/user/view/popup/partner_code_popup.dart';

class PartnerInfoCard extends StatelessWidget {
  final PartnerInfoModelBase partnerModel;

  const PartnerInfoCard({
    required this.partnerModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Text('요청 확인'),
            TextButton(onPressed: () {}, child: Text('0건')),
          ]),
          Column(children: [
            Text('요청하기'),
            TextButton(onPressed: () {}, child: Text('완  료 : 0건\r\n처리중 : 0건')),
          ]),
          ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return PartnerCodePopup();
                  },
                );
              },
              child: Text('코드 생성'))
        ],
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

  // Widget noPartnerInfo() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Column(children: [
  //         Text('요청 확인'),
  //         TextButton(onPressed: () {}, child: Text('0건')),
  //       ]),
  //       Column(children: [
  //         Text('요청하기'),
  //         TextButton(onPressed: () {}, child: Text('완  료 : 0건\r\n처리중 : 0건')),
  //       ]),
  //       ElevatedButton(
  //           onPressed: () {
  //             showDialog(
  //               context: context,
  //               builder: (_) {
  //                 return PartnerCodePopup();
  //               },
  //             );
  //           },
  //           child: Text('코드 생성'))
  //     ],
  //   );
  // }
}
