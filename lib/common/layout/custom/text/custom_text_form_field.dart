import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final FormFieldValidator? validator;
  final bool obscureText;
  final bool autoFocus;
  final double circleBorder;
  final bool digitOnly;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final double? hintSize;
  final double? contentPadding;
  final bool filled;
  final Color borderColor;
  final bool useBorder;
  final int? maxLines;
  final double borderWidth;
  final Color? cursorColor;
  final String? lavelText;

  const CustomTextFormField({
    @required this.onChanged,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autoFocus = false,
    this.digitOnly = false,
    this.validator,
    this.maxLength,
    this.hintSize,
    this.contentPadding,
    this.circleBorder = 16.0,
    this.borderWidth = 1,
    this.filled = true,
    this.borderColor = INPUT_BORDER_COLOR,
    this.useBorder = true,
    this.maxLines = 1,
    this.cursorColor = PRIMARY_COLOR,
    this.lavelText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // 테두리 입력
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor,
        width: borderWidth,
      ),
      borderRadius: BorderRadius.all(Radius.circular(circleBorder)),
    );

    final unVisibleBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor,
        width: borderWidth,
      ),
    );

    return TextFormField(
      inputFormatters: [if (digitOnly) FilteringTextInputFormatter.digitsOnly],
      maxLength: maxLength == null ? null : maxLength,
      cursorColor: cursorColor,
      obscureText: obscureText,
      autofocus: autoFocus,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        counter: Offstage(),
        contentPadding: contentPadding != null
            ? EdgeInsets.all(contentPadding!)
            : const EdgeInsets.all(20),
        hintText: hintText,
        hintStyle: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: hintSize ?? 14.0,
        ),
        errorText: errorText,
        fillColor: INPUT_BG_COLOR,

        // 배경색 있음
        filled: filled,
        border: useBorder ? baseBorder : null,
        // 선택되지 않은 상태에서의 볼더 설정
        enabledBorder: useBorder ? baseBorder : unVisibleBorder,

        // copywith : 선택된 값에 대한 모든 속성을 복사
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: cursorColor,
          ),
        ),

        // 텍스트필드 over 제목
        labelText: lavelText,
      ),
    );
  }
}
