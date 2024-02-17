// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedItemDetailModel _$FeedItemDetailModelFromJson(Map<String, dynamic> json) =>
    FeedItemDetailModel(
      courseId: json['courseId'] as String,
      postId: json['postId'] as String,
      name: json['name'] as String,
      memberName: json['memberName'] as String,
      content: json['content'] as String,
      like: json['like'] as int,
      emoge: json['emoge'] as String,
      imgUrl:
          (json['imgUrl'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FeedItemDetailModelToJson(
        FeedItemDetailModel instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'postId': instance.postId,
      'name': instance.name,
      'memberName': instance.memberName,
      'content': instance.content,
      'like': instance.like,
      'emoge': instance.emoge,
      'imgUrl': instance.imgUrl,
    };
