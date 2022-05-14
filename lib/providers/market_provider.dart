import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:trackercryptocurrency/api/api.dart';
import 'package:trackercryptocurrency/db/local.dart';
import 'package:trackercryptocurrency/models/crypto_model.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoModel> marketList = [];

  MarketProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> _marketList = await Api.getMarketData();
    List<String> favouriteList = await LocalStorage.fetchFavorites();

    List<CryptoModel> temp = [];

    for (var marketList in _marketList) {
      CryptoModel newCryptoModel = CryptoModel.fromJSON(marketList);

      if (favouriteList.contains(newCryptoModel.id)) {
        newCryptoModel.isFavorite = true;
      }

      temp.add(newCryptoModel);
    }

    marketList = temp;
    isLoading = false;
    notifyListeners();
  }

  CryptoModel fetchCryptoById(String id) {
    CryptoModel crypto =
        marketList.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addFavourite(CryptoModel crypto) async {
    int indexOfCrypto = marketList.indexOf(crypto);
    marketList[indexOfCrypto].isFavorite = true;
    await LocalStorage.addFavorite(crypto.id!);
    notifyListeners();
  }

  void removeFavourite(CryptoModel crypto) async {
    int indexOfCrypto = marketList.indexOf(crypto);
    marketList[indexOfCrypto].isFavorite = true;
    await LocalStorage.removeFavorite(crypto.id!);
    notifyListeners();
  }
}
