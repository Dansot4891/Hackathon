import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wagle_front/Feed/model/feed_comment_model.dart';

class FeedComment extends StatelessWidget {
  final String id;
  final String username;
  final String comment;
  final String emoge;

  const FeedComment({
    super.key,
    required this.id,
    required this.username,
    required this.comment,
    required this.emoge,
  });

  factory FeedComment.fromJson({required FeedItemCommentModel model}) {
    return FeedComment(
      id: model.id,
      username: model.username,
      comment: model.comment,
      emoge: model.emoge,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width * 0.9,
      // height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _renderLeading(width, emoge),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username),
              SizedBox(
                width: width * 0.8,
                child: RichText(
                  text: TextSpan(
                      text: comment,
                      style: const TextStyle(
                        color: Colors.black,
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _renderLeading(double width, String emoge) {
  return Text(
    '\u{1f60D}',
    // emoge,
    style: TextStyle(fontSize: 30),
  );
}
