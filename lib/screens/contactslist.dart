import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  String userid;
  ContactList({this.userid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact"),),
    );
  }
}