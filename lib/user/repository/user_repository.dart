import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wagle_front/common/dio/dio.dart';

import '../../common/const/data.dart';

part 'user_repository.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) {
  final dio = ref.read(commonDioProvider);
  final repo = UserRepository(dio, baseUrl: "http://$ip");
  return repo;
}

@RestApi()
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  @PUT('/login')
  Future<void> userLogin();

  @POST('/logout')
  Future<void> userLogout();
}
