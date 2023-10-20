import 'package:dio/dio.dart';

class AuthConnect {
  AuthConnect._() : super() {
    _instance = this;
  }

  // lazy initialization
  factory AuthConnect() => _instance ?? AuthConnect._();

  // singleton member
  static AuthConnect? _instance;

  final _dio = Dio();

  /// 인증번호 발송
  Future<bool> sendRequestCode({
    required String phoneNumber,
  }) async {
    final res = await _dio.post(
      'http://49.50.162.41:3097/auth/request_code',
      data: {
        "phone": phoneNumber,
      },
    );

    if(res.data is Map) {
      return (res.data as Map)['isCreated'];
    } else {
      return false;
    }
  }
}