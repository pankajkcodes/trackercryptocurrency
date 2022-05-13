import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackercryptocurrency/providers/market_provider.dart';

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
      appBar: AppBar(
        title: const Text("Cryptocurrency Tracker"),
      ),
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Today Crypto Market",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                            itemCount: marketProvider.marketList.length,
                            itemBuilder: (context, index) {
                              CryptoModel currentCrypto =
                                  marketProvider.marketList[index];
                              return ListTile(
                                contentPadding: const EdgeInsets.all(0.0),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      NetworkImage(currentCrypto.image!),
                                ),
                                title: Text(currentCrypto.name!),
                                subtitle:
                                    Text(currentCrypto.symbol!.toUpperCase()),
                                trailing: Text("₹ "+
                                  currentCrypto.currentPrice!
                                      .toStringAsFixed(5),
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
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
