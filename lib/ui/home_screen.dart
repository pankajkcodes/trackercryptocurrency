import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackercryptocurrency/providers/market_provider.dart';
import 'package:trackercryptocurrency/providers/theme_provider.dart';
import 'package:trackercryptocurrency/ui/details_screen.dart';
import '../models/crypto_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today Crypto Market",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                      },
                      icon: const Icon(Icons.dark_mode))
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Consumer<MarketProvider>(
                  builder: (context, marketProvider, child) {
                    if (marketProvider.isLoading == true) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (marketProvider.marketList.isNotEmpty) {
                        return ListView.builder(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: marketProvider.marketList.length,
                            itemBuilder: (context, index) {
                              CryptoModel currentCrypto =
                                  marketProvider.marketList[index];
                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsScreen(
                                                id: currentCrypto.id!,
                                              )));
                                },
                                contentPadding: const EdgeInsets.all(0.0),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      NetworkImage(currentCrypto.image!),
                                ),
                                title: Text(currentCrypto.name! +
                                    " #${currentCrypto.marketCapRank!}"),
                                subtitle:
                                    Text(currentCrypto.symbol!.toUpperCase()),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "₹ " +
                                          currentCrypto.currentPrice!
                                              .toStringAsFixed(5),
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Builder(builder: (context) {
                                      double priceChange =
                                          currentCrypto.priceChange24!;
                                      double priceChangePercentage =
                                          currentCrypto
                                              .priceChangePercentage24!;
                                      if (priceChangePercentage < 0) {
                                        // NEGATIVE
                                        return Text(
                                          "${priceChangePercentage.toStringAsFixed(2)}% "
                                          "(${priceChange.toStringAsFixed(4)})",
                                          style: const TextStyle(
                                              color: Colors.red),
                                        );
                                      } else {
                                        // POSITIVE
                                        return Text(
                                          "${priceChangePercentage.toStringAsFixed(2)}% "
                                          "(+${priceChange.toStringAsFixed(4)})",
                                          style: const TextStyle(
                                              color: Colors.green),
                                        );
                                      }
                                    })
                                  ],
                                ),
                              );
                            });
                      } else {
                        return const Text("Data Not Found");
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
