import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReviewTab extends StatelessWidget {
  const ReviewTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.building),
          label: Text('예식장'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const FaIcon(FontAwesomeIcons.heart),
          label: Text('예식장'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.celebration),
          label: Text('예식장'),
        ),
      ],
    );
  }
}
