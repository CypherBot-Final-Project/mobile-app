import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/stat.dart';
import '../model/token.dart';

class CypherDatabase {
  static final CypherDatabase instance = CypherDatabase._init();
  static Database? _database;
  CypherDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cypher.db');
    return _database!;
  }
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final doubleType = 'DOUBLE(10) NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE Stat (
      ${StatFields.id} $idType,
      ${StatFields.initialMoney} $doubleType,
      ${StatFields.provider} $textType,
      ${StatFields.profit} $doubleType,
      ${StatFields.createAt} $textType
    )
    ''');

    await db.execute('''
    CREATE TABLE Token (
      ${TokenFields.id} $idType,
      ${TokenFields.tokenName} $textType,
      ${TokenFields.value} $doubleType,
      ${TokenFields.image} $textType,
      ${TokenFields.createAt} $textType
    )
    ''');

  }

  Future<void> createStat(Stat stat) async {
    final db = await instance.database;
    await db.insert("stat", stat.toJson());
  }

  Future<void> createToken(Token token) async {
    final db = await instance.database;
    await db.insert("token", token.toJson());
  }
  Future<List<Stat>> readAllStats() async {
    final db = await instance.database;

    final orderBy = '${StatFields.createAt} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query("Stat", orderBy: orderBy);

    return result.map((json) => Stat.fromJson(json)).toList();
  }

  

  Future readBarChart() async {
    final db = await instance.database;
    final result = await db.rawQuery('''
    SELECT SUM(initialMoney) as initialMoney, SUM(profit) as profit, createAt FROM Stat
    GROUP BY createAt
    ORDER BY createAt ASC;
  ''');
    return result;
  }

  Future readLineChart() async {
    final db = await instance.database;
    final map = await db.rawQuery(''' 
      SELECT profit, createAt FROM Stat
      ORDER BY createAt ASC;
    ''');

  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  // Future deleteTable(String table) async {
  //   final db = await instance.database;
  //   await db.delete(table);
  // }



}