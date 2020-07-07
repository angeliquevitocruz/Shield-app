import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthdeclarationform/Models/Household.dart';
import 'package:healthdeclarationform/components/rounded_button.dart';
import 'package:healthdeclarationform/providers/hhold_provider.dart';
import 'package:healthdeclarationform/screens/homepage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'household.dart';

FirebaseUser loggedInUser;

class HouseHoldFormScreen extends StatefulWidget {
  //static - means class-wide var and methods
  //naglagay ng static id dito para sa main id na lang ang tatawagin
 static String id = 'householdfom_screen';

  final HouseHold member;

  HouseHoldFormScreen([this.member]); //square brackets kasi pwedeng optional ang pag pasa dito ng laman para sa add
  
  @override
  _HouseHoldFormScreen createState() => _HouseHoldFormScreen();
}


class _HouseHoldFormScreen extends State<HouseHoldFormScreen> {
  final fullNameController = TextEditingController();
  final professionController = TextEditingController();
  final ageController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  DateTime dateDaily = new DateTime.now();

  @override
  void dispose() {
    fullNameController.dispose();
    professionController.dispose();
    ageController.dispose();
    super.dispose();
  }
  
  @override
    void initState() {
      //Set the textfields when the page loads
      if(widget.member == null){
        //new record. clear fields lang muna
        
        fullNameController.text="";
        professionController.text="";
        ageController.text="";

        //while this updates the providers but with blank member
        new Future.delayed(Duration.zero, (){
          final hholdProvider = Provider.of<HouseholdProvider>(context, listen: false);
          hholdProvider.loadValues(HouseHold());
        });

      } else {
        //Existing record
        //this updates the controllers
        fullNameController.text = widget.member.fullName;
        professionController.text = widget.member.profession;
        ageController.text = widget.member.age;
    
        //while this updates the providers with the given Member id
        new Future.delayed(Duration.zero, (){
          final hholdProvider = Provider.of<HouseholdProvider>(context, listen: false);
          hholdProvider.loadValues(widget.member);
        });
        
      }
      super.initState();
      getCurrentUser();
    }

    void getCurrentUser() async {
      try{
        final user = await _auth.currentUser();
        
        if(user!=null){
          setState(() {
            loggedInUser = user;
          });
        }
        print(loggedInUser);
      }
      catch(e){
        print(e);
      }
    }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final hholdProvider = Provider.of<HouseholdProvider>(context);
    String _formatDate = new DateFormat.yMMMMd().format(dateDaily);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Household Declaration"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.list,
              color: Colors.white,
            ),
            onPressed: (){
              Navigator.pushNamed(context, HouseHoldScreen.id);
            },
          ),
        ],
        elevation: 10,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.home), onPressed: () {  
            //Navigator.pushNamed(context, LandingPageScreen.id);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
           // Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // ListTile(
                //   title: Text(_formatDate,
                //     style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 20,
                //         color: Colors.blueGrey
                //       ),
                //   ),
                // ),
                // SizedBox(
                //   height: 20.0,
                // ),
                Container(
                  child: Center(
                      child: EmptyState(
                        title: 'Include all your household members',
                      ),
                    ),
                ),
                TextFormField(
                  controller: fullNameController,
                  validator: (val){
                    if (val.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                  },
                  onChanged: (value) {
                    hholdProvider.changeFullName(value);
                   
                  },
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Full Name',
                    icon: Icon(Icons.perm_identity),
                    isDense: true,
                  ),
                ),
                Container(
                  height: 8,
                ),
                TextFormField(
                  controller: professionController,
                  validator: (val){
                    if (val.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                  },
                  onChanged: (value) => hholdProvider.changeProfession(value),
                  decoration: InputDecoration(
                    labelText: 'Profession',
                    hintText: 'Profession',
                    icon: Icon(Icons.business_center),
                    isDense: true,
                  ),
                ),
                Container(
                  height: 8,
                ),
                TextFormField(
                  controller: ageController,
                  validator: (val){
                    if (val.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                  },
                  onChanged: (value) => hholdProvider.changeAge(value),
                  decoration: InputDecoration(
                    labelText: 'Age',
                    hintText: 'Age',
                    icon: Icon(Icons.confirmation_number),
                    isDense: true,
                  ),
                ),
                Container(
                  height: 16,
                ),
                RoundedButton(
                  title: 'Add to list',
                  textColor: Colors.black,
                  onPressed: () {
                    
                    hholdProvider.setUserID(loggedInUser.email);
                    if (_formKey.currentState.validate()) {
                      hholdProvider.saveHousehold(); //we call the function from the provider.
                      _formKey.currentState.reset();
                      _showAlert(context,'Family member Added. View List');
                      // Navigator.of(context).pop();
                      _clearFields();
                    } else {
                      _showAlert(context,'Incomplete form!');  
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _clearFields(){
    fullNameController.clear();
    professionController.clear();
    ageController.clear();
  }
}



_showAlert(BuildContext context, String message) {
 Scaffold.of(context).showSnackBar(
   SnackBar(
     content: Text(message, textAlign: TextAlign.center,),
     backgroundColor: Colors.redAccent,
     
   ),
 );
}

class EmptyState extends StatelessWidget {
  final String title;//, message;
  EmptyState({this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 16,
      color: Theme.of(context).cardColor.withOpacity(.95),
      shadowColor: Theme.of(context).accentColor.withOpacity(.10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 20.0,
            ),
           
          ],
        ),
      ),
    );
  }
}
