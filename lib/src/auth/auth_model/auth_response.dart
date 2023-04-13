






import 'package:sama_offices/src/auth/auth_model/user_model.dart';

import '../../../core/utils/BaseResponse.dart';

class AuthResponse  extends BaseResponse<UserModel>{

  AuthResponse(Map<String, dynamic> fullJson) : super(fullJson);


  @override
  dataToJson(UserModel data) {
    return data.toJson();
  }

  @override
  UserModel jsonToData(Map<String, dynamic> fullJson) {
    return UserModel.fromJson(fullJson['data']);
;
  }

}





