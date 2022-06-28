import 'package:flutter/material.dart';

import 'package:watchlist/constants/app_constants.dart';
import 'package:watchlist/constants/route_name.dart';
import 'package:watchlist/route_generator.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.watchlistTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
