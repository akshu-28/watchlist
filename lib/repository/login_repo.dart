import 'dart:convert';
import 'dart:core';

import 'package:watchlist/model/login_request.dart';
import 'package:watchlist/resources/api_base_helper.dart';

import '../model/login_response.dart';

class LoginRepository {
  Future<LoginResponse> login(LoginRequest product) async {
    var response = await ApiBaseHelper()
        .postMethod(ApiBaseHelper.loginUrl, json.encode(product));

    LoginResponse regResponse =
        LoginResponse.fromJson(json.decode(response.body));
    if (regResponse.response.infoID == "EGN002") {
      throw "${json.decode(response.body)["response"]["infoMsg"]}";
    }
    return regResponse;
  }
}
