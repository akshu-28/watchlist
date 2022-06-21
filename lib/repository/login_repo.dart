import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:watchlist/model/login_request.dart';

import '../model/login_response.dart';

class LoginRepository {
  Future<LoginResponse> login(LoginRequest product) async {
    Map<String, dynamic> headers = <String, dynamic>{};
    headers['X-ENCRYPT'] = "false";

    var response = await http.post(
        Uri.parse("https://dev.gwcindia.in/virtual-trade/User/Login/1.0.0"),
        headers: {"X-ENCRYPT": "false"},
        body: json.encode(product));
    log(response.statusCode.toString());
    LoginResponse regResponse =
        LoginResponse.fromJson(json.decode(response.body));
    return regResponse;
  }
}
