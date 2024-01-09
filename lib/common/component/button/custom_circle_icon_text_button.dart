// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class CustomIconRadioButton extends StatefulWidget {
//   final VoidCallback onPressed;
//   final Text inputText;
//   final IconData inputIcon;
//   final double? fontSize;
//   final bool? activated;
//   final double? circleSize;
//   final int focusedIndex;
//
//   const CustomIconRadioButton({
//     Key? key,
//     required this.inputText,
//     required this.inputIcon,
//     required this.onPressed,
//     required this.focusedIndex,
//     this.fontSize,
//     this.activated = false,
//     this.circleSize = 60.0,
//   }) : super(key: key);
//
//   @override
//   State<CustomIconRadioButton> createState() => _CustomIconRadioButtonState();
// }
//
// class _CustomIconRadioButtonState extends State<CustomIconRadioButton> {
//   @override
//   Widget build(BuildContext context) {
//     final double opacityValue = widget.activated! ? 1.0 : 0.5;
//
//     return GestureDetector(
//       onTap: () {
//         widget.onPressed.call();
//       },
//       child: Container(
//         width: widget.circleSize,
//         height: widget.circleSize,
//         decoration: BoxDecoration(
//           // shape: BoxShape.circle,
//           border: Border.all(
//             color: Colors.black.withOpacity(opacityValue),
//             width: 2,
//           ),
//           borderRadius: BorderRadius.all(
//             Radius.circular(100.0),
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FaIcon(
//               widget.inputIcon,
//               color: Colors.black.withOpacity(opacityValue),
//             ),
//             Text(
//               widget.inputText.data ?? "",
//               style: TextStyle(
//                 color: Colors.black.withOpacity(opacityValue),
//                 fontSize: widget.fontSize,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
