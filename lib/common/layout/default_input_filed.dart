import 'package:flutter/material.dart';

import '../component/text/custom_textinput_form.dart';

class DefaultInputField extends StatelessWidget {
  final String subtitle;
  final int? maxLength;

  const DefaultInputField({
    required this.subtitle,
    this.maxLength,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('data'),
          TextFormField(
            onChanged: (value) => print(value),
            decoration: InputDecoration(
              fillColor: Colors.pinkAccent,
            ),
          ),
          CustomTextFormField(
            contentPadding: 10,
            onChanged: (value) {
              print(value);
            },
          ),
        ],
      ),
    );
  }
}
