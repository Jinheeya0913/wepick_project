// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:wepick/common/layout/custom/button/custom_circle_icon_text_button.dart';
//
// class ReviewTab extends StatelessWidget {
//   const ReviewTab({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     late int index;
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         CustomIconRadioButton(
//           onPressed: () {
//             index = 0;
//             activateButton(index);
//           },
//           inputText: Text('예식장'),
//           inputIcon: FontAwesomeIcons.building,
//           focusedIndex: 0,
//         ),
//         CustomIconRadioButton(
//           onPressed: () {
//             index = 1;
//             activateButton(index);
//           },
//           inputText: Text('input'),
//           inputIcon: Icons.add,
//           focusedIndex: 1,
//         ),
//         CustomIconRadioButton(
//           onPressed: () {
//             index = 2;
//             activateButton(index);
//           },
//           inputText: Text('예물'),
//           inputIcon: Icons.add,
//           focusedIndex: 2,
//         ),
//         Container(
//           // 작성폼
//           child: Text('작성폼'),
//         ),
//       ],
//     );
//   }
//
//   void activateButton(int index) {}
// }
