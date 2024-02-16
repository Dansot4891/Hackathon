import 'package:json_annotation/json_annotation.dart';

part 'feed_comment_model.g.dart';

@JsonSerializable()
class FeedItemCommentModel {
  final String id;
  final String username;
  final String comment;
  final String emoge;

  const FeedItemCommentModel({
    required this.id,
    required this.username,
    required this.comment,
    required this.emoge,
  });

  factory FeedItemCommentModel.fromJson(Map<String, dynamic> json) =>
      _$FeedItemCommentModelFromJson(json);
}
