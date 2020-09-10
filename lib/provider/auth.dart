import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  // Auth(
  //   this._token,
  //   this._expiryDate,
  //   this._userId,
  // );
  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDSmnKWthAWB8Kog3e9foUj3a-EAWDyCs8';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signin(String email, String password) async {
    print("pressed signin");
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> signup(String email, String password) async {
    print("pressed signup");
    return _authenticate(email, password, 'signUp');
  }
}
