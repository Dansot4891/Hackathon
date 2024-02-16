import 'package:dio/dio.dart';

final dio = Dio();

final ip = 'http://wagle-load-1082500141.ap-northeast-2.elb.amazonaws.com';

class FeedRepository {
  static Future<Map<String, dynamic>> getCourse() async {
    final resp = await dio.get('$ip/v1/course/search');
    print(resp);
    return resp.data;
  }

  static Future<Map<String, dynamic>> getPost(
      {required String courseId}) async {
    final resp = await dio.get('$ip/v1/course/$courseId');
    print(resp);
    return resp.data;
  }

  static Future<Map<String, dynamic>> getComment(
      {required String postId}) async {
    final resp = await dio.get('$ip/v1/post/$postId/comment');
    print(resp);
    return resp.data;
  }
}
