import 'package:flutter/material.dart';
import 'package:wagle_front/class/class.dart';
import 'package:wagle_front/main.dart';

class MyPage extends StatelessWidget {
  MyPage({super.key});

  final Users user = Users('asdf@gmail.com', '임명우', '123456789');
  final String imoge = '1';

  final List<PopupMenuItem> items = [
    PopupMenuItem(
      child: Text(
        "\u{1f601}",
        style: TextStyle(fontSize: 30),
      ),
      value: '1',
    ),
    PopupMenuItem(
      child: Text(
        "\u{1f60A}",
        style: TextStyle(fontSize: 30),
      ),
      value: '2',
    ),
    PopupMenuItem(
      child: Text(
        "\u{1f60D}",
        style: TextStyle(fontSize: 30),
      ),
      value: '3',
    ),
    PopupMenuItem(
      child: Text(
        "\u{1f60F}",
        style: TextStyle(fontSize: 30),
      ),
      value: '4',
    ),
    PopupMenuItem(
      child: Text(
        "\u{1f62A}",
        style: TextStyle(fontSize: 30),
      ),
      value: '5',
    ),
    PopupMenuItem(
      child: Text(
        "\u{1f62A}",
        style: TextStyle(fontSize: 30),
      ),
      value: '6',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        showPopupMenu(context);
                      },
                      child: Text(
                        "\u{1f60e}",
                        style: TextStyle(fontSize: 60),
                      ),
                    ),
                    Text(
                      user.name,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "핫한 게시글",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showPopupMenu(BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final Offset offset = Offset.zero;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          offset.dx, offset.dy, overlay.size.width, overlay.size.height),
      items: items,
      elevation: 8.0,
    ).then((value) {
      if (value != null) {
        // 팝업 메뉴에서 선택한 값(value)에 따라 원하는 작업을 수행
        print('선택한 메뉴: $value');
      }
    });
  }
}
