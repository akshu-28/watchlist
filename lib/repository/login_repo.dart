import 'dart:convert';
import 'dart:core';

import 'package:watchlist/constants/api_url.dart';
import 'package:watchlist/model/login_request.dart';
import 'package:watchlist/resources/api_base_helper.dart';

import '../model/login_response.dart';

class OtpvalidationRepository {
  Future<LoginResponse> login(OtpvalidationRequest product) async {
    var response = await ApiBaseHelper()
        .postMethod(ApiUrls.loginUrl, json.encode(product));

    LoginResponse regResponse =
        LoginResponse.fromJson(json.decode(response.body));
    if (regResponse.response.infoID == "EGN002") {
      throw "${json.decode(response.body)["response"]["infoMsg"]}";
    }
    return regResponse;
  }
}
