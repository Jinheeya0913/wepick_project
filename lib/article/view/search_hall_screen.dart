import 'package:flutter/material.dart';
import 'package:wepick/common/layout/default_layout.dart';

class SearchHallScreen extends StatefulWidget {
  static get routeName => 'hallSearch';
  final String? placeName;
  const SearchHallScreen({
    Key? key,
    required this.placeName,
  }) : super(key: key);

  @override
  State<SearchHallScreen> createState() => _SearchHallScreenState();
}

class _SearchHallScreenState extends State<SearchHallScreen> {
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
      leadingButton: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.keyboard_arrow_left),
      ),
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
                    leading: const Icon(Icons.search_outlined),
                    onChanged: (value) {
                      searchString = value;
                      filterItems();
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: searchResults.length != 0
                  ? ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final selectedItem = searchResults[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pop(selectedItem);
                          },
                          child: ListTile(
                            leading: Icon(Icons.arrow_right),
                            title: Text(selectedItem),
                          ),
                        );
                      },
                    )
                  : searchString.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context).pop(searchString);
                          },
                          child: ListTile(
                            leading: Icon(Icons.arrow_right),
                            title: Text(searchString),
                          ),
                        )
                      : Container(),
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
