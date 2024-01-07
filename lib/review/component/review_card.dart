// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '서울 중구 최고의 웨딩홀!',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  ],
                ),
                Text('Heeya')
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'PJ호텔',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(width: 8.0),
                    Text('서울', style: TextStyle(color: Colors.grey))
                  ],
                ),
                Text(
                  '★★★★★',
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'assets/img/hall/hestia.png',
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('교통'), Text('1점')],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('연회장'), Text('1점')],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('서비스'), Text('1점')],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('하객 만족'), Text('1점')],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.arrow_right_outlined),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                '자세히 보기',
                                style: TextStyle(color: Colors.grey),
                              ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('버튼1'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('버튼2'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4.0,
            ),
          ],
        ),
      ),
    );
  }
}
