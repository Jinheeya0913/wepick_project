import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/const/colors.dart';

class ProductsDropdownButton extends StatelessWidget {
  const ProductsDropdownButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final classes = ['예식장', '스드메', '예물'];
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: const Icon(
          Icons.edit,
          color: PRIMARY_COLOR,
        ),
        items: [
          ..._MenuItems.firstItem.map(
            (item) => DropdownMenuItem<_MenuItem>(
              value: item,
              child: _MenuItems.buildItem(item),
            ),
          ),
          // const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
        ],
        onChanged: (value) {
          _MenuItems.onChanged(context, value!);
        },
        dropdownStyleData: DropdownStyleData(
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          offset: const Offset(0, 8),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }
}

class _MenuItem {
  final String text;
  final IconData icon;

  const _MenuItem({
    required this.text,
    required this.icon,
  });
}

abstract class _MenuItems {
  static const wedingHall =
      _MenuItem(text: '웨딩홀', icon: FontAwesomeIcons.building);

  static const package =
      _MenuItem(text: '스드매 페키지', icon: FontAwesomeIcons.gift);

  static const gift = _MenuItem(text: '예물', icon: FontAwesomeIcons.ring);

  static const List<_MenuItem> firstItem = [wedingHall, package, gift];

  static Widget buildItem(_MenuItem item) {
    return Row(
      children: [
        Icon(
          item.icon,
          color: PRIMARY_COLOR,
          size: 22,
        ),
        const SizedBox(width: 10),
        Expanded(
            child: Text(
          item.text,
          style: const TextStyle(color: Colors.black),
        ))
      ],
    );
  }

  static void onChanged(BuildContext context, _MenuItem item) {
    switch (item) {
      case _MenuItems.wedingHall:
        break;
      case _MenuItems.package:
        break;
      case _MenuItems.gift:
        break;
    }
  }
}
