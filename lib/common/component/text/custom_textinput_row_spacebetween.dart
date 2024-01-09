import 'package:flutter/material.dart';

import 'custom_textinput_form.dart';

class RowInputTextWithTitle extends StatelessWidget {
  final String title;
  final ValueChanged<String>? onChanged;
  final String? unit;
  final bool digitOnly;

  const RowInputTextWithTitle({
    Key? key,
    required this.title,
    this.onChanged,
    this.unit,
    this.digitOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: CustomTextFormField(
                contentPadding: 8.0,
                onChanged: onChanged,
                digitOnly: digitOnly,
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            if (unit != null) const Text('원'),
          ],
        ),
      ],
    );
  }
}
