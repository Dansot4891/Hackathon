import 'package:dio/dio.dart';

final dio = Dio();

final ip = 'http://wagle-load-1082500141.ap-northeast-2.elb.amazonaws.com';

class FeedRepository {
  static Future<List> getCourse() async {
    // dio.interceptors.addAll([]);
    final resp = await dio.get('$ip/v1/course/all');
    return resp.data;
  }

  static Future<List> getPost({required String courseId}) async {
    final resp = await dio.get('$ip/v1/course/$courseId');
    // print(resp.data['postCourseResponseDtoList']);
    return resp.data['postCourseResponseDtoList'];
  }

  static Future<List> getComment({required String postId}) async {
    final resp = await dio.get('$ip/v1/post/$postId/comment');
    // print(resp.data['data']);
    return resp.data['data'];
  }

  static Future<void> postComment(
      {required String postId, required Map<String, dynamic> data}) async {
    // print("postComment");
    await dio.post('$ip/v1/post/$postId/comment', data: data);
  }

  static Future<void> postRecommend({required String postId}) async {
    print("postRecommend");
    await dio.post('$ip/v1/post/$postId/like');
  }
}
