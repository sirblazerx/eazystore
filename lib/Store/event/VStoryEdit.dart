// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eazystore/Custom/loading.dart';
import 'package:eazystore/Models/User.dart';
import 'package:eazystore/Store/event/EditStore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VStoryEdit extends StatefulWidget {
  final String storyid;

  VStoryEdit({Key key, @required this.storyid}) : super(key: key);

  @override
  _VStoryEditState createState() => _VStoryEditState();
}

class _VStoryEditState extends State<VStoryEdit> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserM>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Story'),
          backgroundColor: Colors.pinkAccent,
          elevation: 0.0,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Store')
                .doc(widget.storyid)
                .snapshots(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              DocumentSnapshot _data = snapshot.data;

              Widget mediaGetter() {
                if (_data['Img'] != '') {
                  return Image.network(_data['Img']);
                }
                // else if (snapshot.data['uyoutube'] != null){
                //   String vid;

                //   // Convert Video to ID
                //   vid = YoutubePlayer.convertUrlToId(snapshot.data['uyoutube']) ;

                //   var _controller = YoutubePlayerController(

                //     initialVideoId: vid ,
                //     flags: YoutubePlayerFlags(
                //       autoPlay: false,
                //       mute: false,
                //     ),
                //   );

                //   return YoutubePlayer(controller: _controller,
                //     showVideoProgressIndicator: true,);
                // }
                // else if (snapshot.data['ufacebook'] != null){

                //   var url = snapshot.data['ufacebook'];

                //   return Container(
                //     height: 290,
                //     child: InAppWebView(
                //       initialUrl: url,
                //       initialOptions: InAppWebViewGroupOptions(
                //         crossPlatform: InAppWebViewOptions(
                //             debuggingEnabled: true,
                //             preferredContentMode: UserPreferredContentMode.MOBILE),
                //       ),
                //       onWebViewCreated: (InAppWebViewController controller) {
                //         webView = controller;
                //       },
                //       onLoadStart: (InAppWebViewController controller, String url) {

                //       },
                //       onLoadStop: (InAppWebViewController controller, String url) async {

                //       },

                //     ),
                //   );

                // }

                else {
                  return Container();
                }
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading();
              }
              return Scaffold(
                body: ListView(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          mediaGetter(),

                          // Row(
                          //   children: [

                          //     Spacer(flex: 9),
                          //     IconButton(icon: Icon(Icons.favorite) ,
                          //       onPressed:() async {

                          //         DocumentReference docRef = FirebaseFirestore.instance.collection('storys').doc(widget.storyid);
                          //         DocumentSnapshot doc = await docRef.get();
                          //         List like = doc.data()['tlike'];
                          //         int totallike = doc.data()['totlike'];

                          //         String newuser = user.uid;

                          //         if(like.contains(newuser) == true ){
                          //           setState(() {
                          //             _liked = true;
                          //           });

                          //           await docRef.update({'tlike': FieldValue.arrayRemove([newuser])

                          //           });
                          //           var curlike = totallike;
                          //           --curlike;
                          //           await docRef.update({'totlike' : curlike});

                          //         }else{
                          //           setState(() {
                          //             _liked = false;
                          //           });
                          //           await  FirebaseFirestore.instance.collection('storys').doc(widget.storyid).update({'tlike': FieldValue.arrayUnion([newuser])});
                          //           ++totallike;
                          //           await docRef.update({'totlike' : totallike});

                          //         }

                          //       } ,

                          //       color:  _liked ? Colors.grey : Colors.red,
                          //     ),

                          //     if(snapshot.data['tlike'] == null  )
                          //       Text('0'),

                          //     Text(snapshot.data['totlike'].toString()),

                          //     Spacer(),

                          //     IconButton(icon: Icon(Icons.comment) ,
                          //       onPressed:(){

                          //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => (CommentPage(storyid: widget.storyid,))));

                          //         setState(() {
                          //           _comment = !_comment;
                          //         });

                          //       } ,

                          //       color:  _comment ? Colors.grey : Colors.blue,
                          //     ),

                          //     Text(snapshot.data['tcomment'].toString()),

                          //     Spacer(),

                          //   ],
                          // ),

                          ListTile(
                            title: Text(_data['StoreName']),
                            subtitle: Text(
                              _data['StoreLocation'],
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              _data['Owner'],
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),

                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => (EditStore(
                                          storyid: widget.storyid,
                                        ))));
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
