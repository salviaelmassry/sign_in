import 'dart:io';

import 'package:dio/dio.dart';

import 'app_config.dart';

class ApiService {
  static const String urlEncodedType = 'multipart/form-data';
  static const String jsonType = 'application/json';
  static const int internalServerErrorCode = 500;

  static Future<Response<T>?> getApi<T>(
    String path,
  ) async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.getAppBaseUrl(),
      ),
    );
    final Response<T> response = await dio.get(
      path,
      options: Options(
        validateStatus: (int? status) {
          if (status != null) return status < internalServerErrorCode;
          return false;
        },
      ),
    );
    return response;
  }

  static Future<Response<T>?> postApi<T>(
    String path, {
    Map<String, dynamic> body = const <String, dynamic>{},
    bool isJson = true,
  }) async {
    // dio init
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.getAppBaseUrl(),
      ),
    );

    final Response<T> response = await dio.post(
      path,
      data: body,
      options: Options(
        validateStatus: (int? status) {
          if (status != null) {
            return status < internalServerErrorCode;
          }
          return false;
        },
        contentType: isJson ? jsonType : urlEncodedType,
      ),
    );
    return response;
  }

  static Future<Response<T>?> postMultiPartApi<T>(
    String path, {
    Map<String, dynamic> body = const <String, dynamic>{},
    String? filesName,
    File? file,
    bool isJson = true,
    bool hasUserId = true,
  }) async {
    final FormData formData = FormData();
    body.forEach((String key, dynamic value) {
      formData.fields.add(
        MapEntry<String, String>(key, value.toString()),
      );
    });

    final Dio dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.getAppBaseUrl(),
      ),
    );

    if (file != null) {
      final String fileName = file.path.split('/').last;
      formData.files.add(
        MapEntry<String, MultipartFile>(
          filesName ?? fileName,
          await MultipartFile.fromFile(file.path, filename: fileName),
        ),
      );
    }

    final Response<T> response = await dio.post(
      path,
      data: formData,
      options: Options(
        validateStatus: (int? status) {
          if (status != null) return status < internalServerErrorCode;
          return false;
        },
        contentType: isJson ? jsonType : urlEncodedType,
      ),
    );
    return response;
  }
}
