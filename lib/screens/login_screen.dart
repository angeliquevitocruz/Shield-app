import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> futureAlbum;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('1'),
      ),
      body: FutureBuilder<String>(
        //future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text('token');
          } else {
            return CircularProgressIndicator();
            //return Text("${snapshot.error}");
          }
        },
      ),
    );
  }
}
