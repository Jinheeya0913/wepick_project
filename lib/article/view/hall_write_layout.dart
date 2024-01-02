import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/article/view/place_search_screen.dart';
import 'package:wepick/common/layout/custom/text/custom_text_form_field.dart';

class HallWriteLayout extends StatefulWidget {
  const HallWriteLayout({Key? key}) : super(key: key);

  @override
  State<HallWriteLayout> createState() => _HallWriteLayoutState();
}

class _HallWriteLayoutState extends State<HallWriteLayout> {
  String placeName = '';
  String hallName = '';
  bool isVisible = false;

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
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '웨딩홀 이름',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await context
                            .pushNamed(PlaceSearchScreen.routeName);
                        setState(() {
                          // 변경 필요
                          if (result != null) {
                            placeName = result.toString();
                            isVisible = true;
                          } else {
                            placeName = '';
                            hallName = '';
                          }
                        });
                      },
                      child: placeName.isNotEmpty
                          ? Text(placeName)
                          : const Text('웨딩홀을 검색해주세요'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Visibility(
                  visible: isVisible,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '홀 이름',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (placeName.isEmpty) {
                            print('먼저 웨딩홀을 검색해주세요');
                            return;
                          }
                        },
                        child: hallName.isNotEmpty
                            ? Text(hallName)
                            : const Text('홀 이름을 검색해주세요'),
                      ),
                    ],
                  ),
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
