import 'package:registro_ponto/models/registro_ponto.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const _dbName = 'cadastro_registro_ponto.db';
  static const _dbVersion = 2;

  DatabaseProvider._init();

  static final DatabaseProvider instance = DatabaseProvider._init();

  Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    String dataBasePath = await getDatabasesPath();
    String dbPath = '$dataBasePath/$_dbName';
    return await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(getSQLCreateTable());
  }

  String getSQLCreateTable() {
    return '''
      CREATE TABLE ${RegistroPonto.NOME_TABLE}(
      ${RegistroPonto.CAMPO_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${RegistroPonto.CAMPO_HORA} TEXT,
      ${RegistroPonto.CAMPO_LATITUDE} DECIMAL(9,6),
      ${RegistroPonto.CAMPO_LONGITUDE} DECIMAL(9,6));
     ''';
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {    
    if (oldVersion == newVersion)
      return;
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
    }
  }
}