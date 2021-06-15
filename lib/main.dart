import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/auth.dart';
import 'package:test_app/screens/login_screen.dart';
import 'package:test_app/screens/splash_screen.dart';
import 'package:test_app/screens/welcome_screen.dart';

import 'screens/signup_screen.dart';
//import 'package:test_app/screens/splash_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Auth(),
      child: MaterialApp(
        home: MyHomePage(),
        //ColorSelector(),
        debugShowCheckedModeBanner: false,
        routes: {
          LogInScreen.routeName: (context) => LogInScreen(),
          SignUpScreen.routeName: (context) => SignUpScreen(),
          SplashScreen.routeName: (context) => SplashScreen(),
          WelcomeScreen.routeName: (context) => WelcomeScreen()
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(),
    );
  }
}
