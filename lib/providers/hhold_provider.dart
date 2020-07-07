import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthdeclarationform/Models/Household.dart';
import 'package:healthdeclarationform/services/householdManagement.dart';
import 'package:uuid/uuid.dart';


class HouseholdProvider with ChangeNotifier{
  final householdService = HholdFirestoreService();
  //private variables that mirrors the model/ Put underscore to identify as a private variable.
  String _fullName;
  String _profession;
  String _age;
  String _loggedInUserID;
  String _householdID;
  var uuid = Uuid(); //this is for the uniqueid of the record. Initialize the package first.

  //Getters = gets the value from the model to the private variable
  String get fullName => _fullName;
  String get age => _age;
  String get profession => _profession;
  String get loggedInUserID => _loggedInUserID;
  Stream<List<HouseHold>> memberByUserId(String loggedInUserID) => householdService.getMyMembers(loggedInUserID);

  //Setters = sets the values state onchange
  changeFullName(String value){
    _fullName = value;
    notifyListeners(); //if anybody widget is listening to the change it will get
  }

  changeProfession(String value){
    _profession = value;
    notifyListeners();
  }


  changeAge(String value){
    _age = value;
    notifyListeners();
  }

  setUserID(String value){
    _loggedInUserID = value;
    
  }
   
   loadValues(HouseHold household){
     _fullName = household.fullName;
     _profession = household.profession;
     _age = household.age;
     _householdID = household.householdID;
   }

  saveHousehold(){
    if(_householdID == null){
      //Add member. generates unique id
      var newHousehold = HouseHold(fullName:fullName, profession:profession, age:age, loggedInUserID:loggedInUserID, householdID: uuid.v4());
      householdService.saveMember(newHousehold);
    } else {
      //Update
      var updatedHousehold = HouseHold(fullName:_fullName, profession:_profession, age:_age, loggedInUserID:loggedInUserID, householdID: _householdID);
      householdService.saveMember(updatedHousehold);
    }
    
  }

  removeMember(String householdID){
    householdService.removeMember(householdID);
  }
}