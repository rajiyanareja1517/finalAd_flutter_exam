import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_exam/helper/database_helper.dart';
import 'package:final_exam/helper/firebase_helper.dart';
import 'package:final_exam/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed("/like");
              //  Navigator.of(context).pushNamed("like");
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseHelper.firebaseHelper.fetchAllNote(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
            List<QueryDocumentSnapshot<Map<String, dynamic>>> allDoc =
                (data == null) ? [] : data.docs;

            return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.event_note),
                    title: Text("${allDoc[index].data()['note']}"),
                    onTap: () {},
                    trailing: IconButton(
                        onPressed: () {
                          DatabaseHelper.dbHelper.insertFavNote(
                              model: NoteModel(
                                  note: allDoc[index].data()['note']));
                        },
                        icon: Icon(Icons.favorite_border)),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: allDoc.length);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add Note"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: noteController,
                      maxLines: 10,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )
                  ],
                ),
                actions: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")),
                  OutlinedButton(
                      onPressed: () {
                        FirebaseHelper.firebaseHelper
                            .addNote(note: noteController.text);
                        noteController.clear();
                        Navigator.pop(context);
                      },
                      child: Text("Add")),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
