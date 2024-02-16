import 'package:json_annotation/json_annotation.dart';

part 'feed_model.g.dart';

@JsonSerializable()
class FeedItemModel {
  final String id;
  final String name;
  final String content;
  final int like;
  final String emoge;

  const FeedItemModel(
      {required this.name,
      required this.content,
      required this.like,
      required this.id,
      required this.emoge});

  factory FeedItemModel.fromJson(Map<String, dynamic> json) =>
      _$FeedItemModelFromJson(json);
}
