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
    final doubleType = 'DOUBLE NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE stat (
      ${StatFields.id} $idType,
      ${StatFields.initialMoney} $doubleType,
      ${StatFields.provider} $textType,
      ${StatFields.timeSpending} $doubleType,
      ${StatFields.timestamp} $textType,

    )
    ''');

    await db.execute('''
    CREATE TABLE token (
      ${TokenFields.id} $idType,
      ${TokenFields.tokenName} $textType,
      ${TokenFields.value} $doubleType,
      ${TokenFields.image} $textType,
      ${TokenFields.timestamp} $textType,
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



}