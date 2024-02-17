import 'package:flutter/material.dart';
import 'package:wagle_front/Feed/view/feed_screen.dart';
import 'package:wagle_front/common/layout/default_layout.dart';
import 'package:wagle_front/common/view/splash_screen.dart';
import 'package:wagle_front/screen/map.dart';
import 'package:wagle_front/screen/mypage.dart';

import '../const/colors.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  int index = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '놀면서 살자',
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.shifting,
        onTap: (int index) {
          setState(() {
            this.index = index;
          });
          tabController.animateTo(this.index);
        },
        currentIndex: index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.feed_outlined), label: "Feed"),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: "Map"),
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "My"),
        ],
      ),
      child: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            FeedScreen(),
            MapPage(),
            MyPage(),
          ]),
    );
  }
}
