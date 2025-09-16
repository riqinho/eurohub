import 'package:eurohub/screens/challenge_details.dart';
import 'package:eurohub/screens/home_screen.dart';
import 'package:eurohub/screens/login_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String login = '/';
  static const String home = '/home';
  static const String challengeDetail = '/challenges/details';
  static const String chat = '/chat';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case challengeDetail:
        return MaterialPageRoute(
          builder: (_) => const ChallengeDetailsScreen(),
          settings: settings,
        );
      case chat:
        return MaterialPageRoute(builder: (_) => const Placeholder());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
