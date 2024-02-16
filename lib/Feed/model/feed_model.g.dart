// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedItemModel _$FeedItemModelFromJson(Map<String, dynamic> json) =>
    FeedItemModel(
      name: json['name'] as String,
      content: json['content'] as String,
      like: json['like'] as int,
      id: json['id'] as String,
      emoge: json['emoge'] as String,
    );

Map<String, dynamic> _$FeedItemModelToJson(FeedItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'content': instance.content,
      'like': instance.like,
      'emoge': instance.emoge,
    };
