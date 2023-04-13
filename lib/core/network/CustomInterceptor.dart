import 'package:dio/dio.dart';

import '../../main.dart';
import '../cash/storage.helper.dart';

class CustomInterceptor extends Interceptor with StorageHelper {
@override
void onRequest(
    RequestOptions options, RequestInterceptorHandler handler) async {
  String? token = await getToken();
  String? lang = await getLang();

  options.headers['lang'] = lang;

  if(token!=null) {
    if (token.isNotEmpty) {
      options.headers['Authorization'] = "Bearer $token";
      return handler.next(options);
    }
  }
  return handler.next(options);
}
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {}
}
