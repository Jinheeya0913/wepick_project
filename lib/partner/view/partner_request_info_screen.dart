import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/layout/component/custom_alert_pop.dart';
import 'package:wepick/common/layout/default_layout.dart';
import 'package:wepick/partner/provider/partner_provider.dart';

import '../model/partner_model.dart';

class PartnerRequestInfoScreen extends ConsumerStatefulWidget {
  static String get routeName => 'PartnerReqInfo';
  const PartnerRequestInfoScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PartnerRequestInfoScreen> createState() =>
      _PartnerRequestInfoScreenState();
}

class _PartnerRequestInfoScreenState
    extends ConsumerState<PartnerRequestInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final dataModel = ref.read(partnerProvider);

    if (dataModel is PartnerInfoEmptyModel) {
      return DefaultLayout(
        title: '요청목록',
        child: Column(
          children: [
            Text('data'),
          ],
        ),
      );
    } else {
      return const CustomSimpleAlertPop(
        title: '2',
      );
    }
  }
}
