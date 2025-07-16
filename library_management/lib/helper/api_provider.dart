import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

int count = 0;

class APIProvider {
  late String apiBaseAddress;
  late Dio client;

  final SharedPreferences sharedPreferences;

  APIProvider({required this.sharedPreferences}) {
    apiBaseAddress = "http://localhost:5184/";

    client = Dio();
    client.options.baseUrl = apiBaseAddress;
    client.options.contentType = 'application/json';
    client.options.headers["Accept"] = "application/json";
    // client.options.headers["ngrok-skip-browser-warning"] = true;

    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Get Token
          String? accessToken = sharedPreferences.getString("MY_TOKEN") ?? "";

          options.headers["Authorization"] = "bearer $accessToken";
          return handler.next(options);
        },
        onError: (error, handler) async {
          log(count.toString());
          log(error.requestOptions.path);

          if (error.response?.statusCode == 401) {
            await sharedPreferences.remove("MY_TOKEN");
            log('Token expired, user logged out.');
          } else {
            log(error.toString());
          }
          count++;
          handler.next(error);
        },
      ),
    );
  }
}
