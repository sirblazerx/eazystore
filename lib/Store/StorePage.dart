import 'package:flutter/material.dart';

class StorePageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('My Stores'),
          centerTitle: true,
        ),
        body: Container(
          child: Text('Anda sampei ke Page Store'),
        ),
      ),
    );
  }
}
