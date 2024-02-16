import 'package:flutter/material.dart';
import 'package:wagle_front/screen/map.dart';
import 'package:wagle_front/screen/mypage.dart';
import 'package:wagle_front/screen/home.dart';

class InstaBody extends StatelessWidget {
  final int index;

  const InstaBody({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return HomeScreen();
    } else if (index == 1) {
      return MapPage();
    }
    return MyPage();
  }
}
