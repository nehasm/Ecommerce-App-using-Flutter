import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/httpexception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expirydate;
  String _userId;
  Timer _authTimer;
  String get token {
      if(_expirydate!=null
      && _expirydate.isAfter(DateTime.now())
      && _token!=null){
        return _token;
      }
      return null;
    }
  bool get isAuth{
    return token!=null;
  }
  String get userId {
    return _userId;
  }
  Future<void> _authenticate(String email,String password,String urlsegment) async{
    final  url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlsegment?key=AIzaSyDGkRMzIXhraf1z4dA9q8SU9L1DpVXJNL0';
    try{
      final response = await http.post(url,
    body: json.encode(
      {
      'email':email,
      'password':password,
      'returnSecureToken':true,
      },
      ),
      );
      final responseData = json.decode(response.body);
      if(responseData['error']!=null){
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expirydate = DateTime.now()
      .add(Duration(
        seconds: int.parse(
        responseData['expiresIn'],
        ),
        ),
        );
      _autologout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({'token':_token,'userId':_userId,'expiryDate':_expirydate.toIso8601String(),});
      prefs.setString('userData', userData);
    } catch(error){
      throw error;
    } 
  }
  Future<void> signup(String email,String password) async{
    return _authenticate(email, password,'signUp');
  }
  Future<void> login(String email,String password) async{
    return _authenticate(email, password, 'signInWithPassword');

  }
  Future<bool> tryAutologin() async{
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedData = json.decode(prefs.getString('userData')) as Map<String,Object>;
    final expiryDate = DateTime.parse(extractedData['expiryDate']);

    if(expiryDate.isBefore(DateTime.now())){
      return false;
    }
    _token = extractedData['token'];
    _userId = extractedData['userId'];
    _expirydate = expiryDate;
    notifyListeners();
    _autologout();
    return true;
  }
  Future<void> logout() async {
    _token = null;
    _userId=null;
    _expirydate = null;
    if (_authTimer!=null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove(key)
    prefs.clear();
  }
  void _autologout() {
    if (_authTimer!=null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expirydate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry),logout);
  }
}