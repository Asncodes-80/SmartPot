import 'package:dio/dio.dart';
import 'package:shahjump/config/main.dart';

class ApiAccess {
  final String token;

  ApiAccess(this.token);

  Dio dio = Dio(BaseOptions(
    baseUrl: baseURL,
    receiveDataWhenStatusError: true,
    connectTimeout: 60 * 1000,
    receiveTimeout: 60 * 1000,
  ));

  Future requestHandler({String? uri, String? method, Map? data}) async {
    ///
    /// Handle the request of the API,
    /// uri: [String] -> Route of the API
    /// method: [String] -> Sending method
    /// data: [Map] -> form data as {key: value} object
    try {
      Response response = await dio.request(
        "$uri",
        data: data,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      return response.data;
    } on DioError catch (e) {
      return e.response?.data;
    }
  }
}
