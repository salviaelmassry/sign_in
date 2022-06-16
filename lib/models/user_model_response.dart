import 'package:sign_in/models/user_model.dart';

class UserResponse {
  late final bool status;
  late final String message;
  User? result;

  UserResponse({Map<String, dynamic>? json, bool auth = false}) {
    if (json != null) {
      message = json['message'].toString();
      status = resultSuccess(json);
      result = json['data'] != null
          ? auth
              ? User.fromJson(json['data']['user'])
              : User.fromJson(json['data'])
          : null;
    } else {
      result = null;
      status = false;
    }
  }
  dynamic resultSuccess(Map<String, dynamic> json) {
    if (json['status'] == false) return false;
    return true;
  }
}
