import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static Future<List<dynamic>> getMarketData() async {
    var url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr";

    /// This is Json Response
    var response = await http.get(Uri.parse(url));

    /// Json Decoded Into Map
    var decodeResponse = jsonDecode(response.body);
    List<dynamic> marketList = decodeResponse as List<dynamic>;

    return marketList;
  }
}
