import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:watchlist/model/registration_request.dart';
import 'package:watchlist/model/registration_response.dart';
import 'package:watchlist/model/watchlist_model.dart';

class RegistrationRepository {
  Future<RegistrationResponse> registration(RegistrationRequest product) async {
    Map<String, dynamic> headers = <String, dynamic>{};
    headers['X-ENCRYPT'] = "false";
    log(product.request.toString());
    var response = await http.post(
        Uri.parse(
            "https://dev.gwcindia.in/msil-gwc-webservice-dev/User/GenerateOTP/1.0.0"),
        headers: {"X-ENCRYPT": "false"},
        body: json.encode(product));
    log(response.statusCode.toString());
    RegistrationResponse regResponse =
        RegistrationResponse.fromJson(json.decode(response.body));
    return regResponse;
  }
}
