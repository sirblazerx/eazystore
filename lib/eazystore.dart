import 'package:flutter/material.dart';

class Eazystore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(accentColor: Colors.lightBlueAccent),
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Text('Home Page'),
          ),
        ),
      ),
    );
  }
}
