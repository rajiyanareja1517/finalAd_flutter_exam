import 'package:final_exam/helper/database_helper.dart';
import 'package:flutter/material.dart';

import '../../models/note_model.dart';

class LikedNotesPage extends StatefulWidget {
  const LikedNotesPage({super.key});

  @override
  State<LikedNotesPage> createState() => _LikedNotesPageState();
}

class _LikedNotesPageState extends State<LikedNotesPage> {
  List<NoteModel> allNote = [];

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Liked Notes"),
        ),
        body: FutureBuilder(
          future: DatabaseHelper.dbHelper.fetchAllNote(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("No data"),
              );
            } else if (snapshot.hasData) {
              allNote = snapshot.data!;
              return ListView.builder(
                itemCount: allNote.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${allNote[index].note}"),
                    trailing:
                        IconButton(onPressed: () {
                          DatabaseHelper.dbHelper.deleteFavNote(allNote[index].note_id!);
                        }, icon: Icon(Icons.delete)),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
