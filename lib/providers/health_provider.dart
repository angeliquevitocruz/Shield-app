import 'package:flutter/cupertino.dart';
import 'package:healthdeclarationform/Models/DailyHealth.dart';
import 'package:healthdeclarationform/services/healthdecManagement.dart';
import 'package:uuid/uuid.dart';

class DailyHealthProvider with ChangeNotifier {
//initialize the service
  final healtservice = HealthFirestoreServices();

//Private vars
  double _temperature;
  String _placeTravelled;
  bool _isDone;
  bool _isHeadAche;
  bool _isFever;
  bool _isWorked;
  bool _isContacted;
  bool _isSoreThroat;
  bool _isBodyPains;
  bool _isTravelled;
  String _loggedInUser;
  DateTime _dateReported;
  String _dailyRecordID;

  var uuid = Uuid();

//getters = gets the values from the model to the private variable
  double get temperature => _temperature;
  String get placetravelled => _placeTravelled;
  String get loggedInUser => _loggedInUser;
  DateTime get dateReported => _dateReported;
  bool get isDone => _isDone;
  bool get isHeadAche => _isHeadAche;
  bool get isFever => _isFever;
  bool get isWorked => _isWorked;
  bool get isContacted => _isContacted;
  bool get isSoreThroat => _isSoreThroat;
  bool get isBodyPains => _isBodyPains;
  bool get isTravelled => _isTravelled;

//Setters = sets the value onchange state; notifyListeners() = put this if your are updating the record. 
  changeDateReported(DateTime value) {
    _dateReported = value;
  }

  changeTemp(String value) {
    _temperature = double.parse(value);
  }

  changePlace(String value) {
    _placeTravelled = value;
  }

  changeIsDone(bool value) {
    _isDone = value;
  }

  changeIsHeadache(bool value) {
    _isHeadAche = value;
  }

  changeIsFever(bool value) {
    _isFever = value;
  }

  changeIsWork(bool value) {
    _isWorked = value;
  }

  changeIsContacted(bool value) {
    _isContacted = value;
  }

  changeIsSorethroat(bool value) {
    _isSoreThroat = value;
  }

  changeIsBodyPains(bool value) {
    _isBodyPains = value;
  }

  changeIsTravelled(bool value) {
    _isTravelled = value;
  }

//Save record
  saveDailyHealth() async {
    if (_dailyRecordID == null) {
      var dailyHealth = DailyHealth(
          dateReported: dateReported,
          temperature: temperature,
          placeTravelled: placetravelled,
          isDone: isDone,
          isHeadAche: isHeadAche,
          isBodyPains: isBodyPains,
          isContacted: isContacted,
          isFever: isFever,
          isSoreThroat: isSoreThroat,
          isTravelled: isTravelled,
          isWorked: isWorked,
          loggedInUser: loggedInUser,
          dailyRecordID: uuid.v4());
    //call to db save function
      healtservice.saveDailyHealth(dailyHealth);
    }
  }
}
