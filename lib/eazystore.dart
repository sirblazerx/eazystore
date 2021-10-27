import 'package:eazystore/Home/home.dart';
import 'package:eazystore/Models/User.dart';
import 'package:eazystore/Services/authservice.dart';
import 'package:eazystore/Wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Eazystore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return StreamProvider<UserM>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: SafeArea(
          child: Wrapper(),
        ),
      ),
    );
  }
}
