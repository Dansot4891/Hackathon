import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wagle_front/Feed/model/feed_detail_model.dart';

import '../../common/layout/default_layout.dart';
import '../component/feed_post.dart';
import '../repository/feed_repository.dart';

class FeedDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const FeedDetailScreen({super.key, required this.id});

  @override
  ConsumerState<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends ConsumerState<FeedDetailScreen> {
  List<bool> isSelected = [false];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FeedRepository.getPost(courseId: widget.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const DefaultLayout(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: DefaultLayout(child: Text("에러가 발생했습니다!")),
            );
          } else {
            return DefaultLayout(
              title: "",
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: CustomScrollView(
                  slivers: [
                    _renderPost(snapshot.data!),
                  ],
                ),
              ),
            );
          }
        });
  }
}

SliverPadding _renderPost(List details) {
  return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(childCount: details.length,
              (_, index) {
        final item = details[index];
        // print(item);
        final model = FeedItemDetailModel(
          courseId: "asdfasdf",
          postId: item['postId'].toString(),
          name: item['name'],
          memberName: item['memberName'],
          content: item['content'],
          like: 132,
          emoge: '\u{1f60D}',
          imgUrl: [],
        );
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              FeedPost.fromJson(
                model: model,
              ),
              if (index != details.length - 1)
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
            ],
          ),
        );
      })));
}
