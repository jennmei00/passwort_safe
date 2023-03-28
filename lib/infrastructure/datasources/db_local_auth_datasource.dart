import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

abstract class DBLocalAuthDatasource {
  Future<Database> openDatabase();
  Future<void> deleteDatabase();
  Future<Map<String, dynamic>> getUser();
  Future<void> addUser(Map<String, dynamic> data);
  Future<void> changePassword(Map<String, dynamic> data);
  Future<void> deleteUser();
}

class DBLocalAuthDatasourceImpl implements DBLocalAuthDatasource {
  static sql.Database? _database;
  static int _versionNumber = 1;

  @override
  Future<Database> openDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return _database ??= await sql.openDatabase(
      path.join(dbPath, 'User.db'),
      onCreate: _createTables,
      onUpgrade: _upgradeTables,
      version: _versionNumber,
    );
  }

  @override
  Future<void> deleteDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    await sql.deleteDatabase('$dbPath/User.db');
    _database = null;
  }

  @override
  Future<void> addUser(Map<String, dynamic> data) async {
    final db = await this.openDatabase();
    sql.Batch batch = db.batch();
    batch.insert('User', data);
    await batch.commit();
  }

  @override
  Future<void> deleteUser() async {
    final db = await this.openDatabase();
    sql.Batch batch = db.batch();
    batch.delete('User');
    await batch.commit();
  }

  Future<List<Map<String, dynamic>>> _getData(String table) async {
    final db = await this.openDatabase();
    return db.transaction((txn) async {
      return await txn.query(table);
    });
  }

  @override
  Future<Map<String, dynamic>> getUser() async {
    List<Map<String, dynamic>> _data = await _getData('User');
    if (_data.length != 0) {
      return _data[0];
    } else {
      return {};
    }
  }

  @override
  Future<void> changePassword(Map<String, dynamic> data) async {
    final db = await this.openDatabase();
    sql.Batch batch = db.batch();
    batch.update('User', data);
    await batch.commit();
  }

  Future<void> _createTables(sql.Database db, int version) async {
    await db
        .execute('CREATE TABLE User(name TEXT, email TEXT, password TEXT);');
  }

  Future<void> _upgradeTables(
      sql.Database db, int oldVersion, int newVersion) async {
    //  if (oldVersion < 2) {
    //     try {
    //       await db.execute('ALTER TABLE StandingOrder ADD AccountToID TEXT');
    //       // await db.execute('ALTER TABLE StandingOrder ADD FOREIGN KEY(AccountToID) REFERENCES Account(ID)');
    //     } catch (ex) {
    //       FileHelper()
    //           .writeAppLog(AppLog(ex.toString(), 'Upgrade Tables Version 2'));

    //     print('DBHelper $ex');
    //     }
    //   }
  }
}
