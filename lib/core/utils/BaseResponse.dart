abstract class BaseResponse<T> {
  int? status;
  String? msg;
  String? token;

  T? data;

  BaseResponse(Map<String, dynamic> fullJson) {
    parsing(fullJson);
  }

  T jsonToData(Map<String, dynamic> fullJson);
  dynamic dataToJson(T data);

  parsing(Map<String, dynamic> fullJson) {
    status = fullJson['status'];
    msg = fullJson['msg'];
    token = fullJson['token'];

    data = fullJson['data'] != null ? jsonToData(fullJson) : null;
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'msg': msg,
    'token': token,
    'data': data != null ? dataToJson(data !) : null
      };
}
