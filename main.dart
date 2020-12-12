import 'package:flutter/material.dart';
 

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar( 
          title: Text('Main Screen'),
        ),
        body: Center(
          child: Container(
            child: Text('You are currently in main page'),
             
          ),
        ),
      ),
    );
  }
}