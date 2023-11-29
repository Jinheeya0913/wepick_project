import 'package:flutter/material.dart';
import 'package:wepick/common/const/data.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String? networkImgUrl;
  final String? defaultAssetUrl;

  const CustomCircleAvatar({
    this.networkImgUrl,
    this.defaultAssetUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (networkImgUrl != null) {
      return CircleAvatar(
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
