import 'package:cached_network_image/cached_network_image.dart';
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
        radius: radius ?? radius,
        backgroundColor: Color(0xffE6E6E6),
        backgroundImage:
            defaultAssetUrl != null ? AssetImage(defaultAssetUrl!) : null,
        child: Icon(
          Icons.person,
          color: Color(0xffCCCCCC),
        ),
      );
    }
  }
}
