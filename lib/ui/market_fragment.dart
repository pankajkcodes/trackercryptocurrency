import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/crypto_model.dart';
import '../providers/market_provider.dart';
import '../widgets/crypto_list_tile.dart';

class MarketFragment extends StatefulWidget {
  const MarketFragment({Key? key}) : super(key: key);

  @override
  State<MarketFragment> createState() => _MarketFragmentState();
}

class _MarketFragmentState extends State<MarketFragment> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (marketProvider.marketList.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await marketProvider.fetchData();
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: marketProvider.marketList.length,
                itemBuilder: (context, index) {
                  CryptoModel currentCrypto = marketProvider.marketList[index];

                  return CryptoListTile(currentCrypto: currentCrypto);
                },
              ),
            );
          } else {
            return const Text("Data not found!");
          }
        }
      },
    );
  }
}
