





import '../../../core/utils/BaseResponse.dart';

class EmptyResponse  extends BaseResponse<String>{

  EmptyResponse(Map<String, dynamic> fullJson) : super(fullJson);


  @override
  dataToJson(String data) {
    return data;
  }

  @override
  String jsonToData(Map<String, dynamic> fullJson) {
    return fullJson['data'].toString();
    ;
  }

}





