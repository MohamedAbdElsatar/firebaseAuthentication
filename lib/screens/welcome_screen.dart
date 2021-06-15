import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/auth.dart';
import 'package:test_app/screens/splash_screen.dart';

class WelcomeScreen extends StatelessWidget {
    static const routeName ='welcome_screen';

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
               color: Colors.grey[850],
               shadowColor: Colors.blue.shade500,
               elevation: 5,
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade300, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Provider.of<Auth>(context,listen: false).logout();
                  },
                  child: Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.only(left: 30, right: 30)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
