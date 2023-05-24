






import '../../../../core/utils/BaseResponse.dart';
import 'notifications_model.dart';

class NotResponse  extends BaseResponse<List<NotificationModel>>{
  NotResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dynamic dataToJson(data) {
    return List<dynamic>.from(data.map((x) => x.toJson()));

  }

  @override
  List<NotificationModel> jsonToData(Map<String, dynamic> fullJson) {
    List dataList = fullJson["data"];
    return dataList != null
        ? List<NotificationModel>.from(dataList.map((x) => NotificationModel.fromJson(x)))
        : <NotificationModel>[];
  }

}