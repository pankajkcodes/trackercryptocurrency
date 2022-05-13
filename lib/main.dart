import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackercryptocurrency/providers/market_provider.dart';
import 'package:trackercryptocurrency/ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
          create: (context) => MarketProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Cryptocurrency Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
