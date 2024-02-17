import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wagle_front/main.dart';
import 'package:wagle_front/screen/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [FeedList()],
      ),
    );
  }
}

class FeedData {
  final String userName;
  final int likeCount;
  final String content;

  FeedData(
      {required this.userName, required this.likeCount, required this.content});
}

final feedDataList = [
  FeedData(
      userName: 'User1',
      likeCount: 50,
      content:
          '공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 공부하기 싫어 '),
  FeedData(userName: 'User2', likeCount: 23, content: '여행 갔다옴'),
  FeedData(userName: 'User2', likeCount: 65, content: '힐링하는 시간'),
  FeedData(userName: 'User3', likeCount: 73, content: '카공 좋아'),
  FeedData(userName: 'User3', likeCount: 662, content: '오늘의 아침..'),
  FeedData(userName: 'User4', likeCount: 221, content: '다이어트 힘들다'),
  FeedData(userName: 'User4', likeCount: 103, content: '야식 땡겨..'),
  FeedData(userName: 'User5', likeCount: 91, content: '우울하당'),
];

class FeedList extends StatelessWidget {
  const FeedList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: feedDataList.length,
        itemBuilder: (context, index) =>
            FeedItem(feedData: feedDataList[index]));
  }
}

class FeedItem extends StatelessWidget {
  final FeedData feedData;

  const FeedItem({required this.feedData, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: ratio.width * 8,
                  ),
                  Text(feedData.userName),
                ],
              ),
              IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bookmark)),
              // Icon(Icons.more_vert)  점점점 아이콘
            ],
          ),
        ),
        SizedBox(
          height: ratio.height * 8,
        ),
        Container(
          width: double.infinity,
          height: 280,
          color: Colors.indigo.shade300,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.favorite_outline)),
                  IconButton(
                      onPressed: () {}, icon: Icon(CupertinoIcons.chat_bubble)),
                  IconButton(
                      onPressed: () {}, icon: Icon(CupertinoIcons.paperplane)),
                ],
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
            child: Text('좋아요 ${feedData.likeCount}개')),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: feedData.userName + "  ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: feedData.content),
          ], style: TextStyle(color: Colors.black))),
        ),
        SizedBox(
          height: ratio.height * 8,
        )
      ],
    );
  }
}

class InstaCloneHome extends StatefulWidget {
  const InstaCloneHome({super.key});

  @override
  State<InstaCloneHome> createState() => _InstaCloneHomeState();
}

class _InstaCloneHomeState extends State<InstaCloneHome> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        '놀면서 살자',
      )),
      body: InstaBody(index: index),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (newindex) {
            setState(() {
              index = newindex;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 28,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.place,
                  size: 28,
                ),
                label: 'MapPage'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 28,
                ),
                label: 'MyPage'),
          ]),
    );
  }
}
