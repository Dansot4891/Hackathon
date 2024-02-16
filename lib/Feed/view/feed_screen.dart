import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:wagle_front/Feed/component/feed_item.dart';
import 'package:wagle_front/Feed/repository/feed_repository.dart';
import 'package:wagle_front/Feed/state/feed_item_state.dart';

import '../dummy/feed_dummy.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  late final Map<String, dynamic> courses;

  Future<void> getCourses() async {
    try {
      ref
          .read(feedStateProvider.notifier)
          .changeState(val: FeedStateValue.loading);
      courses = await FeedRepository.getCourse();
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
      // getCourses();
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
        child: Text("에러가 발생했습니다!"),
      );
    } else {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: AnimationLimiter(
            child: ListView.separated(
              itemBuilder: (context, index) {
                final item = dummy[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    verticalOffset: 40,
                    child: FadeInAnimation(
                      child: FeedItem.fromJson(model: item),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
              itemCount: dummy.length,
            ),
          ));
    }
  }
}
