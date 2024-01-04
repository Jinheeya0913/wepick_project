import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/article/view/hall_search_screen.dart';
import 'package:wepick/article/view/place_search_screen.dart';
import 'package:wepick/common/const/colors.dart';
import 'package:wepick/common/layout/custom/custom_alert_pop.dart';
import 'package:wepick/common/layout/custom/text/custom_text_form_field.dart';
import 'package:wepick/common/layout/custom/text/rowInputTextWithTitle.dart';
import 'package:wepick/common/utils/datetimeUtil.dart';

class HallWriteLayout extends StatefulWidget {
  const HallWriteLayout({Key? key}) : super(key: key);

  @override
  State<HallWriteLayout> createState() => _HallWriteLayoutState();
}

enum Beverage { INCLUDE, EXCLUDE }

class _HallWriteLayoutState extends State<HallWriteLayout> {
  String placeName = '';
  String hallName = '';
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
              physics: BouncingScrollPhysics(),
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
                          final result = await context
                              .pushNamed(PlaceSearchScreen.routeName);
                          setState(() {
                            // 변경 필요
                            if (result != null) {
                              placeName = result.toString();
                              stepOne = true;
                            } else {
                              placeName = '';
                              hallName = '';

                              // 임시
                              stepOne = false;
                            }
                          });
                        },
                        child: placeName.isNotEmpty
                            ? Text(placeName)
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
                            if (placeName.isEmpty) {
                              return;
                            }
                            final resp = await context.pushNamed(
                              HallSearchScreen.routeName,
                              pathParameters: {"placeName": placeName},
                            );

                            if (resp != null) {
                              setState(() {
                                hallName = resp.toString();
                                stepTwo = true;
                              });
                            } else {
                              hallName = '';
                              // 임시
                              stepTwo = false;
                            }
                          },
                          child: hallName.isNotEmpty
                              ? Text(hallName)
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
                                          bookingDate =
                                              DateTimeUtil.dateTimeToOnlyDate(
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
                              Divider(),
                              Row(
                                children: [
                                  const Text(
                                    '후기',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 16.0),
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
                      return CustomSimpleAlertPop(title: 'title');
                    });
              }
              print('result >> $placeName');
              print('result >> $bookingTime');
              print('result >> $bookingDate');
              print('result >> $rentalFee');
              print('result >> $foodFee');
              print('result >> $selectedBeverage');
              print('result >> $guaranteedPrsnl');
              print('result >> $memo');

              print(bookingTime!.hour);
              print(bookingTime!.minute);
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
}
