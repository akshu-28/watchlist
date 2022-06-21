class RegistrationResponse {
  RegistrationResponse({
    required this.response,
  });
  late final Response response;

  RegistrationResponse.fromJson(Map<String, dynamic> json) {
    response = Response.fromJson(json['response']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['response'] = response.toJson();
    return _data;
  }
}

class Response {
  Response({
    required this.infoID,
    required this.data,
    required this.infoMsg,
    required this.msgID,
  });
  late final String infoID;
  late final Data data;
  late final String infoMsg;
  late final String msgID;

  Response.fromJson(Map<String, dynamic> json) {
    infoID = json['infoID'];
    data = Data.fromJson(json['data']);
    infoMsg = json['infoMsg'];
    msgID = json['msgID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['infoID'] = infoID;
    _data['data'] = data.toJson();
    _data['infoMsg'] = infoMsg;
    _data['msgID'] = msgID;
    return _data;
  }
}

class Data {
  Data();

  Data.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}
