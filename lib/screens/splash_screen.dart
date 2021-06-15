
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:test_app/screens/login_screen.dart';
import 'package:test_app/screens/signup_screen.dart';

class SplashScreen extends StatelessWidget {
      static const routeName ='/splash_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[850],
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: CircleAvatar(
                radius: 50,
                child: Image.asset('assets/images/bmw-logo.png'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Welcome',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 50),
            Card(
              elevation: 4,
              shadowColor: Colors.blue.shade500,
              color: Colors.grey[850],
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade500, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(LogInScreen.routeName);
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.only(left: 35, right: 35)),
                ),
              ),
            ),
            SizedBox(height: 30),
            Card(
              shadowColor: Colors.blue.shade500,
              color: Colors.grey[850],
              elevation: 4,
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                    //boxShadow: BoxShadow().color.blue,
                    border: Border.all(color: Colors.blue.shade500, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignUpScreen.routeName);
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.only(left: 30, right: 30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
