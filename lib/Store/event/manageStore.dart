import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eazystore/Custom/customlist.dart';
import 'package:eazystore/Models/User.dart';
import 'package:eazystore/Store/event/EditStore.dart';
import 'package:eazystore/Store/event/VStoryEdit.dart';
import 'package:eazystore/Store/event/createStory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ManageStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserM>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Story Screen'),
        backgroundColor: Colors.pinkAccent,
        elevation: 0.0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Store")
            .where('Uid', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return Text('null');

          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            itemExtent: 106.0,
            itemCount: snapshot?.data?.docs?.length ?? 0,
            itemBuilder: (context, index) {
              DocumentSnapshot _data = snapshot.data.docs[index];

              // Declaration of FB,YT vids

              Widget mediaGetter() {
                if (_data['Img'] != '') {
                  return Image.network(_data['Img']);
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Placeholder(),
                  );
                }
              }
              // Get Video URL

              return Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VStoryEdit(
                            storyid: _data.id,
                          ),
                        ));
                  },
                  child: CustomListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EditStore(storyid: snapshot.data.docs[index])));
                    },
                    user: _data['Owner'],
                    description: _data['StoreLocation'],
                    thumbnail: Container(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: mediaGetter(),
                    ),
                    title: _data['StoreName'],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStory()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
