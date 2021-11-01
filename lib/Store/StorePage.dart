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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'lib/Assets/download.png',
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text('This is a store')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
