import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/layout/component/custom_circleAvatar.dart';

import '../view/popup/image_popup.dart';
import '../model/user_model.dart';
import '../provider/user_provider.dart';

class UserInfoCard extends ConsumerStatefulWidget {
  final UserModel? userModel;
  final bool userDivision;

  const UserInfoCard({
    this.userModel,
    this.userDivision = true, // false : 파트너 정보
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends ConsumerState<UserInfoCard> {
  //MediaQuery.of(context).size.height * 0.5,

  @override
  Widget build(BuildContext context) {
    final user = widget.userModel;
    final userDivision = widget.userDivision;
    // if (!widget.userDivision && user == null) {
    //   return renderNoPartner();
    // }
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Todo 유저면 사진 변경 가능, 파트너면 파트너 정보 상세보기
            if (userDivision) {
              showDialog(
                context: context,
                builder: (_) {
                  return ImagePopup(
                    onImageUploadComplete: handleImageUploadComplete,
                  );
                },
              );
            }
          },
          child: renderAvatar(user),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
        if (user != null)
          TextButton(
            child: Text(user.userNm),
            onPressed: () {},
          ),
        if (user == null)
          TextButton(
            child: Text('파트너 찾기'),
            onPressed: () {},
          ),
      ],
    );
  }

  void handleImageUploadComplete() async {
    await ref.read(userProvider.notifier).getMe(); // 유저 정보 새로고침
    setState(() {});
  }

  CustomCircleAvatar renderAvatar(UserModel? user) {
    if (user != null) {
      return CustomCircleAvatar(
        // 너비의 1/5 반지름
        radius: 80,
        defaultAssetUrl: 'assets/img/user/my_profile.jpeg',
        networkImgUrl: user.userImgUrl,
      );
    } else {
      return CustomCircleAvatar(
        // 너비의 1/5 반지름
        radius: 80,
      );
    }
  }

  Widget renderNoPartner() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Column(
        children: [Text('data')],
      ),
    );
  }
}
