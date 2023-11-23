import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final FormFieldValidator? validator;
  final bool obscureText;
  final bool autoFocus;
  final bool circleBorder;
  final bool digitOnly;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final double? hintSize;
  final double? contentPadding;

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
    this.circleBorder = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // 테두리 입력
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1.0),
      borderRadius: circleBorder
          ? BorderRadius.all(Radius.circular(16.0))
          : const BorderRadius.all(Radius.circular(4.0)),
    );

    return TextFormField(
      inputFormatters: [if (digitOnly) FilteringTextInputFormatter.digitsOnly],
      maxLength: maxLength == null ? null : maxLength,
      cursorColor: PRIMARY_COLOR,
      obscureText: obscureText,
      autofocus: autoFocus,
      onChanged: onChanged,
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
        filled: true,
        border: baseBorder,
        // 선택되지 않은 상태에서의 볼더 설정
        enabledBorder: baseBorder,

        // copywith : 선택된 값에 대한 모든 속성을 복사
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }
}
