import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wagle_front/Feed/model/feed_comment_model.dart';
import 'package:wagle_front/Feed/repository/feed_repository.dart';
import 'package:wagle_front/common/component/custom_text_form_field.dart';

import '../component/feed_comment.dart';

class FeedCommentScreen extends ConsumerStatefulWidget {
  final String postId;

  const FeedCommentScreen({super.key, required this.postId});

  @override
  ConsumerState<FeedCommentScreen> createState() => _FeedCommentScreenState();
}

class _FeedCommentScreenState extends ConsumerState<FeedCommentScreen> {
  late String comment = "";
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width * 0.6,
                height: 50,
                child: CustomTextFormField(
                  controller: controller,
                  onChanged: (val) {
                    comment = val;
                  },
                  hintText: "댓글 입력",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    FeedRepository.postComment(postId: widget.postId, data: {
                      'memberId': 1,
                      'postId': int.parse(widget.postId),
                      'comment': comment,
                    });
                    controller.clear();
                  },
                  child: Text(
                    "댓글 달기",
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
        ),
        FutureBuilder(
            future: FeedRepository.getComment(postId: widget.postId),
            builder: (context, snapshot) {
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("에러가 발생했습니다!"),
                );
              } else {
                final data = snapshot.data!;
                return ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 50,
                    maxHeight: 250,
                  ),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        final item = data[index];
                        final model = FeedItemCommentModel(
                            id: "1",
                            username: item['nickname'],
                            comment: item['comment'],
                            emoge: item['emoji']);
                        return FeedComment.fromJson(model: model);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: data.length),
                );
              }
            }),
      ],
    );
  }
}
