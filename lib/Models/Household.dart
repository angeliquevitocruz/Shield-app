class HouseHold {
  final String fullName;
  final String profession;
  final String age;
  final String householdID;
  String loggedInUserID;

  HouseHold({this.fullName, this.profession, this.age, this.householdID, this.loggedInUserID});
  //Para sa saving ng data. We will turn our object into a map, so that the database can read it properly
  Map<String, dynamic> toMap(){
    return{
      'LoggedInUser':loggedInUserID,
      'DateCreated': DateTime.now(),
      'HHFullName': fullName,
      'HHOccupation': profession,
      'HHAge': age,
      'HouseholdID': householdID
    };
  }

  //Para to sa loading ng data. So from the database, the data we will  collect is a map. We have to turn it into an object so we can display it in our UI.
  HouseHold.fromFirestore(Map<String, dynamic> firestore)
    : fullName = firestore['HHFullName'],
      profession = firestore['HHOccupation'],
      age = firestore['HHAge'],
      loggedInUserID = firestore['LoggedInUser'],
      householdID = firestore['HouseholdID'];
}
