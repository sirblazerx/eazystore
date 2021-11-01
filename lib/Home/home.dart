import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eazystore/Custom/customlist.dart';
import 'package:eazystore/Custom/loading.dart';
import 'package:eazystore/Models/User.dart';
import 'package:eazystore/Services/authservice.dart';
import 'package:eazystore/Store/StorePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserM>(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Eazystore'),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueAccent),
                child: Text('Side Menu'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Stores'),
                  leading: Icon(Icons.store),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StorePageList()));
                  },
                ),
              ),
              // ListTile(
              //   title: Text('Login'),
              //   leading: Icon(Icons.store),
              //   onTap: () {
              //     // Navigator.of(context)
              //     //     .push(MaterialPageRoute(builder: (context) => SignIn()));
              //   },
              // ),
              // ListTile(
              //   title: Text('Ntah la nak'),
              //   leading: Icon(Icons.money),
              //   onTap: () {},
              // )
            ],
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Top Rated',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            ),
            Divider(),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('Store').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) return Loading();

                  return Expanded(
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        // scrollDirection: Axis.horizontal,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          DocumentSnapshot stores = snapshot.data.docs[index];

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 20.0),
                            child: InkWell(
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) =>
                                //         VDonation(donationid: donate.id)));
                              },
                              child: CustomListTile(
                                onTap: () {
                                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => VDonation(donationid: donate.id)));
                                },
                                user: stores['Owner'],
                                description: stores['StoreLocation'],
                                thumbnail: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent),
                                  child: Container(
                                      constraints: BoxConstraints(
                                          minHeight: 100,
                                          minWidth: 100,
                                          maxWidth: 200,
                                          maxHeight: 160),
                                      child: Icon(Icons.person)),
                                ),
                                title: stores['StoreName'],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
