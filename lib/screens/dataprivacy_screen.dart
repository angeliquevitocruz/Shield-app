import 'package:flutter/material.dart';
import 'registrationform_screen.dart';

class DataPrivacyScreen extends StatefulWidget {
  //static - means class-wide var and methods
  //naglagay ng static id dito para sa main id na lang ang tatawagin
  static String id = 'householdfom_screen';
  @override
  _DataPrivacyScreen createState() => _DataPrivacyScreen();
}

class _DataPrivacyScreen extends State<DataPrivacyScreen> {
  bool isVal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Builder(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Data Privacy Act',
                style: TextStyle(fontSize: 20.0),
              ),
              CheckboxListTile(
                value: isVal,
                title: Text(
                    'I hereby authorize CENTURY PACIFIC FOOD, INC., to collect and process the data indicated herein for the purpose of effecting control of the COVID-19 infection. I understand that my personal information is protected by RA 10173, Data Privacy Act of 2012, and that I am required by RA 11469, Bayanihan to Heal as One Act, to provide truthful information. (See link below)'),
                subtitle: Text('Health Declaration Privacy Notice'),
                onChanged: (val) {
                  setState(() {
                    isVal = val;
                  });
                  if (isVal) {
                    print(isVal);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RegistrationForm(),
                      ),
                    );

                    // Navigator.of(context).pop();
                  } else {
                    _showAlert(context, 'Click if you agree with the terms');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_showAlert(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    ),
  );
}
