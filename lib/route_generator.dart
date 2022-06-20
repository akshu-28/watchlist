import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/ui/screens/acknow_page.dart';
import 'package:watchlist/ui/screens/confirm_page.dart';
import 'package:watchlist/ui/screens/login.dart';
import 'package:watchlist/ui/screens/registration.dart';

import 'package:watchlist/ui/screens/watchlist.dart';

import 'bloc/watchlist/watchlist_bloc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Registration());
      case '/loginpage':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/watchlist':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => WatchlistBloc(),
                  child: const Watchlist(),
                ));
      case '/confirmpage':
        return MaterialPageRoute(
            builder: (_) => Confirmpage(args: args as ConfirmArgs));
      case '/acknowpage':
        return MaterialPageRoute(builder: (_) => const Acknowledge());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('HomePage'),
        ),
      );
    });
  }
}

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName, Object? arg) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arg);
  }
}
