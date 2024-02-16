// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedItemCommentModel _$FeedItemCommentModelFromJson(
        Map<String, dynamic> json) =>
    FeedItemCommentModel(
      id: json['id'] as String,
      username: json['username'] as String,
      comment: json['comment'] as String,
      emoge: json['emoge'] as String,
    );

Map<String, dynamic> _$FeedItemCommentModelToJson(
        FeedItemCommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'comment': instance.comment,
      'emoge': instance.emoge,
    };
