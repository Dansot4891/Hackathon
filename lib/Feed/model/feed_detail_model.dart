import 'package:json_annotation/json_annotation.dart';

part 'feed_detail_model.g.dart';

@JsonSerializable()
class FeedItemDetailModel {
  final String courseId;
  final String postId;
  final String name;
  final String memberName;
  final String content;
  final int like;
  final String emoge;
  final List<String> imgUrl;

  const FeedItemDetailModel({
    required this.courseId,
    required this.postId,
    required this.name,
    required this.memberName,
    required this.content,
    required this.like,
    required this.emoge,
    required this.imgUrl,
  });

  factory FeedItemDetailModel.fromJson(Map<String, dynamic> json) =>
      _$FeedItemDetailModelFromJson(json);
}
