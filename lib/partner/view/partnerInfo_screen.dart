import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/layout/component/custom_circleAvatar.dart';
import 'package:wepick/common/layout/default_layout.dart';
import 'package:wepick/common/layout/default_padding.dart';
import 'package:wepick/partner/model/partner_model.dart';
import 'package:wepick/partner/provider/partner_provider.dart';

class PartnerInfoScreen extends ConsumerStatefulWidget {
  static get routeName => 'partnerInfo';

  const PartnerInfoScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PartnerInfoScreen> createState() => _PartnerInfoScreenState();
}

class _PartnerInfoScreenState extends ConsumerState<PartnerInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final partnerInfo = ref.read(partnerProvider) as PartnerInfoModel;

    return DefaultLayout(
        title: 'PartnerInfo',
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
                  Flexible(
                    flex: 3,
                    child: Column(
                      children: [
                        Text('data'),
                        Text('data'),
                        Text('data'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
