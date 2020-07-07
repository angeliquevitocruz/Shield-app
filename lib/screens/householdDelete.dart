

import 'package:flutter/material.dart';
import 'package:healthdeclarationform/Models/Household.dart';
import 'package:healthdeclarationform/providers/hhold_provider.dart';
import 'package:provider/provider.dart';

class HouseholdDelete extends StatefulWidget {
  final HouseHold memberID;
  HouseholdDelete({this.memberID});
  @override
  _HouseholdDeleteState createState() => _HouseholdDeleteState();
}

class _HouseholdDeleteState extends State<HouseholdDelete> {


 
  @override
  Widget build(BuildContext context) {
     final provider = Provider.of<HouseholdProvider>(context);

    return AlertDialog(
      title: Text('Warning'),
      content: Text('Are you sure you want to delete this record?'),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            provider.removeMember(widget.memberID.householdID);
            print(widget.memberID.householdID);
            Navigator.of(context).pop(true);
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}
