import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthdeclarationform/components/rounded_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:healthdeclarationform/screens/scansave.dart';

final _auth = FirebaseAuth.instance;
FirebaseUser loggedInUser;

class ContactForm extends StatefulWidget {
  final String getUser;

  ContactForm({this.getUser});
  
  @override
  _ContactFormState createState() => _ContactFormState();
}


class _ContactFormState extends State<ContactForm> {
  static get getUser => getUser;


  @override
  void initState() {
    getCurrentUser();
    super.initState();
  
  }

  void getCurrentUser() async {
      try{
        FirebaseUser user = await _auth.currentUser();
          if(user!=null){
            setState(() {
              loggedInUser = user;
            });
             
          }else {
             PlatformException(code: "-1", message: "error assign uid");
          }
        
        //print(loggedInUser.email);
      } on PlatformException catch(e){
        print(e.code);
      }
  }

 
  @override
  Widget build(BuildContext context) {
     String qrData = loggedInUser.email != null ? loggedInUser.email : getUser;
    
     // var userData = Provider.of<AuthUserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Code'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                QrImage(
                    //plce where the QR Image will be shown
                    data: qrData,
                  ),
                SizedBox(height: 20.0,),
                RoundedButton(
                  title: 'Scan QR Code',
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScanningForm()));
                  },
                  textColor: Colors.black,
                ),
              ],
              
            ),
            
          ),
        ),
      );
   }
}