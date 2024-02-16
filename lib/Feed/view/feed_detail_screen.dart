import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wagle_front/Feed/dummy/feed_detail_dummy.dart';
import 'package:wagle_front/Feed/model/feed_detail_model.dart';

import '../../common/layout/default_layout.dart';
import '../component/feed_post.dart';
import '../repository/feed_repository.dart';
import '../state/feed_item_state.dart';

class FeedDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const FeedDetailScreen({super.key, required this.id});

  @override
  ConsumerState<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends ConsumerState<FeedDetailScreen> {
  List<bool> isSelected = [false];

  late final Map<String, dynamic> courses;

  Future<void> getPosts() async {
    try {
      ref
          .read(feedStateProvider.notifier)
          .changeState(val: FeedStateValue.loading);
      courses = await FeedRepository.getPost(courseId: widget.id);
      ref.read(feedStateProvider.notifier).changeState(val: FeedStateValue.get);
    } on Exception catch (_) {
      ref
          .read(feedStateProvider.notifier)
          .changeState(val: FeedStateValue.error);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(feedStateProvider);
    if (state == FeedStateValue.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );
    } else if (state == FeedStateValue.error) {
      return const Center(
        child: DefaultLayout(child: Text("에러가 발생했습니다!")),
      );
    } else {
      return DefaultLayout(
        title: "",
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: CustomScrollView(
            slivers: [
              _renderPost(detaildummy),
            ],
          ),
        ),
      );
    }
  }
}

SliverPadding _renderPost(List<FeedItemDetailModel> details) {
  return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: details.length,
              (_, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: FeedPost.fromJson(
                      model: details[index],
                    ),
                  ))));
}
