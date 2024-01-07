import 'package:flutter/material.dart';
import 'package:wepick/common/const/colors.dart';

class WedingMenu extends StatefulWidget {
  const WedingMenu({Key? key}) : super(key: key);

  @override
  State<WedingMenu> createState() => _WedingMenuState();
}

class _WedingMenuState extends State<WedingMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 견적
        GestureDetector(
            onTap: () {}, child: renderMenuItem(Icons.person_rounded, '내 정보 ')),
        GestureDetector(
            onTap: () {},
            child: renderMenuItem(Icons.people_alt_rounded, '파트너 정보 ')),
        GestureDetector(
            onTap: () {}, child: renderMenuItem(Icons.favorite, '위시리스트')),
        GestureDetector(
            onTap: () {},
            child: renderMenuItem(Icons.article_outlined, '리뷰 작성')),
        GestureDetector(
            onTap: () {},
            child: renderMenuItem(Icons.receipt_long_rounded, '내 견적 ')),
        GestureDetector(
            onTap: () {}, child: renderMenuItem(Icons.article_outlined, '견적 ')),
        GestureDetector(
            onTap: () {}, child: renderMenuItem(Icons.article_outlined, '견적 ')),
      ],
    );
  }

  Padding renderMenuItem(IconData iconData, String itemName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 56,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Icon(
                iconData,
                color: PRIMARY_COLOR,
                size: 28,
              ),
              const SizedBox(
                width: 28,
              ),
              Text(
                itemName,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
