import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:test_app/models/http_exception.dart';

class Auth with ChangeNotifier {
  late String _userId;
  late String _token;
  late DateTime _expireDate;

  //Auth(this._expireDate,this._token,_userId) : _userId = _userId;

  // check the validate of tokan

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expireDate != null &&
        _expireDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> authentcate(var email, var password, String token) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/$token?key=AIzaSyCkgZ41_zHUAexyd-RR6fYaVxzi0nyXLys';

    try {
      final respose = await http.post(Uri.parse(url),
          body: convert.json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      final responseData = convert.json.decode(respose.body);
      //handel spacific error and throw it
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      //success  authentiaction opration
      _token = "responseData['idToken']";
      _userId = responseData['localId'];
      _expireDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(var email, var password) async {
    return authentcate(email, password, 'accounts:signUp');
  }

  Future<void> signin(var email, var password) async {
    return authentcate(email, password, 'accounts:signInWithPassword');
  }

  void logout() {
    _userId = null.toString();
    _token = null.toString();
    _expireDate = _expireDate.isBefore(DateTime.now()) as DateTime;

    //for login with google
    GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();

    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    final user = await GoogleSignIn().signIn();

    if (user == null) {
      return;
    } else {
      // get user credential to sign in with google
      final googleAuth = await user.authentication;
      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // to see it in firebase
      final firebaseInstance =
          await FirebaseAuth.instance.signInWithCredential(googleCredential);

      print("User Email ${firebaseInstance.user}");
    }
  }

  Future<void>signInWithFacebook() async {
    // facebook login instance
    final user = await FacebookLogin().logIn();

    if (user.status != FacebookLoginStatus.success) {
      print("there is no facebooke account");
      return;
    } else {
      final accessToken = user.accessToken!.token;
      final credential = FacebookAuthProvider.credential(accessToken);
      final firebaseInstance =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print(firebaseInstance.user);
    }
  }
}
