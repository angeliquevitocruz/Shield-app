import 'package:flutter/material.dart';
import 'package:healthdeclarationform/providers/contact_provider.dart';
import 'package:healthdeclarationform/providers/health_provider.dart';
import 'package:healthdeclarationform/providers/hhold_provider.dart';
import 'package:healthdeclarationform/providers/user_provider.dart';
import 'package:healthdeclarationform/screens/WelcomeScreen.dart';
import 'package:healthdeclarationform/screens/contactsform_screen.dart';
import 'package:healthdeclarationform/screens/scansave.dart';
import 'package:healthdeclarationform/screens/healthform_screen.dart';
import 'package:healthdeclarationform/screens/household.dart';
import 'package:healthdeclarationform/screens/login_screen.dart';
import 'package:healthdeclarationform/screens/registrationform_screen.dart';
import 'package:healthdeclarationform/screens/householdform_screen.dart';
import 'package:healthdeclarationform/services/householdManagement.dart';
import 'package:healthdeclarationform/screens/homepage.dart';
import 'package:provider/provider.dart';

void main() => {
      runApp(HealthForm()),
    };

class HealthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hholdfirestoreService = HholdFirestoreService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HouseholdProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthUserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DailyHealthProvider(),
        ), //creates an istance of the provider, it's going to pass into the widget tree and it's going to be accessible from anywhere below the main.dart
        StreamProvider(
          create: (context) => hholdfirestoreService.getMembers(),
          catchError: (BuildContext context, e) {
            print("Error:$e");
            return null;
          },
        ), //instance ng Streambuilder
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.cyan[800],
            buttonColor: Colors.black),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          HealthFormScreen.id: (context) => HealthFormScreen(),
          RegistrationForm.id: (context) => RegistrationForm(),
          HouseHoldScreen.id: (context) => HouseHoldScreen(),
          '/HouseHoldFormScreen': (context) => HouseHoldFormScreen(),
          '/ContactForm': (context) => ContactForm(),
          '/ScanningForm': (context) => ScanningForm(),
          '/HomePage': (context) => HomePage(),
          '/MyHomePage': (context) => MyHomePage(),
        },
      ),
    );
  }
}
