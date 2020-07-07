import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthdeclarationform/providers/health_provider.dart';
import 'package:intl/intl.dart';
import 'package:healthdeclarationform/components/rounded_button.dart';
import 'package:provider/provider.dart';
import 'homepage.dart';

final _firestore = Firestore.instance; //saving sa collections/table sa db
FirebaseUser loggedInUser;

class HealthFormScreen extends StatefulWidget {
  //static - means class-wide var and methods
  //naglagay ng static id dito para sa main id na lang ang tatawagin
  static String id = 'healthform_screen';
  @override
  _HealthFormScreen createState() => _HealthFormScreen();
}

class _HealthFormScreen extends State<HealthFormScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String placeTravelled;
  double temperature;
  bool _isDone = true;
  DateTime dateDaily = new DateTime.now();
  bool _isHeadAche = false;
  bool _isFever = false;
  bool _isWorked = false;
  bool _isContacted = false;
  bool _isSoreThroat = false;
  bool _isBodyPains = false;
  bool _isTravelled = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
      }
      print(loggedInUser);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //instance of the class in the provider
    var healthDec = Provider.of<DailyHealthProvider>(context);

    String _formatDate = new DateFormat.yMMMMd().format(dateDaily);
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Declaration Form"),
        //backgroundColor: Colors.teal,
        elevation: 10,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListTile(
                  title: TextFormField(
                    decoration: InputDecoration(
                      labelText: _formatDate,
                      hintText: 'Click the calendar to choose',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 27,
                      ),
                      prefixIcon: IconButton(
                        iconSize: 30,
                        onPressed: () async {
                          final DateTime pickedDate = await showDatePicker(
                            context: context,
                            initialDate: dateDaily,
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2200),
                          );

                          if (pickedDate != null) {
                            setState(() {
                              dateDaily = pickedDate;
                              healthDec.changeDateReported(dateDaily);
                            });
                          } else {
                            setState(() {
                              dateDaily = pickedDate;
                              healthDec.changeDateReported(dateDaily);
                            });
                            _showAlert(
                                context, "You chose to cancel datepicker");
                          }
                        },
                        icon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      temperature = double.parse(value);
                      healthDec.changeTemp(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Temperature',
                      labelStyle: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ListTile(
                  title: Text(
                    "Check/click the box if you are experiencing the following:",
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                CheckboxListTile(
                  title: Text(
                      'Are you experiencing sore throat?(Nakakaranas ka ba ng pananakit ng lalamunan/masakit lumunok?)'),
                  value: _isSoreThroat,
                  onChanged: (val) {
                    if (val) {
                      setState(() {
                        _isSoreThroat = val;
                        healthDec.changeIsSorethroat(
                            _isSoreThroat); //Meron nito para sa provider manotify din na nagchange
                      });
                    } else {
                      setState(() {
                        _isSoreThroat = val;
                        healthDec.changeIsSorethroat(
                            _isSoreThroat); //Meron nito para sa provider manotify din na nagchange
                      });
                    }
                  },
                  secondary: const Icon(Icons.notification_important),
                ),
                SizedBox(
                  height: 10.0,
                ),
                CheckboxListTile(
                  title: Text(
                      'Are you experiencing body pains?(Nakakaranas ka ba ng sakit ng katawan?)'),
                  value: _isBodyPains,
                  onChanged: (val) {
                    if (val) {
                      setState(() {
                        _isBodyPains = val;
                        healthDec.changeIsBodyPains(_isBodyPains);
                      });
                    } else {
                      setState(() {
                        _isBodyPains = val;
                        healthDec.changeIsBodyPains(_isBodyPains);
                      });
                    }
                  },
                  secondary: const Icon(Icons.notification_important),
                ),
                SizedBox(
                  height: 8.0,
                ),
                CheckboxListTile(
                  title: Text(
                      'Are you experiencing headache(Nakakaranas ka ba ng pananakit ng ulo?)'),
                  value: _isHeadAche,
                  onChanged: (val) {
                    if (val) {
                      setState(() {
                        _isHeadAche = val;
                        healthDec.changeIsHeadache(_isHeadAche);
                      });
                    } else {
                      setState(() {
                        _isHeadAche = val;
                        healthDec.changeIsBodyPains(_isHeadAche);
                      });
                    }
                  },
                  secondary: const Icon(Icons.notification_important),
                ),
                SizedBox(
                  height: 10.0,
                ),
                CheckboxListTile(
                  title: Text(
                      'Are you experiencing fever for the past few days (Nakakaranas ka ba ng lagnat sa mga nakalipas na araw)?'),
                  value: _isFever,
                  onChanged: (val) {
                    if (val) {
                      setState(() {
                        _isFever = val;
                        healthDec.changeIsFever(_isFever);
                      });
                    } else {
                      setState(() {
                        _isFever = val;
                        healthDec.changeIsFever(_isFever);
                      });
                    }
                  },
                  secondary: const Icon(Icons.notification_important),
                ),
                SizedBox(
                  height: 10.0,
                ),
                CheckboxListTile(
                  title: Text(
                      'Have you worked together or stayed in the same close environment of a confirmed COVID-19 case (May nakasama ka ba o nakatrabahong tao na kumpirmadong may COVID-19/may impeksyon ng coronavirus)?'),
                  value: _isWorked,
                  onChanged: (val) {
                    if (val) {
                      setState(() {
                        _isWorked = val;
                        healthDec.changeIsWork(_isWorked);
                      });
                    } else {
                      setState(() {
                        _isWorked = val;
                        healthDec.changeIsWork(_isWorked);
                      });
                    }
                  },
                  secondary: const Icon(Icons.notification_important),
                ),
                SizedBox(
                  height: 10.0,
                ),
                CheckboxListTile(
                  title: Text(
                      'Have you had any contact with anyone with fever, cough, colds, and sore throat in the past 2 weeks (Mayroon ka bang nakasama na may lagnat,ubo,sipon o sakit ng lalamunan sa nakalipas na dalawang (2) lingo)?'),
                  value: _isContacted,
                  onChanged: (val) {
                    if (val) {
                      setState(() {
                        _isContacted = val;
                        healthDec.changeIsContacted(_isContacted);
                      });
                    } else {
                      setState(() {
                        _isContacted = val;
                        healthDec.changeIsContacted(_isContacted);
                      });
                    }
                  },
                  secondary: const Icon(Icons.notification_important),
                ),
                SizedBox(
                  height: 10.0,
                ),
                CheckboxListTile(
                  title: Text(
                      'Have you travelled to any area in NCR aside from your home? Ikaw ba ay nagpunta sa iba pang parte ng NCR bukod sa iyong bahay)?'),
                  subtitle: TextFormField(
                    onChanged: (value) {
                      //placeTravelled = value;
                      healthDec.changePlace(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Where?',
                      labelStyle: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                  value: _isTravelled,
                  onChanged: (val) {
                    if (val) {
                      setState(() {
                        _isTravelled = val;
                        healthDec.changeIsTravelled(_isTravelled);
                      });
                    } else {
                      setState(() {
                        _isTravelled = val;
                        healthDec.changeIsTravelled(_isTravelled);
                      });
                    }
                  },
                  secondary: const Icon(Icons.notification_important),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ListTile(
                  title: RoundedButton(
                      title: 'Submit',
                      textColor: Colors.black,
                      onPressed: () {
                        // DateTime isDoneToday = DateTime.now();
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState.validate()) {
                          //you'd often call a server or save the information in a database.
                          _firestore.collection('dailyHealthDeclaration').add({
                            'DateReported': dateDaily,
                            'LoggedInUser': loggedInUser.email,
                            'IsBodyPains': _isBodyPains,
                            'IsContacted': _isContacted,
                            'IsFever': _isFever,
                            'IsHeadAche': _isHeadAche,
                            'IsSoreThroat': _isSoreThroat,
                            'IsTravelled': _isTravelled,
                            'IsWorked': _isWorked,
                            'PlaceTravelled': placeTravelled,
                            'isDoneToday': _isDone,
                            'Temperature': temperature,
                            'CreatedDate': DateTime.now()
                          });
                          //healthDec.saveDailyHealth();
                          _showAlert(context, 'You are done for today');
                          _formKey.currentState.reset();

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
                        } else {
                          _showAlert(context, 'Please complete the form!');
                        }
                      }),
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
      //duration: ,
    ),
  );
}
