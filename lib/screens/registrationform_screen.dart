import 'package:flutter/material.dart';
import 'package:healthdeclarationform/Models/User.dart';
import 'package:healthdeclarationform/components/rounded_button.dart';
import 'package:healthdeclarationform/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'WelcomeScreen.dart';

class RegistrationForm extends StatefulWidget {
  //static - means class-wide var and methods
  //naglagay ng static id dito para sa main id na lang ang tatawagin
  static String id = 'registrationform_screen';
  @override
  _RegistrationFormScreen createState() => _RegistrationFormScreen();
}

class _RegistrationFormScreen extends State<RegistrationForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final idController = TextEditingController();
  final idNumController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    idController.dispose();
    idNumController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    emailController.text = "";
    passwordController.text = "";
    addressController.text = "";
    idController.text = "";
    idNumController.text = "";
    mobileController.text = "";

    //while this updates the providers but with blank member
    new Future.delayed(Duration.zero, () {
      final userProvider =
          Provider.of<AuthUserProvider>(context, listen: false);
      userProvider.loadUserValues(User());
    });

    super.initState();
  }

  bool isGuest = true;
  bool showSpinner = false;
  bool isAgree = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthUserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Registration Form",
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true, //removes back button in the appbar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        //wrap the whole column into singleChildScrollView para di lumabas ung error.
        // ibig sabihn para magkasya sya sa scree, gagawing scrollable
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CheckboxListTile(
                  title: Text('Are you a CPFI Guest?'),
                  value: isGuest,
                  onChanged: (val) {
                    if (val) {
                      setState(() {
                        isGuest = val;
                        userProvider.changeIsGuest(isGuest);
                     });
                    } else {
                      setState(() {
                        isGuest = val;
                        userProvider.changeIsGuest(isGuest);
                         
                      });
                    }
                    print(val);
                  },
                  secondary: const Icon(Icons.notification_important),
                ),
                SizedBox(
                  height: 8.0,
                ),
                ListTile(
                  title: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      // value.contains('@') ? null : 'Email is invalid'
                      if (!value.contains('@')) {
                        return 'Email is bady formated, please put a valid email';
                      }
                      return null;
                    },
                    onChanged: (value) => userProvider.changeUserEmail(value),
                    decoration: InputDecoration(
                      labelText: 'Email address*',
                      labelStyle: TextStyle(fontWeight: FontWeight.normal),
                      icon: Icon(Icons.perm_identity),
                      isDense: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                ListTile(
                  title: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value.length < 6) {
                        return 'Password must be atleast 6 characters';
                      }
                      return null;
                    },
                    onChanged: (value) => userProvider.changePassword(value),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontWeight: FontWeight.normal),
                      icon: Icon(Icons.lock),
                      isDense: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                ListTile(
                  title: TextFormField(
                    controller: addressController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (value) => userProvider.changeAddress(value),
                    decoration: InputDecoration(
                      labelText: 'Present Address',
                      labelStyle: TextStyle(fontWeight: FontWeight.normal),
                      icon: Icon(Icons.home),
                      isDense: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                ListTile(
                  title: TextFormField(
                    controller: idController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (value) => userProvider.changeValidId(value),
                    decoration: InputDecoration(
                      labelText: 'Valid ID',
                      labelStyle: TextStyle(fontWeight: FontWeight.normal),
                      icon: Icon(Icons.portrait),
                      isDense: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                ListTile(
                  title: TextFormField(
                    controller: idNumController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (value) => userProvider.changeValidIdNum(value),
                    decoration: InputDecoration(
                      labelText: 'ID number',
                      labelStyle: TextStyle(fontWeight: FontWeight.normal),
                      icon: Icon(Icons.portrait),
                      isDense: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                ListTile(
                  title: TextFormField(
                    controller: mobileController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (value) => userProvider.changeContactNum(value),
                    decoration: InputDecoration(
                      labelText: 'Mobile No./Contact No.',
                      labelStyle: TextStyle(fontWeight: FontWeight.normal),
                      icon: Icon(Icons.contact_phone),
                      isDense: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Checkbox(
                        value: isAgree,
                        onChanged: (value) {
                          if (value) {
                            setState(() {
                              isAgree = value;
                              userProvider.changeIsAgree(isAgree);
                            });
                          } else {
                            setState(() {
                              isAgree = value;
                              userProvider.changeIsAgree(isAgree);
                            });
                          }
                        },
                      ),
                      Expanded(
                        child: Text(
                            "I hereby authorize CENTURY PACIFIC FOOD, INC., to collect and process the data indicated herein for the purpose of effecting control of the COVID-19 infection. I understand that my personal information is protected by RA 10173, Data Privacy Act of 2012, and that I am required by RA 11469, Bayanihan to Heal as One Act, to provide truthful information."),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: RoundedButton(
                    title: 'Save',
                    textColor: Colors.black,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        print(userProvider.errorMessages);
                        if (userProvider.errorMessages != ""){
                          _showAlert(context, userProvider.errorMessages);
                        } else 
                        {
                          userProvider.registerUser();
                          _formKey.currentState.reset();
                          _showAlert(context, 'Record saved');
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, WelcomeScreen.id);
                        }
                        
                      } else {
                        _showAlert(context, 'Please complete the form!');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_showAlert(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.redAccent,
    ),
  );
}
