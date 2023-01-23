import 'package:flutter/material.dart';
import 'package:octopus/config/routes/routers.dart';
import 'package:octopus/screens/login_screen.dart';
import 'package:octopus/screens/sign_up_screen.dart';
import 'package:octopus/screens/welcome_screen.dart';

class AppRoutes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.LOGIN:
        return PageRouteBuilder(
          pageBuilder: ((context, animation, secondaryAnimation) =>
              const LoginScreen()),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.easeInOut;
            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            // final offsetAnimation = animation.drive(tween);
            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        );
      case Routes.SIGN_UP:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SignUpScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.easeInOut;
            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            // final offsetAnimation = animation.drive(tween);
            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        );
      case Routes.WELCOME:
        return MaterialPageRoute(builder: (_) {
          return const WelcomeScreen();
        });
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
