import 'dart:html';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbManager {

  late Database _database;

  Future<void> initializeDatabase() async {
    Directory docsDirectory = await getApplicationDocumentsDirectory();
    String path = join(docsDirectory.path, 'images.db');

    _database = await openDatabase(
      path, 
      version: 1,
      onCreate: _onCreate 
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''

      CREATE TABLE Images(
        id INTEGER PRIMARY KEY,
        path TEXT,
        meterReading INTEGER
      )
    '''
    );
  }

  Future<int> insertData(String path, int meterReading) async {
    return await _database.insert("Images", {'path': path, 'meterReadin': meterReading});
  }

  Future<List<Map<String, dynamic>>> getData() async {
    return await _database.query('Images');
  }

  Future<void> closeDatabase() async {
    await _database.close();
  }
}