// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:wepick/common/const/colors.dart';

class EstimateListScreen extends StatefulWidget {
  const EstimateListScreen({Key? key}) : super(key: key);

  @override
  State<EstimateListScreen> createState() => _EstimateListScreenState();
}

class _EstimateListScreenState extends State<EstimateListScreen> {
  String selectedClasses = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              // 검색창
              child: renderSearchBar(),
            ),
          ],
        ),
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ListTile(
                      title: Text('Item ${index + 1}'),
                    );
                  },
                  childCount: 30,
                ),
              ),
            ],
          ),
        ),
        /**
         * 검색목록
         * Refresh
         *  SingleScrollView
         *  - SliverList
         *    - ResultCard
         *
         *
         *
         */
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedClasses = '종합';
    });
  }

  SearchBar renderSearchBar() {
    final classes = ['종합', '웨딩홀', '스드메', '예물'];

    return SearchBar(
      leading: DropdownButton(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        borderRadius: BorderRadius.circular(16.0),
        style: TextStyle(color: PRIMARY_COLOR),
        value: selectedClasses,
        onChanged: (String? value) {
          if (value != null) {
            setState(() {
              selectedClasses = value;
            });
          }
        },
        items: classes.map(
          (String e) {
            return DropdownMenuItem<String>(
              value: e,
              child: Text(
                e,
                // style: TextStyle(fontSize: 8.0),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
