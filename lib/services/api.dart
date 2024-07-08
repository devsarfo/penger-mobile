import 'package:dio/dio.dart';
import 'package:penger/resources/app_strings.dart';

class ApiService {
  static final dio = Dio();

  // post
  static Future<Response> post(String url, Map<String, dynamic> body) async {
    final response = await dio.post(url,
        data: body, options: Options(headers: {'Accept': 'application/json'}));

    return response;
  }

  // get
  static Future<Response> get(String url, Map<String, dynamic> params) async {
    final response = await dio.get(url,
        queryParameters: params,
        options: Options(headers: {'Accept': 'application/json'}));

    return response;
  }

  static String errorMessage(DioException dioException) {
    final internetErrors = [
      DioExceptionType.connectionError,
      DioExceptionType.connectionTimeout,
      DioExceptionType.sendTimeout,
      DioExceptionType.receiveTimeout
    ];

    return (internetErrors.contains(dioException.type))
        ? AppStrings.noInternetAccess
        : (dioException.response?.data['message'] ?? AppStrings.anErrorOccurredTryAgain);
  }
}
