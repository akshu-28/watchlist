import 'dart:convert';
import 'dart:core';

import 'package:watchlist/constants/api_url.dart';
import 'package:watchlist/model/watchlist_model.dart';
import 'package:watchlist/resources/api_base_helper.dart';

class WatchlistRepository {
  Future<WatchlistModel> data() async {
    var response = await ApiBaseHelper().getMethod(ApiUrls.watchlistUrl);

    WatchlistModel watchlistResponse =
        WatchlistModel.fromJson(json.decode(response.body));

    return watchlistResponse;
  }
}
