





import 'package:sama_offices/src/home/more/model/setting_model.dart';

import '../../../../core/utils/BaseResponse.dart';

class SettingsResponse extends BaseResponse<SettingsModel> {
  SettingsResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dataToJson(SettingsModel data) {
    return data.toJson();
  }

  @override
  SettingsModel jsonToData(Map<String, dynamic> fullJson) {
    return SettingsModel.fromJson(fullJson['data']);
  }
}
