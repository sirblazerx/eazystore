import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ForgotPassword extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  String email;

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Reset Your Password"),
          ),
          // resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Reset Password',
                      style: TextStyle(fontSize: 40.0),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Enter your email',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Email',
                          ),
                        ),
                      ],
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      color: Color(0xff447def),
                      onPressed: () {
                        resetPassword(email);
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.SUCCES,
                          animType: AnimType.SCALE,
                          title: 'Email Sent',
                          desc: 'Check your email to reset password!',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        )..show();
                      },
                      child: Text(
                        'Reset Password',
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
