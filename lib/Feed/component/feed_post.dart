import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wagle_front/Feed/component/feed_comment.dart';
import 'package:wagle_front/Feed/dummy/feed_comment_dummy.dart';
import 'package:wagle_front/Feed/model/feed_detail_model.dart';

import '../model/feed_comment_model.dart';

class FeedPost extends ConsumerStatefulWidget {
  final String courseId;
  final String postId;
  final String name;
  final String memberName;
  final String content;
  final int like;

  const FeedPost({
    super.key,
    required this.courseId,
    required this.postId,
    required this.name,
    required this.memberName,
    required this.content,
    required this.like,
  });

  factory FeedPost.fromJson({required FeedItemDetailModel model}) {
    return FeedPost(
      courseId: model.courseId,
      postId: model.postId,
      name: model.name,
      memberName: model.memberName,
      content: model.content,
      like: model.like,
    );
  }

  @override
  ConsumerState<FeedPost> createState() => _FeedPostState();
}

class _FeedPostState extends ConsumerState<FeedPost> {
  List<bool> isSelected = [false];

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
                    onTap: () {},
                    child: Container(
                      width: 70,
                      height: 35,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.thumb_up),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(widget.like.toString()),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Icon(CupertinoIcons.chat_bubble),
                  ),
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
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        if (isSelected[0]) _renderComment(commentdummy),
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
