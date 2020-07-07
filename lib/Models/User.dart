class User {
  String uID;
  String userEmail;
  String password;
  String validId;
  String address;
  String validIdNum;
  String contactNum;
  bool isAgree;
  bool isGuest;
  
 
  User({this.uID, this.userEmail, this.password, this.validIdNum, this.validId,
      this.address, this.contactNum, this.isAgree, this.isGuest});

Map<String, dynamic> toMap(){
    return{
      'UserID': uID,
      'Email': userEmail,
      'Password': password,
      'ValidId': validId,
      'Address': address,
      'ValidIdNum': validIdNum,
      'ContactNum': contactNum,
      'IsAgree': isAgree,
      'IsGuest': isGuest,
      'CreatedDate': DateTime.now() 
    };
  }

  //Para to sa loading ng data. So from the database, the data we will  collect is a map. We have to turn it into an object so we can display it in our UI.
  User.fromFirestore(Map<String, dynamic> firestore)
    : userEmail = firestore['Email'],
      password = firestore['Password'],
      validId = firestore['ValidId'],
      address = firestore['Address'],
      validIdNum = firestore['ValidIdNum'],
      contactNum = firestore['ContactNum'],
      isAgree = firestore['IsAgree'],
      isGuest = firestore['IsGuest'],
      uID = firestore['UserID'];


}