




import '../../../../core/utils/BaseResponse.dart';
import 'filter_model.dart';

class FilterResponse extends BaseResponse<FilterModel> {
  FilterResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dataToJson(FilterModel data) {
    return data.toJson();
  }

  @override
  FilterModel jsonToData(Map<String, dynamic> fullJson) {
    return FilterModel.fromJson(fullJson['data']);
  }
}
