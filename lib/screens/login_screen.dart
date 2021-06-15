import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/http_exception.dart';
import 'package:test_app/provider/auth.dart';
import 'package:test_app/screens/splash_screen.dart';
import 'package:test_app/screens/welcome_screen.dart';

import 'signup_screen.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = '/log_in';

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  //final _passwordController = TextEditingController();

  Future<void> _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      // Invalid!
      print("InValid");
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    print(_authData['email']);
    // Sign user in

    try {
      await Provider.of<Auth>(context, listen: false)
          .signin(_authData['email'], _authData['password']);

      Provider.of<Auth>(context, listen: false).isAuth
          ? Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeName)
          : print('error');
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      //any genaric error  can ocoure
      const errorMessage = 'Could not authenticate you,Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured!'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        padding: EdgeInsets.only(top: 60),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 40, child: Image.asset('assets/images/bmw-logo.png')),
              SizedBox(height: 30),
              Text('Log In',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.grey[850],
                    shadowColor: Colors.yellow,
                    elevation: 5,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: OutlinedButton(
                        onPressed: () async {
                          await Provider.of<Auth>(context, listen: false)
                              .signInWithFacebook();
                        },
                        child: Text(
                          'Facebook',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.only(
                                left: 30, right: 30, top: 5, bottom: 5)),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.grey[900],
                    shadowColor: Colors.yellow,
                    elevation: 5,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: OutlinedButton(
                        onPressed: () async {
                          await Provider.of<Auth>(context, listen: false)
                              .signInWithGoogle();
                        },
                        child: Text(
                          'Google',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.only(
                              left: 35, right: 35, top: 5, bottom: 5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.only(left: 35, right: 35),
                      child: TextFormField(
                        onSaved: (value) {
                          _authData['email'] = value!;
                        },
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Invalid email!';
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            icon: Icon(Icons.perm_identity),
                            hintText: 'Email'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 35, right: 35),
                      child: TextFormField(
                        // controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            icon: Icon(Icons.account_circle_rounded),
                            hintText: 'Password'),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 5) {
                            return 'Password is too short!';
                          }
                        },
                        onSaved: (value) {
                          _authData['password'] = value!;
                        },
                      ),
                    ),
                  ]),
                ),
              ),

              Container(
                padding: EdgeInsets.only(right: 20),
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forget password ?',
                          style: TextStyle(color: Colors.grey),
                        )),
                    SizedBox(height: 10),
                    Card(
                      elevation: 4,
                      shadowColor: Colors.blue.shade500,
                      color: Colors.grey[850],
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blue.shade500, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: OutlinedButton(
                          onPressed: _submit,
                          child: Text(
                            'Log In',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.only(left: 35, right: 35)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignUpScreen.routeName);
                  },
                  child: Text(
                    'Create a new acount',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.yellow),
                  )),
              // SizedBox(height: 10),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SplashScreen.routeName);
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
