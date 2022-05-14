import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackercryptocurrency/providers/theme_provider.dart';
import 'package:trackercryptocurrency/ui/favourite_fragment.dart';
import 'package:trackercryptocurrency/ui/market_fragment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 0),
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
              TabBar(controller: tabController, tabs: [
                Tab(
                  child: Text(
                    "Market",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Tab(
                  child: Text(
                    "Favourite",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ]),
              Expanded(
                child: TabBarView(
                    controller: tabController,
                    children: const [MarketFragment(), FavouriteFragment()]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
