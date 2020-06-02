

import 'package:flutter/material.dart';
import 'package:flutterapp/page2ios.dart';
import 'package:flutterapp/ui/pages/MainPage.dart';
import 'package:flutterapp/ui/pages/ProfilePage.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainPage());
      case '/sign_in':
        return MaterialPageRoute(builder: (_) => SignInPage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());







      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
