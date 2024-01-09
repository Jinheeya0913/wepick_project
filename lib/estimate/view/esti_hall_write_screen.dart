import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/estimate/model/hall_estimate_model.dart';
import 'package:wepick/product/model/place_model.dart';
import 'package:wepick/estimate/provider/estimate_provider.dart';
import 'package:wepick/product/view/search_hall_screen.dart';
import 'package:wepick/product/view/search_place_screen.dart';
import 'package:wepick/common/const/colors.dart';
import 'package:wepick/common/layout/custom/custom_alert_pop.dart';
import 'package:wepick/common/layout/custom/text/custom_text_form_field.dart';
import 'package:wepick/common/layout/custom/text/rowInputTextWithTitle.dart';
import 'package:wepick/common/utils/datetimeUtil.dart';

import '../../common/view/root_tab.dart';

class EstimateHallWriteScreen extends ConsumerStatefulWidget {
  const EstimateHallWriteScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EstimateHallWriteScreen> createState() =>
      _EstimateHallWriteScreenState();
}

enum Beverage { INCLUDE, EXCLUDE }

class _EstimateHallWriteScreenState
    extends ConsumerState<EstimateHallWriteScreen> {
  int? placeCd;
  String placeNm = '';
  String hallNm = '';
  TimeOfDay? bookingTime;
  String? bookingDate;

  // 대관료
  int? rentalFee;
  // 식비
  int? foodFee;
  // 보증인원
  int? guaranteedPrsnl;

  String memo = '';

  // Todo 임시로 모두 True, default : false
  bool stepOne = false;
  bool stepTwo = false;
  bool stepThree = false;
  bool stepFour = false;
  bool stepFive = false;

  // RadioButton Enum
  Beverage? selectedBeverage;

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(estimateProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(16),
      // decoration: BoxDecoration(
      //     border: Border.all(color: Colors.grey),
      //     borderRadius: BorderRadius.circular(8),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '식장 이름',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Todo  변경 필요
                          final result = await context
                              .pushNamed(SearchPlaceScreen.routeName);
                          setState(() {
                            if (result != null) {
                              placeNm = result.toString();
                              // 임시 하드코딩
                              placeCd = 1;
                              stepOne = true;
                            } else {
                              placeNm = '';
                              hallNm = '';

                              // 임시
                              stepOne = false;
                            }
                          });
                        },
                        child: placeNm.isNotEmpty
                            ? Text(placeNm)
                            : const Text('웨딩홀을 검색해주세요'),
                      ),
                    ],
                  ),
                  // Step 1
                  Visibility(
                    visible: stepOne,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '홀 이름',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
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
                                stepTwo = true;
                              });
                            } else {
                              hallNm = '';
                              // 임시
                              stepTwo = false;
                            }
                          },
                          child: hallNm.isNotEmpty
                              ? Text(hallNm)
                              : const Text('홀 이름을 검색해주세요'),
                        ),
                      ],
                    ),
                  ),
                  // Step 2
                  Visibility(
                    visible: stepTwo,
                    child: Column(
                      children: [
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '예식 일시',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: ElevatedButton.icon(
                                    label: Text(
                                      bookingDate != null
                                          ? bookingDate.toString()
                                          : '날짜선택',
                                      style: const TextStyle(
                                        fontSize: 11.0,
                                      ),
                                    ),
                                    icon: const Icon(
                                        Icons.calendar_month_outlined),
                                    onPressed: () async {
                                      final selectedDate = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(
                                              DateTime.now().year + 2));
                                      if (selectedDate != null) {
                                        setState(() {
                                          bookingDate = DateTimeUtil
                                              .dateTimeToOnlyDateString(
                                                  selectedDate);
                                          stepThree = true;
                                        });
                                      } else {
                                        stepThree = false;
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                SizedBox(
                                  width: 150,
                                  child: ElevatedButton.icon(
                                    label: Text(
                                      bookingTime != null
                                          ? bookingTime!
                                              .format(context)
                                              .toString()
                                          : '시간선택',
                                      style: const TextStyle(
                                        fontSize: 11.0,
                                      ),
                                    ),
                                    icon:
                                        const Icon(Icons.watch_later_outlined),
                                    onPressed: () async {
                                      final selectedTime = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          builder: (context, Widget? child) {
                                            return MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                      alwaysUse24HourFormat:
                                                          false),
                                              child: child!,
                                            );
                                          });
                                      if (selectedTime != null) {
                                        setState(() {
                                          bookingTime = selectedTime;
                                          stepFour = true;
                                        });
                                      } else {
                                        stepFour = false;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Step 3
                  Visibility(
                    visible: stepFour && stepThree,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Divider(),
                        RowInputTextWithTitle(
                          title: '대관료',
                          unit: '원',
                          digitOnly: true,
                          onChanged: (value) {
                            setState(() {
                              rentalFee = int.parse(value);
                              checkOptionsStep();
                            });
                          },
                        ),
                        RowInputTextWithTitle(
                          title: '식비',
                          unit: '원',
                          digitOnly: true,
                          onChanged: (value) {
                            foodFee = int.parse(value);
                            checkOptionsStep();
                          },
                        ),
                        RowInputTextWithTitle(
                          title: '보증인원',
                          unit: '명',
                          digitOnly: true,
                          onChanged: (value) {
                            guaranteedPrsnl = int.parse(value);
                            checkOptionsStep();
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 60.0),
                              child: Text(
                                '음주/음료',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: ListTileTheme(
                                contentPadding: EdgeInsets.zero,
                                child: Column(
                                  children: [
                                    RadioListTile(
                                      title: const Text(
                                        '포함',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(),
                                      ),
                                      value: Beverage.INCLUDE,
                                      groupValue: selectedBeverage,
                                      onChanged: (Beverage? value) {
                                        setState(() {
                                          selectedBeverage = value;
                                          checkOptionsStep();
                                        });
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                    RadioListTile(
                                      title: const Text(
                                        '미포함',
                                        textAlign: TextAlign.right,
                                      ),
                                      value: Beverage.EXCLUDE,
                                      groupValue: selectedBeverage,
                                      onChanged: (Beverage? value) {
                                        setState(() {
                                          selectedBeverage = value;
                                        });
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: stepFour,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Divider(),
                              Row(
                                children: [
                                  const Text(
                                    '후기',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Text(
                                    '${memo.length}/200',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                              CustomTextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    memo = val;
                                  });
                                },
                                maxLines: 2,
                                maxLength: 200,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 작성완료 버튼
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: stepFive ? PRIMARY_COLOR : Colors.grey,
            ),
            onPressed: () async {
              if (!stepFive) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CustomSimpleAlertPop(title: '견적을 먼저 완성해주세요');
                    });
                return;
              }

              String convertedTime =
                  DateTimeUtil.timeOfDayTo24HourString(bookingTime!);

              HallEstimateModel model = HallEstimateModel(
                rentalFee: rentalFee!,
                bookingTime: convertedTime,
                bookingDate: bookingDate!,
                foodFee: foodFee!,
                guaranteedPrsnl: guaranteedPrsnl!,
                memo: memo,
                placeInfo: PlaceModel(placeCd: 1),
                hallNm: hallNm,
              );
              final resp =
                  await provider.writeHallEstimate(hallEstimateModel: model);

              if (resp != null) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const CustomSimpleAlertPop(
                      title: '업로드 실패',
                      content: '잠시 후 다시 시도 바랍니다.',
                    );
                  },
                );
              } else {
                final result = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('업로드 성공'),
                      content: Text('게시물 작성 성공하였습니다.'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            context.pushNamed(RootTab.routeName);
                            _resetForm();
                          },
                          child: Text('돌아가기'),
                        ),
                      ],
                    );
                  },
                );
                context.pushNamed(RootTab.routeName);
              }
            },
            child: const Text(
              '작성 완료',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkOptionsStep() {
    if (foodFee != null &&
        rentalFee != null &&
        guaranteedPrsnl != null &&
        selectedBeverage != null) {
      setState(() {
        stepFive = true;
      });
    } else {
      if (stepFive) {
        setState(() {
          stepFive = false;
        });
      }
    }
  }

  void _resetForm() {
    setState(() {
      placeCd = null;
      placeNm = '';
      hallNm = '';
      bookingTime = null;
      bookingDate = null;
      rentalFee = null;
      foodFee = null;
      guaranteedPrsnl = null;
      memo = '';
      stepOne = false;
      stepTwo = false;
      stepThree = false;
      stepFour = false;
      stepFive = false;
      selectedBeverage = null;
    });
  }
}
