import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:watchlist/model/watchlist_model.dart';

class WatchlistRepository {
  static String url =
      "https://run.mocky.io/v3/ec1a0f0c-3739-4914-b5c0-2140e5165fe5";
  Future<WatchlistModel> data() async {
    var response = await http.get(Uri.parse(url));

    WatchlistModel watchlistResponse =
        WatchlistModel.fromJson(json.decode(response.body));

    return watchlistResponse;
  }
}
