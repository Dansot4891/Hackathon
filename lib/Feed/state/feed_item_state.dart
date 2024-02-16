import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_item_state.g.dart';

enum FeedStateValue {
  loading,
  error,
  get,
}

@Riverpod(keepAlive: true)
class FeedState extends _$FeedState {
  @override
  FeedStateValue build() {
    return FeedStateValue.get;
  }

  void changeState({required FeedStateValue val}) {
    state = val;
  }
}
