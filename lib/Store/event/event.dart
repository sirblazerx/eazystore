import 'package:app/screen/event/vevent.dart';
import 'package:app/template/CustomListTileStory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/template/loading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Event extends StatefulWidget {
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    // CollectionReference projects = FirebaseFirestore.instance.collection('vprojects');//.orderBy('datecreate',descending: true);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Events'),
          backgroundColor: Colors.pinkAccent,
          elevation: 0.0,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("vprojects")
              .orderBy('datecreate', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }

            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            return Card(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot projects = snapshot.data.documents[index];

                  Widget mediaGetter() {
                    if (projects['img'] != null) {
                      return Image.network(projects['img']);
                    } else if (projects['uyoutube'] != null) {
                      String vid;

                      // Convert Video to ID
                      vid = YoutubePlayer.convertUrlToId(projects['uyoutube']);

                      var _controller = YoutubePlayerController(
                        initialVideoId: vid,
                        flags: YoutubePlayerFlags(
                          autoPlay: false,
                          mute: true,
                        ),
                      );
                      //    log('null');
                      return YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                      );
                    } else if (projects['ufacebook'] != null) {
                      InAppWebViewController webView;
                      var url = projects['ufacebook'];

                      return InAppWebView(
                        initialUrl: url,
                        initialOptions: InAppWebViewGroupOptions(
                          crossPlatform: InAppWebViewOptions(
                              debuggingEnabled: true,
                              preferredContentMode:
                                  UserPreferredContentMode.DESKTOP),
                        ),
                        onWebViewCreated: (InAppWebViewController controller) {
                          webView = controller;
                        },
                        onLoadStart:
                            (InAppWebViewController controller, String url) {},
                        onLoadStop: (InAppWebViewController controller,
                            String url) async {},
                      );
                    } else {
                      return Icon(Icons.person);
                    }
                  }

                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                VEvent(projectid: projects.id)));
                      },
                      child: CustomListTile(
                        // onTap: () {
                        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => VDonation(donationid: donate.id)));
                        // },
                        user: projects['name'],
                        description: projects['descri'],
                        thumbnail: Container(
                          decoration: const BoxDecoration(color: Colors.blue),
                          child: Container(
                              constraints: BoxConstraints(
                                  minHeight: 100,
                                  minWidth: 100,
                                  maxWidth: 200,
                                  maxHeight: 160),
                              child: mediaGetter()),
                        ),
                        title: projects['title'],
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
