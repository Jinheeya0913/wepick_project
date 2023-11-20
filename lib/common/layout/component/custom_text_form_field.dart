import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final FormFieldValidator? validator;
  final bool obscureText;
  final bool autoFocus;
  final ValueChanged<String>? onChanged;
  final int? maxLength;

  const CustomTextFormField({
    @required this.onChanged,
    this.maxLength,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autoFocus = false,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // 테두리 입력
    const baseBorder = OutlineInputBorder(
        borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1.0));

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      obscureText: obscureText,
      autofocus: autoFocus,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14.0,
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
