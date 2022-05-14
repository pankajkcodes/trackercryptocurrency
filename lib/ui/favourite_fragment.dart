import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackercryptocurrency/models/crypto_model.dart';

import '../providers/market_provider.dart';
import '../widgets/crypto_list_tile.dart';

class FavouriteFragment extends StatefulWidget {
  const FavouriteFragment({Key? key}) : super(key: key);

  @override
  State<FavouriteFragment> createState() => _FavouriteFragmentState();
}

class _FavouriteFragmentState extends State<FavouriteFragment> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        List<CryptoModel> favorites = marketProvider.marketList
            .where((element) => element.isFavorite == true)
            .toList();

        if (favorites.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              await marketProvider.fetchData();
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                CryptoModel currentCrypto = favorites[index];
                return CryptoListTile(currentCrypto: currentCrypto);
              },
            ),
          );
        } else {
          return const Center(
            child: Text(
              "No favorites yet",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
          );
        }
      },
    );
  }
}

