import 'package:flutter/material.dart';
import 'package:wepick/common/const/data.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String? networkImgUrl;
  final String? defaultAssetUrl;
  final double? radius;

  const CustomCircleAvatar({
    this.networkImgUrl,
    this.defaultAssetUrl,
    this.radius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (networkImgUrl != null) {
      print('[custom_circleAvatar] >> network!!');
      return CircleAvatar(
        radius: radius ?? radius,
        backgroundImage: NetworkImage(
          "http://$ip/file/me/getProfileImg?pid=" + networkImgUrl!,
        ),
      );
    } else {
      return CircleAvatar(
        backgroundImage: AssetImage(
          defaultAssetUrl!,
        ),
      );
    }
  }
}
