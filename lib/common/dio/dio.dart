import 'package:wagle_front/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio.g.dart';

@Riverpod(keepAlive: true)
Dio commonDio(CommonDioRef ref) {
  final dio = Dio();
  final storage = ref.watch(storageProvider);
  dio.interceptors.add(CustomInterceptor(storage: storage, ref: ref));

  return dio;
}

class CustomInterceptor extends Interceptor {
  final Ref ref;
  final FlutterSecureStorage storage;

  const CustomInterceptor({
    required this.ref,
    required this.storage,
  });

  // 1) 요청을 보낼때
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await storage.read(key: ACCESS_TOKEN_KEY);

    options.headers.addAll({
      'authorization': 'Bearer $token',
    });

    return super.onRequest(options, handler);
  }

  // 2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  // 3) 에러가 났을때
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null) {
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();
      try {
        final resp = await dio.post('http://$ip/auth/token',
            options:
                Options(headers: {'authorization': 'Bearer $refreshToken'}));

        final accessToken = resp.data['accessToken'];

        final options = err.requestOptions;

        options.headers.addAll({'authorization': 'Bearer $accessToken'});

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 재전송
        final response = await dio.fetch(options);

        return handler.resolve(response);
      } on DioException catch (e) {
        // 원래 여기서 Circular dependency error가 일어나는데
        // 난 강의랑 다르게 했고 왠지 CDR이 안날거같다.
        // 함 이렇게 해보자
        // ref.read(userMeProvider.notifier).logout();
        return handler.reject(e);
      }
    }
    return handler.reject(err);
  }
}
