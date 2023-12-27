import 'package:flutter/material.dart';
import 'package:wepick/common/layout/custom/text/custom_text_con_alll_ln.dart';
import 'package:wepick/common/layout/custom/text/custom_text_form_field.dart';
import 'package:wepick/common/layout/default_layout.dart';

class HallSearchScreen extends StatefulWidget {
  static get routeName => 'hallSearchScreen';
  const HallSearchScreen({Key? key}) : super(key: key);

  @override
  State<HallSearchScreen> createState() => _HallSearchScreenState();
}

class _HallSearchScreenState extends State<HallSearchScreen> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  List<String> itemContents = [
    'Item 1 Contents',
    'Item 2 Contents',
    'Item 3 Contents',
    'Item 4 Contents'
  ];

  List<String> searchResults = [];
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '웨딩홀 검색',
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              // 검색창 Row
              children: [
                Expanded(
                  child: SearchBar(
                    onChanged: (value) {
                      print(value);
                      searchString = value;
                      filterItems();
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final selectedItem = searchResults[index];
                  return InkWell(
                    onTap: () {
                      print(index);
                    },
                    child: ListTile(
                      leading: Icon(Icons.arrow_right),
                      title: Text(selectedItem),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void filterItems() {
    if (searchString.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    setState(() {
      searchResults = items
          .where(
              (item) => item.toLowerCase().contains(searchString.toLowerCase()))
          .toList();
    });
  }
}
