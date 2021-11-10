import 'package:eazystore/Custom/loading.dart';
import 'package:eazystore/Models/User.dart';
import 'package:eazystore/Services/UserDB.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileList extends StatefulWidget {
  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserM>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white60,
        body: StreamBuilder<UserData>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserData _data = snapshot.data;

                return ListView(
                  children: <Widget>[
                    Column(
                      children: [
                        SizedBox(height: 20.0),
                        Image.network(_data.profilepic),
                        Card(
                          child: ListTile(
                            leading: Text(
                              'Name :',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            title: Text(_data.name,
                                style: TextStyle(fontSize: 15.0)),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: Text(
                              'Phone Number :',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            title: Text(_data.contact,
                                style: TextStyle(fontSize: 15.0)),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: Text(
                              'AccType :',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            title: Text(_data.acctype,
                                style: TextStyle(fontSize: 15.0)),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Loading();
              }
            }),
      ),
    );
  }
}
