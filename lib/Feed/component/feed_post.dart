import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wagle_front/Feed/component/feed_comment.dart';
import 'package:wagle_front/Feed/model/feed_detail_model.dart';
import 'package:wagle_front/Feed/view/feed_comment_screen.dart';

import '../model/feed_comment_model.dart';
import '../repository/feed_repository.dart';

class FeedPost extends ConsumerStatefulWidget {
  final String courseId;
  final String postId;
  final String name;
  final String memberName;
  final String content;
  final int like;
  final List<String> imgUrl;

  const FeedPost(
      {super.key,
      required this.courseId,
      required this.postId,
      required this.name,
      required this.memberName,
      required this.content,
      required this.like,
      required this.imgUrl});

  factory FeedPost.fromJson({required FeedItemDetailModel model}) {
    return FeedPost(
      courseId: model.courseId,
      postId: model.postId,
      name: model.name,
      memberName: model.memberName,
      content: model.content,
      like: model.like,
      imgUrl: model.imgUrl,
    );
  }

  @override
  ConsumerState<FeedPost> createState() => _FeedPostState();
}

class _FeedPostState extends ConsumerState<FeedPost> {
  List<bool> isSelected = [false];
  bool recommend = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _renderLeading(width, widget.courseId),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.memberName,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.name,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.content,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        recommend = !recommend;
                      });
                    },
                    child: SizedBox(
                      width: 70,
                      height: 35,
                      // decoration: BoxDecoration(
                      //     border: Border.all(width: 1, color: Colors.grey),
                      //     borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(recommend
                              ? Icons.thumb_up
                              : Icons.thumb_up_alt_outlined),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(widget.like.toString()),
                        ],
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     //   {
                  //     //     'memberId': 123,
                  //     //   'postId': int.parse(postId),
                  //     //   'comment': '짱멋지다',
                  //     // }
                  //   },
                  //   child: const Icon(CupertinoIcons.chat_bubble),
                  // ),
                ],
              ),
              ToggleButtons(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                selectedBorderColor: Colors.blueGrey,
                selectedColor: Colors.white,
                fillColor: Colors.blueGrey,
                color: Colors.blueGrey,
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                children: [
                  Text(
                    "댓글 보기",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
                isSelected: isSelected,
                onPressed: (index) {
                  setState(() {
                    isSelected[index] = !isSelected[index];
                  });
                  FeedRepository.getComment(postId: widget.postId);
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        if (isSelected[0]) FeedCommentScreen(postId: widget.postId),
      ],
    );
  }
}

Widget _renderLeading(double width, String id) {
  return const Text(
    '\u{1f60D}',
    style: TextStyle(fontSize: 50),
  );
}

Widget _renderComment(List<FeedItemCommentModel> comments) {
  return ConstrainedBox(
    constraints: const BoxConstraints(
      minHeight: 50,
      maxHeight: 300,
    ),
    child: ListView.separated(
        itemBuilder: (context, index) {
          final item = comments[index];
          return FeedComment.fromJson(model: item);
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemCount: comments.length),
  );
}
