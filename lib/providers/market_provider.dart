import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:trackercryptocurrency/api/api.dart';
import 'package:trackercryptocurrency/models/crypto_model.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoModel> marketList = [];

  MarketProvider() {
    fetchData();
  }

  void fetchData() async {
    List<dynamic> _marketList = await Api.getMarketData();
    List<CryptoModel> temp = [];

    for (var marketList in _marketList) {
      CryptoModel cryptoModel = CryptoModel.fromJSON(marketList);
      temp.add(cryptoModel);
    }

    marketList = temp;
    isLoading = false;
    notifyListeners();

    Timer(const Duration(seconds: 4), () {
      fetchData();
    });


  }
  CryptoModel fetchCryptoById(String id) {
    CryptoModel crypto =
    marketList.where((element) => element.id == id).toList()[0];
    return crypto;
  }
}
