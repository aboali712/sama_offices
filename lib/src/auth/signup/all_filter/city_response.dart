
import '../../../../core/utils/BaseResponse.dart';
import 'cities_model.dart';

class CitiesResponse  extends BaseResponse<List<CityModel>>{
  CitiesResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dataToJson(List<CityModel> data) {
    return List<dynamic>.from(data.map((x) => x.toJson()));

  }

  @override
  List<CityModel> jsonToData(Map<String, dynamic> fullJson) {
    List dataList = fullJson["data"];
    return dataList != null
        ? List<CityModel>.from(dataList.map((x) => CityModel.fromJson(x)))
        : <CityModel>[];
  }

}