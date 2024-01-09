import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/component/custom_circleAvatar.dart';

import '../../common/component/popup/custom_image_select_popup.dart';
import '../model/user_model.dart';
import '../provider/user_provider.dart';

class UserSimpleCard extends ConsumerStatefulWidget {
  final UserModel? userModel;
  final bool userDivision;

  const UserSimpleCard({
    this.userModel,
    this.userDivision = true, // false : 파트너 정보
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<UserSimpleCard> createState() => _UserSimpleCardState();
}

class _UserSimpleCardState extends ConsumerState<UserSimpleCard> {
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
            if (userDivision) {
              showGeneralDialog(
                context: context,
                transitionBuilder: (_, a1, a2, widget) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
                    child: ImageSelectPopup(
                      onImageUploadComplete: handleImageUploadComplete,
                      networkImgUrl: user!.userImgUrl,
                    ),
                  );
                },
                pageBuilder: (context, animation1, animation2) {
                  return Container();
                },
              );
            }
          },
          child: renderAvatar(user),
        ),
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
