import 'package:dio/dio.dart';

import '../cash/storage.helper.dart';
import 'CustomInterceptor.dart';

class NetworkService extends StorageHelper {
  String token = "";
  Map<String, String> mp = {};
  static NetworkService? _instace;
  static NetworkService get instance {
    if (_instace != null) return _instace!;
    _instace = NetworkService._init();
    return _instace!;
  }

  //final String _baseUrl1 = "https://sama.horsesdelivery.com/api/";
  final String _baseUrl1 = "https://samaapp.com/api/";
  late final Dio dio;

  NetworkService._init() {
    dio = Dio(BaseOptions(baseUrl: _baseUrl1));
    getToken().then((value) => {
          if (value != null && value != "")
            {
              mp = {},
              mp["Authorization"] = "Bearer $value",
              dio.options.headers = mp
            },
          dio.interceptors.add(CustomInterceptor()),
          dio.interceptors.add(LogInterceptor(
            request: true,
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
            responseBody: true,
          ))
        });
  }
}
