import 'package:app/screen/event/Veventwithdraw.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class ProjectCheck extends StatefulWidget {

  final String userid;

  const ProjectCheck({Key key, this.userid}) : super(key: key);

  @override
  _ProjectCheckState createState() => _ProjectCheckState();
}

class _ProjectCheckState extends State<ProjectCheck> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(



        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,

          title: Text('My Project Status'),

        ),

        body:   StreamBuilder(
          stream:
          FirebaseFirestore.instance
              .collection('participants')
              .where('userid',isEqualTo: widget.userid )
              .snapshots(),

          builder: (context, snapshot) {



            return Card(
              child: ListView.builder(
                itemCount: snapshot?.data?.documents?.length ?? 0,
                itemBuilder: (context, index) {

                  DocumentSnapshot donate = snapshot.data.documents[index];


                  return Card(
                    child:InkWell(
                      onTap: () {
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => ( EvWithdraw(partid: donate.id,projectid : donate['projectid']) )));
                      },
                      child:



                           Column(

                            children: [


                              ListTile(

                                title: Text(donate['name'],textAlign: TextAlign.center,),
                                subtitle: Text(donate['contact'],textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                ),

                              ),
                              ListTile(

                                title: Text(donate['status'],textAlign: TextAlign.center,),
                                subtitle:Text(donate['projectid'],textAlign: TextAlign.center,) ,

                              ),



                            ],






                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),

      ),
    );
  }
}
