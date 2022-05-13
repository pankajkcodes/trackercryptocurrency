import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackercryptocurrency/models/crypto_model.dart';
import 'package:trackercryptocurrency/providers/market_provider.dart';

class DetailsScreen extends StatefulWidget {
  final String id;

  const DetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Consumer<MarketProvider>(
            builder: (context, marketProvider, child) {
              CryptoModel currentCrypto =
                  marketProvider.fetchCryptoById(widget.id);
              return ListView(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(currentCrypto.image!),
                    ),
                    title: Text(
                      currentCrypto.name! +
                          " (${currentCrypto.symbol!.toUpperCase()})",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      "₹ " + currentCrypto.currentPrice!.toStringAsFixed(4),
                      style: const TextStyle(
                          color: Color(0xff0395eb),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Price Change (24h)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Builder(
                        builder: (context) {
                          double priceChange = currentCrypto.priceChange24!;
                          double priceChangePercentage =
                              currentCrypto.priceChangePercentage24!;

                          if (priceChange < 0) {
                            // negative
                            return Text(
                              "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                              style: TextStyle(color: Colors.red, fontSize: 23),
                            );
                          } else {
                            // positive
                            return Text(
                              "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 23),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail(
                          "Market Cap",
                          "₹ " + currentCrypto.marketCap!.toStringAsFixed(4),
                          CrossAxisAlignment.start),
                      titleAndDetail(
                          "Market Cap Rank",
                          "#" + currentCrypto.marketCapRank.toString(),
                          CrossAxisAlignment.end),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail(
                          "Low 24h",
                          "₹ " + currentCrypto.low24!.toStringAsFixed(4),
                          CrossAxisAlignment.start),
                      titleAndDetail(
                          "High 24h",
                          "₹ " + currentCrypto.high24!.toStringAsFixed(4),
                          CrossAxisAlignment.end),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail(
                          "Circulating Supply",
                          currentCrypto.circulatingSupply!.toInt().toString(),
                          CrossAxisAlignment.start),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail(
                          "All Time Low",
                          currentCrypto.atl!.toStringAsFixed(4),
                          CrossAxisAlignment.start),
                      titleAndDetail(
                          "All Time High",
                          currentCrypto.ath!.toStringAsFixed(4),
                          CrossAxisAlignment.start),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget titleAndDetail(
      String title, String detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        Text(
          detail,
          style: TextStyle(fontSize: 17),
        ),
      ],
    );
  }
}
