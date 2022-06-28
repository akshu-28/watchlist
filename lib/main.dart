import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:watchlist/bloc/theme/theme_bloc.dart';

import 'package:watchlist/constants/app_constants.dart';
import 'package:watchlist/constants/route_name.dart';
import 'package:watchlist/route_generator.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => ThemeBloc(),
    child: const MyApp(),
  ));
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    BlocProvider.of<ThemeBloc>(context).add(FetchthemeEvent());
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: AppConstants.watchlistTitle,
          theme: state.theme == true
              ? ThemeData(
                  indicatorColor: Colors.white,
                  primarySwatch: Colors.blue,
                  cardColor: Colors.black,
                  backgroundColor: Colors.black)
              : ThemeData(
                  indicatorColor: Colors.black,
                  primarySwatch: Colors.blue,
                  backgroundColor: Colors.blue[700],
                  cardColor: Colors.white,
                ),
          debugShowCheckedModeBanner: false,
          initialRoute: RouteName.splashScreen,
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }
}
