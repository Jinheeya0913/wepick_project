import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wepick/review/view/review_screen.dart';
import 'package:wepick/user/view/myweding_screen.dart';
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
  String title = '위딩';
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
    return DefaultLayout(
      automaticallyImplyLeading: false,
      title: title,
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
            label: '견적',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
            ),
            label: '마이위딩',
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
            child: EstimateListScreen(),
          ),
          Container(
            child: MyWedingScreen(),
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
      if (index == 0) {
        title = '홈';
      } else if (index == 1) {
        title = '달력';
      } else if (index == 2) {
        title = '견적';
      } else if (index == 3) {
        title = '마이위딩';
      } else {
        title = '위딩';
      }
    });
  }
}
