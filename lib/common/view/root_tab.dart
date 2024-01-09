import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wepick/product/component/products_dropdown_button.dart';
import 'package:wepick/review/view/review_create_screen.dart';
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
  Widget? leadingButton;
  String selectedClass = '';
  // int index = 1;
  // late --> initState 과정에서 값이 주입
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(tabListener);
    selectedClass = '';
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
      leadingButton: leadingButton,
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
            label: '리뷰',
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
          const ReviewScreen(),
          const MyWedingScreen(),
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
        leadingButton = null;
      } else if (index == 1) {
        title = '달력';
        leadingButton = null;
      } else if (index == 2) {
        title = '리뷰';
        leadingButton = writeReviewButton();
      } else if (index == 3) {
        title = '마이위딩';
        leadingButton = null;
      } else {
        title = '위딩';
      }
    });
  }

  Widget writeReviewButton() {
    return const ProductsDropdownButton();
    // return DropdownButton(
    //   // isExpanded: true,
    //   icon: const Icon(Icons.edit),
    //   underline: const SizedBox.shrink(),
    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //   borderRadius: BorderRadius.circular(16.0),
    //   style: const TextStyle(color: PRIMARY_COLOR),
    //   value: selectedClass,
    //   onChanged: (String? value) {
    //     if (value != null) {
    //       setState(() {
    //         selectedClass = value;
    //       });
    //     }
    //   },
    //   items: classes.map(
    //     (String e) {
    //       return DropdownMenuItem<String>(
    //         value: e,
    //         child: Text(
    //           e,
    //           // style: TextStyle(fontSize: 8.0),
    //         ),
    //       );
    //     },
    //   ).toList(),
    // );
    // return IconButton(
    //     onPressed: () {
    //       context.pushNamed(ReviewCreateScreen.routeName);
    //     },
    //     icon: const Icon(Icons.edit_outlined));
  }
}
