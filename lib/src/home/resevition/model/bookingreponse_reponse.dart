





import '../../../../core/utils/BaseResponse.dart';
import 'get_bookings_model.dart';

class BookingsResponse  extends BaseResponse<List<BookingsModel>>{
  BookingsResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dataToJson(List<BookingsModel> data) {
    return List<dynamic>.from(data.map((x) => x.toJson()));

  }

  @override
  List<BookingsModel> jsonToData(Map<String, dynamic> fullJson) {
    List dataList = fullJson["data"];
    return dataList != null
        ? List<BookingsModel>.from(dataList.map((x) => BookingsModel.fromJson(x)))
        : <BookingsModel>[];
  }

}