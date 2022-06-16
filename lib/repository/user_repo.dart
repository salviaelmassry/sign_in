import 'package:dio/dio.dart';
import 'package:sign_in/api/api_service.dart';
import 'package:sign_in/api/apis_paths.dart';
import 'package:sign_in/models/user_model.dart';

import '../models/user_model_response.dart';

class UserRepo {
  static Future<UserResponse> signUp({required User user}) async {
    final Response<dynamic>? response = await ApiService.postMultiPartApi(
      ApiPaths.register,
      file: user.avatar,
      filesName: 'avatar',
      isJson: false,
      body: user.toJson(),
    );

    return UserResponse(json: response?.data);
  }

  static Future<UserResponse> verifyUser(
      {required String verificationCode, required int userId}) async {
    final Response<dynamic>? response =
        await ApiService.postApi(ApiPaths.verify, body: <String, dynamic>{
      'user_id': userId,
      'verification_code': verificationCode,
    });

    return UserResponse(
      json: response?.data,
    );
  }

  static Future<UserResponse> signIn(
      {required String email, required String password}) async {
    final Response<dynamic>? response =
        await ApiService.postApi(ApiPaths.login, body: <String, dynamic>{
      'email': email,
      'password': password,
    });

    return UserResponse(json: response?.data, auth: true);
  }
}
