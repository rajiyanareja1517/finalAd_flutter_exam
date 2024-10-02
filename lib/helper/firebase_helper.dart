import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class FirebaseHelper {
  FirebaseHelper._();

  static final FirebaseHelper firebaseHelper = FirebaseHelper._();
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference ref = db.collection('note');

//add authenticated user
  Future<void> addNote({required String note}) async {
    DocumentReference rf= await ref.add({"note": note});
    print("id..:${rf.id}");
   // await ref.doc('1').set({"note": note});
    await ref.add(note);
  }

//Todo: fetch all data
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllNote() {
    return db.collection("note").snapshots();
  }

// Todo: update data
  Future<void> updateNote({required String note}) async {
    DocumentReference rf= await ref.add({"note": note});
   QuerySnapshot<Map<String, dynamic>> slist=db.collection("note").snapshots() as QuerySnapshot<Map<String, dynamic>>;
    for(int i=0;i< slist.size;i++){

    }
   // await ref.up(note);
  }

//Todo:delete data


}
