class DailyHealth {
  double temperature;
  String placeTravelled;

  bool isDone = true;
  bool isHeadAche = false;
  bool isFever = false;
  bool isWorked = false;
  bool isContacted = false;
  bool isSoreThroat = false;
  bool isBodyPains = false;
  bool isTravelled = false;
  String loggedInUser;
  String dailyRecordID;
  DateTime dateReported;

  DailyHealth(
      {this.temperature,
      this.placeTravelled,
      this.isDone,
      this.isHeadAche,
      this.isBodyPains,
      this.isContacted,
      this.isFever,
      this.isSoreThroat,
      this.isTravelled,
      this.isWorked,
      this.loggedInUser,
      this.dailyRecordID,
      this.dateReported});

      
  //for saving
  Map<String, dynamic> toMap() {
    return {
      'DateReported': dateReported,
      'LoggedInUser': loggedInUser,
      'IsBodyPains': isBodyPains,
      'IsContacted': isContacted,
      'IsFever': isFever,
      'IsHeadAche': isHeadAche,
      'IsSoreThroat': isSoreThroat,
      'IsTravelled': isTravelled,
      'IsWorked': isWorked,
      'PlaceTravelled': placeTravelled,
      'isDoneToday': isDone,
      'Temperature': temperature,
      'CreatedDate': DateTime.now()
    };
  }
}
