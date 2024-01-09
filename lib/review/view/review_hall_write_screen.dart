import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/common/layout/custom/text/custom_text_form_field.dart';
import 'package:wepick/common/layout/default_layout.dart';
import 'package:wepick/product/view/search_hall_screen.dart';
import 'package:wepick/product/view/search_place_screen.dart';

class ReviewWriteHallScreen extends StatefulWidget {
  static get routeName => 'reviewWriteHall';
  const ReviewWriteHallScreen({Key? key}) : super(key: key);

  @override
  State<ReviewWriteHallScreen> createState() => _ReviewWriteHallScreenState();
}

class _ReviewWriteHallScreenState extends State<ReviewWriteHallScreen> {
  Object? hallInfo;
  int? placeCd;
  String placeNm = '';
  String hallNm = '';
  bool comptSearchPlace = false;
  bool comptSearchHall = false;
  double? transRating;
  double? banquetRating;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '리뷰 작성',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            // Step 1 식장 검색
            renderSearchPlaceButton(),
            // Step 2 홀이름 검색
            Visibility(
              visible: comptSearchPlace,
              child: renderSearchHallButton(),
            ),
            // Step 3 리뷰 작성
            const Divider(),
            Visibility(
              visible: comptSearchHall && comptSearchPlace,
              child: Column(
                children: [
                  Column(
                    children: [
                      Center(
                        child: Text('교통편'),
                      ),
                      RatingBar.builder(
                        allowHalfRating: true,
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {
                          setState(() {
                            transRating = rating;
                          });
                        },
                      ),
                      Text(transRating.toString()),
                    ],
                  ),
                  CustomTextFormField(
                    hintText: '제목을 입력해주세요',
                    contentPadding: 10.0,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderSearchPlaceButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '식장 이름',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () async {
            // Todo  변경 필요
            final result = await context.pushNamed(SearchPlaceScreen.routeName);
            setState(() {
              if (result != null) {
                placeNm = result.toString();
                // 임시 하드코딩
                placeCd = 1;
                comptSearchPlace = true;
              } else {
                placeNm = '';
                hallNm = '';
                comptSearchPlace = false;
              }
            });
          },
          child: placeNm.isNotEmpty ? Text(placeNm) : const Text('웨딩홀을 검색해주세요'),
        ),
      ],
    );
  }

  Widget renderSearchHallButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '홀 이름',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () async {
            if (placeNm.isEmpty) {
              return;
            }
            final resp = await context.pushNamed(
              SearchHallScreen.routeName,
              pathParameters: {"placeName": placeNm},
            );

            if (resp != null) {
              setState(() {
                hallNm = resp.toString();
                comptSearchHall = true;
              });
            } else {
              hallNm = '';
              // 임시
              comptSearchHall = false;
            }
          },
          child: hallNm.isNotEmpty ? Text(hallNm) : const Text('홀 이름을 검색해주세요'),
        ),
      ],
    );
  }
}
