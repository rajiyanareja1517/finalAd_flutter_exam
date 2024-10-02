import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note_model.dart';

class DatabaseHelper {
  DatabaseHelper._();

  Database? db;
  static DatabaseHelper dbHelper = DatabaseHelper._();

  initDB() async {
    String directoryPath = await getDatabasesPath();
    String path = join(directoryPath, "rv.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String query =
            "CREATE TABLE IF NOT EXISTS fav_note(note_id INTEGER PRIMARY KEY AUTOINCREMENT, note TEXT NOT NULL);";
        await db.execute(query);
      },
    );
  }

  //insert a fav note
  Future<int> insertFavNote({required NoteModel model}) async {
    if (db == null) {
      await initDB();
    }
    String query =
        "INSERT INTO fav_note(note) VALUES(?);";
    List args = [model.note];
    int? id = await db?.rawInsert(query, args);
    return id!;
  }

  Future<void> deleteFavNote(int noteId) async {
    if (db == null) {
      await initDB();
    }
    String query =
        "DELETE FROM fav_note WHERE note_id = $noteId";

    int? id = await db?.rawDelete(query);

  }

  Future<List<NoteModel>> fetchAllNote() async {
    if (db == null) {
      await initDB();
    }
    String query = "SELECT * FROM fav_note";

    List<Map<String, dynamic>> responseList = await db!.rawQuery(query);
    print("List:::" + responseList.toString());
    List<NoteModel> allNote =
        responseList.map((e) => NoteModel.fromMap(data: e)).toList();

    return allNote;
  }
}
