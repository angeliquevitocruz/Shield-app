import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthdeclarationform/Models/Contacts.dart';
import 'package:healthdeclarationform/screens/contactslist.dart';
import 'package:healthdeclarationform/services/contactListManagement.dart';
import 'package:uuid/uuid.dart';

class ContactProvider with ChangeNotifier {
  final contactListService = ContactFirestoreService();

  String _location;
  String _contactedId;
  DateTime _dateContacted;
  String _loggedInUser;
  String _traceId;
  String errormsg;

  var uuid = Uuid();

  //Getters = gets the value from the model to the private variable
  String get location => _location;
  String get contectedId => _contactedId;
  DateTime get dateContacted => _dateContacted;
  String get loggedInUser => _loggedInUser;
  Stream<List<Contacts>> contactListByUserId(String loggedInUserID) =>
      contactListService.getMyContacts(loggedInUserID);

  changeLocation(String value) {
    _location = value;
    //notifyListeners(); //if anybody widget is listening to the change it will get
  }

  changeContacted(String value) {
    _contactedId = value;
    // notifyListeners(); //if anybody widget is listening to the change it will get
  }

  changeDateContacted(DateTime value) {
    _dateContacted = value;
    // notifyListeners(); //if anybody widget is listening to the change it will get
  }

  setUserID(String value) {
    _loggedInUser = value;
  }

  saveContact() async {
    if (_location != null) {
      print('dito $dateContacted');
      print('private $_dateContacted');
      var newContact = Contacts(
          location: location,
          dateContacted: dateContacted,
          contactedId: contectedId,
          loggedInUser: loggedInUser,
          traceId: uuid.v4());
      await contactListService.saveContacted(newContact);
    } else {
      print('error');
      errormsg = "error";
    }
  }
}
