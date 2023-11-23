import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/common/view/test/test_default_layout.dart';
import '../../const/colors.dart';

class TestDrawerTab extends ConsumerStatefulWidget {
  static String get routeName => 'testhome';

  const TestDrawerTab({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  ConsumerState<TestDrawerTab> createState() => _TestDrawerTab();
}

class _TestDrawerTab extends ConsumerState<TestDrawerTab>
    with SingleTickerProviderStateMixin {
  int index = 0;
  // int index = 1;
  // late --> initState 과정에서 값이 주입
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(tabListener);
  }

  @override
  void dispose() {
    tabController.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TestDefaultLayout(
      title: '위픽',
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.shifting,
        onTap: (int index) {
          tabController.animateTo(index);
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month_outlined,
            ),
            label: '달력',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.receipt_long_outlined,
            ),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
            ),
            label: '파트너',
          ),
        ],
      ),
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          Center(
            child: Container(
              child: const Text('data'),
            ),
          ),
          Center(
            child: Container(
              child: const Text('data2'),
            ),
          ),
          Center(
            child: Container(
              // 임시적으로
              child: const Text('data3'),
            ),
          ),
          Center(
            child: Container(
              // 임시적으로
              child: const Text('data4'),
            ),
          ),
        ],
      ),

      /*Image.asset(
        'assets/img/logo/logo.png',
        width: MediaQuery.of(context).size.width / 2,
        color: Colors.purple,
      ),*/
    );
  }

  void tabListener() {
    setState(() {
      index = tabController.index;
    });
  }
}
