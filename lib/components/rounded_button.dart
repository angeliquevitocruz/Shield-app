import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.title, this.color, @required this.onPressed,this.textColor, this.fontSize});

  final Color color;
  final String title;
  final Function onPressed;
  final Color textColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(2.0), 
        
        
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            side: BorderSide(
            color: Colors.teal,
            width: 1,
            
            style: BorderStyle.solid
          ), borderRadius: BorderRadius.circular(0.01)),
          elevation: 5.0,
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(title,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontFamily: 'Monserrat Medium'
              )),
        ),
      ),
    );
  }
}
