import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/user/provider/user_provider.dart';
import '../const/colors.dart';
import '../layout/default_layout.dart';

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'home';

  const RootTab({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab>
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
  }

  @override
  Widget build(BuildContext context) {
    print('[root_tab] >> 이동 ');
    return DefaultLayout(
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
              Icons.menu_book_outlined,
            ),
            label: '메뉴',
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
