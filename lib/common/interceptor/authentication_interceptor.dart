import 'package:dio/dio.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';

class AuthInterceptor extends Interceptor {
  final UserRepository userRepository;
  AuthInterceptor({required this.userRepository});
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addEntries([
      MapEntry<String, String>(
        "Authorization",
        "Bearer ${userRepository.token}",
      )
    ]);
    handler.next(options);
  }
}
