import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/article/view/hall_search_screen.dart';
import 'package:wepick/common/layout/custom/custom_alert_pop.dart';
import 'package:wepick/common/layout/custom/text/custom_text_form_field.dart';

class HallWriteLayout extends StatefulWidget {
  const HallWriteLayout({Key? key}) : super(key: key);

  @override
  State<HallWriteLayout> createState() => _HallWriteLayoutState();
}

class _HallWriteLayoutState extends State<HallWriteLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '웨딩홀명',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () async {
                    final result =
                        await context.pushNamed(HallSearchScreen.routeName);
                  },
                  child: Text('웨딩홀명을 검색하세요'),
                ),
              ],
            ),
          ),
          // 여기에 각 폼 필드를 추가하세요.
        ],
      ),
    );
  }
  //
  // Widget searchPopUp() {
  //   return AlertDialog(
  //     title: Text('웨딩홀 검색'),
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Text('data1'),
  //         SizedBox(
  //           height: 18.0,
  //         ),
  //         CustomTextFormField(
  //           onChanged: (value) {
  //             setState(() {
  //               searchString = value;
  //               filterItems();
  //             });
  //           },
  //           hintText: '홀 이름 입력',
  //         ),
  //         // 여기
  //         if (searchResults.isNotEmpty)
  //           Expanded(
  //             child: ListView.builder(
  //               itemCount: searchResults.length,
  //               itemBuilder: (context, index) {
  //                 return ListTile(
  //                   title: Text(searchResults[index]),
  //                 );
  //               },
  //             ),
  //           ),
  //         // Column(
  //         //   crossAxisAlignment: CrossAxisAlignment.center,
  //         //   children: [for (String result in searchResults) Text(result)],
  //         // ),
  //       ],
  //     ),
  //   );
  // }
}
