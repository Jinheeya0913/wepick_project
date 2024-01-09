import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/common/component/custom_rating_bar.dart';
import 'package:wepick/common/component/text/custom_textinput_form.dart';
import 'package:wepick/common/layout/default_layout.dart';
import 'package:wepick/product/view/search_hall_screen.dart';
import 'package:wepick/product/view/search_place_screen.dart';
import 'package:wepick/common/component/popup/custom_image_select_popup.dart';

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
  bool comptSelectPics = false;

  IconData ratingIcon = Icons.star;

  // 초기화
  double initRating = 3.0;
  double? transRating;
  double? banquetRating;
  double? serviceRating;
  double? visitorRating;
  double textContentPadding = 10.0;
  int maxTextContentLength = 300;
  int maxTextContentLines = 10;

  String reviewTitle = '';
  String reviewContent = '';

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '리뷰 작성',
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      // 제목 입력
                      CustomTextFormField(
                        hintText: '제목을 입력해주세요',
                        contentPadding: textContentPadding,
                        onChanged: (value) {
                          setState(() {
                            reviewTitle = value;
                          });
                        },
                      ),
                      // 내용 입력
                      CustomTextFormField(
                        hintText: '후기를 입력해주세요',
                        contentPadding: textContentPadding,
                        maxLength: maxTextContentLength,
                        maxLines: maxTextContentLines,
                        onChanged: (val) {
                          setState(() {
                            reviewContent = val;
                          });
                        },
                      ),
                      // 내용 글자수
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              '글자수(${reviewContent.length}/$maxTextContentLength)')
                        ],
                      ),

                      Visibility(
                        visible: comptSelectPics,
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              color: Colors.black,
                              child: Text(''),
                            ),
                            VerticalDivider(),
                            Container(
                              width: 50,
                              color: Colors.black,
                              child: Text(''),
                            ),
                            VerticalDivider(),
                            Container(
                              width: 50,
                              color: Colors.black,
                              child: Text(''),
                            ),
                            VerticalDivider(),
                            Container(
                              width: 50,
                              color: Colors.black,
                              child: Text(''),
                            ),
                            VerticalDivider(),
                          ],
                        ),
                      ),
                      // 이미지 업로드 버튼
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: const Text('이미지 업로드'),
                              onPressed: () {
                                showImagePopup();
                                setState(() {
                                  comptSelectPics = !comptSelectPics;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      // 점수
                      renderRatingCardCol(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column renderRatingCardCol() {
    return Column(
      children: [
        CustomRatingCard(
          initRating: initRating,
          title: const Text("교통편"),
          onRatingUpdate: (val) {
            setState(() {
              transRating = val;
              print(transRating);
            });
          },
          iconData: ratingIcon,
        ),
        SizedBox(height: 16.0),
        CustomRatingCard(
          initRating: initRating,
          title: const Text('연회장'),
          onRatingUpdate: (rating) {
            setState(() {
              banquetRating = rating;
            });
          },
          iconData: ratingIcon,
        ),
        SizedBox(height: 16.0),
        CustomRatingCard(
          initRating: initRating,
          title: const Text('서비스'),
          onRatingUpdate: (rating) {
            setState(() {
              serviceRating = rating;
            });
          },
          iconData: ratingIcon,
        ),
        SizedBox(height: 16.0),
        CustomRatingCard(
          initRating: initRating,
          title: const Text('하객만족'),
          onRatingUpdate: (rating) {
            setState(() {
              visitorRating = rating;
            });
          },
          iconData: ratingIcon,
        ),
      ],
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

  void showImagePopup() {
    showGeneralDialog(
      context: context,
      transitionBuilder: (_, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: ImageSelectPopup(
            onImageUploadComplete: () {},
            // networkImgUrl: ,
          ),
        );
      },
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
    );
  }
}
