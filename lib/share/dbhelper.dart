import 'package:aplikasi_wisata/share/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  static Database _database;

  final String tableTravel = 'travelTable';
  final String columId = 'id';
  final String columnNamaLokasi = 'namalokasi';
  final String columnDeskripsiLokasi = 'deskripsilokasi';
  final String columnPetaLokasi = 'petalokasi';
  final String columnGambarLokasi = 'gambarlokasi';

  DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'travel.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableTravel($columId INTEGER PRIMARY KEY, "
        "$columnNamaLokasi TEXT, "
        "$columnDeskripsiLokasi TEXT, "
        "$columnPetaLokasi TEXT,"
        "$columnGambarLokasi TEXT)";
    await db.execute(sql);
  }

//Save Travel
  Future<int> saveTravel(ModelTravel travel) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableTravel, travel.toMap());
    return result;
  }

//Get All Travel
  Future<List> getAllTravel() async {
    var dbClient = await db;
    var result = await dbClient.query(tableTravel, columns: [
      columId,
      columnNamaLokasi,
      columnDeskripsiLokasi,
      columnPetaLokasi,
      columnGambarLokasi
    ]);
    return result.toList();
  }

//Update Travel
  Future<int> updateTravel(ModelTravel travel) async {
    var dbClient = await db;
    return await dbClient.update(tableTravel, travel.toMap(),
        where: "$columId = ?", whereArgs: [travel.id]);
  }

//Delete Travel
  Future<int> deleteTravel(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableTravel, where: "$columId = ?", whereArgs: [id]);
  }
}
