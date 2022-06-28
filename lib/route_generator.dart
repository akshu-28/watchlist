import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:watchlist/bloc/registration/registration_bloc.dart';
import 'package:watchlist/constants/app_constants.dart';
import 'package:watchlist/constants/route_name.dart';
import 'package:watchlist/ui/screens/acknow_screen.dart';
import 'package:watchlist/ui/screens/confirm_screen.dart';
import 'package:watchlist/ui/screens/otp_screen.dart';
import 'package:watchlist/ui/screens/registration.dart';
import 'package:watchlist/ui/screens/splash_screen.dart';

import 'package:watchlist/ui/screens/watchlist.dart';

import 'bloc/otp_validation/otp_validation_bloc.dart';
import 'bloc/watchlist/watchlist_bloc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.registerScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => RegistrationBloc(),
                  child: const Registration(),
                ));
      case RouteName.loginScreen:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => RegistrationBloc(),
                    ),
                    BlocProvider(
                      create: (context) => OtpvalidationBloc(),
                    )
                  ],
                  child: OtpValidation(mobileNumber: args as String),
                ));
      case RouteName.watchlistScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => WatchlistBloc(),
                  child: const Watchlist(),
                ));
      case RouteName.confirmScreen:
        return MaterialPageRoute(
            builder: (_) => Confirmpage(args: args as ConfirmArgs));
      case RouteName.acknowScreen:
        return MaterialPageRoute(builder: (_) => const Acknowledge());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text(AppConstants.pageNotfound),
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
