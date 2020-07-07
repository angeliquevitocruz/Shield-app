import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthdeclarationform/Models/Household.dart';
import 'package:healthdeclarationform/providers/hhold_provider.dart';
import 'package:healthdeclarationform/screens/householdDelete.dart';
import 'package:healthdeclarationform/screens/householdform_screen.dart';
import 'package:provider/provider.dart';

final _auth = FirebaseAuth.instance;
FirebaseUser loggedInUser;

class HouseHoldScreen extends StatefulWidget {
  static String id = 'household_screen';
  @override
  _HouseHoldScreen createState() => _HouseHoldScreen();
}

class _HouseHoldScreen extends State<HouseHoldScreen> {
  bool isEditing = false;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
      } else {
        PlatformException(code: "-1", message: "error assign uid");
      }
    } on PlatformException catch (e) {
      print(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
  //instance of the class in the provider
    var memberList = Provider.of<HouseholdProvider>(context);

    return Scaffold(
      appBar:
          AppBar(title: Text('List of household member'), centerTitle: true),
      body: StreamBuilder<List<HouseHold>>(
          stream: memberList.memberByUserId(loggedInUser.email),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  //loader
                  backgroundColor: Colors.lightBlueAccent,
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                print('count: ${snapshot.data.length}');
                var member = snapshot.data[index];
                return Dismissible(
                  key: ValueKey(member.householdID),
                  direction: DismissDirection.startToEnd,
                  confirmDismiss: (dismiss) async {
                    final result = await showDialog(
                        context: context,
                        builder: (_) => HouseholdDelete(
                              memberID: member,
                            ));
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  child: ListTile(
                    title: Text(member.fullName),
                    subtitle: Text("Profession: ${member.profession}"),
                    trailing: Text("Age: ${member.age}"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HouseHoldFormScreen(member)));
                    },
                  ),
                );
              },
            );
          }),
    );
  }
}
