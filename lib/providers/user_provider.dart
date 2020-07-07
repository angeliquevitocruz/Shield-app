import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthdeclarationform/Models/User.dart';
import 'package:healthdeclarationform/screens/homepage.dart';
import 'package:healthdeclarationform/services/userManagement.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AuthUserProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final userService = UserManagement();

  //private variables that mirrors the model/ Put underscore to identify as a private variable.
  String _uID;
  String _userEmail;
  String _password;
  String _validId;
  String _address;
  String _validIdNum;
  String _contactNum;
  bool _isAgree;
  bool _isGuest;
  String errorMessages = "";
  var uuid = Uuid();

  //Getters = gets the value from the model to the private variable
  String get userEmail => _userEmail;
  String get password => _password;
  String get validId => _validId;
  String get address => _address;
  String get validIdNum => _validIdNum;
  String get contactNum => _contactNum;
  bool get isAgree => _isAgree;
  bool get isGuest => _isGuest;

  //Setters = sets the values state onchange
  changeUserEmail(String value) {
    _userEmail = value;
  }

  changePassword(String value) {
    _password = value;
  }

  changeValidId(String value) {
    _validId = value;
  }

  changeValidIdNum(String value) {
    _validIdNum = value;
  }

  changeAddress(String value) {
    _address = value;
  }

  changeContactNum(String value) {
    _contactNum = value;
  }

  changeIsAgree(bool value) {
    _isAgree = value;
  }

  changeIsGuest(bool value) {
    _isGuest = value;
  }

  loadUserValues(User user) {
    _userEmail = user.userEmail;
    _password = user.password;
    _address = user.address;
    _validId = user.validId;
    _validIdNum = user.validIdNum;
    _contactNum = user.contactNum;
  }

  registerUser() async {
    if (_userEmail != null && _password != null && _isGuest != null) {
      try {
        print(1);
        AuthResult authResult = await _auth.createUserWithEmailAndPassword(
            email: _userEmail, password: _password);
        var user = User(
            userEmail: authResult.user.email,
            password: password,
            validId: validId,
            address: address,
            validIdNum: validIdNum,
            contactNum: contactNum,
            isAgree: isAgree,
            isGuest: isGuest,
            uID: uuid.v4());

        await userService.saveNewUser(user);
      } on PlatformException catch (error) {
        print(error.message);
        errorMessages = error.message;
      }
    } else {
      print('error ');
    }
  }

  postLoginforEmployee(context) async {
    print(_userEmail);
    print(_password);

    final response = await http.post(
      'https://azureadauth20200702044751.azurewebsites.net/api/AzureADAuth',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': _userEmail,
        'password': _password
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      if (body != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage(token: body,)));
      }
      print(body);

      return body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.body);
      _showAlert(context, response.body);
    }
  }

  _showAlert(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
