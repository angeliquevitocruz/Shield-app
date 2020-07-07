class Contacts {
  String contactedId;
  String location;
  DateTime dateContacted;
  String loggedInUser;
  String traceId;

  Contacts({this.contactedId,this.dateContacted,this.location,this.loggedInUser,this.traceId});

  Map<String, dynamic> toMap(){
    return{
      'DateReported': dateContacted,
      'LoggedInUser' : loggedInUser,
      'Location': location,
      'PersonContacted':  contactedId,//contact.contactID,
      'TraceId': traceId,
      'CreatedDate': DateTime.now()
    };
  }


  Contacts.fromFirestore(Map<String, dynamic> firestore)
    : dateContacted = firestore['DateReported'],
      location = firestore['Location'],
      loggedInUser = firestore['LoggedInUser'],
      traceId = firestore['TraceId'],
      contactedId = firestore['PersonContacted'];
}