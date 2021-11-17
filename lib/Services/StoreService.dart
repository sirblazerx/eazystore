// ignore: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eazystore/Models/Store.dart';

class StoreService {
  final String sid;

  //collection ref

  final CollectionReference story =
      FirebaseFirestore.instance.collection('Store');

  StoreService({this.sid});

// Update/Create Data to Collection

  // User Data

  Future updateStoreData(
      {String StoreName,
      String Img,
      String StoreLocation,
      String Uid,
      String StoreId,
      String Owner}) async {
    return await story.doc(sid).set({
      'StoreName': StoreName,
      'Img': Img,
      'StoreLocation': StoreLocation,
      'Uid': Uid,
      'StoreId': StoreId,
      'Owner': Owner,
    });
  }

  Future deleteStore() async {
    return await story.doc(sid).delete();
  }

  // UserData from snapshot

  Store _store(DocumentSnapshot snapshot) {
    return Store(
      StoreId: sid,
      Uid: snapshot['Uid'],
      StoreLocation: snapshot['StoreLocation'],
      Img: snapshot['Img'],
      StoreName: snapshot['StoreName'],
      Owner: snapshot['Owner'],
    );
  }

  //Stream

  // get user data stream
  Stream<Store> get storyData {
    return story.doc(sid).snapshots().map(_store);
  }
}
