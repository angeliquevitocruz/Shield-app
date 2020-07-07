import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthdeclarationform/components/rounded_button.dart';

import 'WelcomeScreen.dart';
import 'contactsform_screen.dart';
import 'healthform_screen.dart';
import 'householdform_screen.dart';


final _auth = FirebaseAuth.instance;
FirebaseUser loggedInUser;

class HomePage extends StatefulWidget {
  final String token;

  HomePage({this.token});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
      } else {
        PlatformException(code: "-1", message: "error assign uid");
      }
    } on PlatformException catch (e) {
      print(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text(
          'Home', //Text(loggedInUser.email != null ? 'Welcome ${loggedInUser.email}' : "",
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
        //centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            label: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).pop();
              Navigator.pushNamed(context, WelcomeScreen.id);
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          padding: const EdgeInsets.all(
            45.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image(
                height: 140.0,
                width: 40.0,
                image: AssetImage('images/logo2.jpg'),
                fit: BoxFit.scaleDown,
                colorBlendMode: BlendMode.darken,
              ),
              SizedBox(
                height: 40.0,
              ),
              RoundedButton(
                title: 'Daily Health Declaration',
                fontSize: 19.0,
                textColor: Colors.black,
                onPressed: () {
                  //Navigator.of(context).pop();
                  Navigator.pushNamed(context, HealthFormScreen.id);
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              RoundedButton(
                title: 'Household Declaration',
                fontSize: 19.0,
                textColor: Colors.black,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HouseHoldFormScreen()));
                  
                },
              ),
              RoundedButton(
                title: 'Contact Tracing',
                textColor: Colors.black,
                fontSize: 19.0,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ContactForm(
                            getUser: loggedInUser.email,
                          )));
                  // Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
