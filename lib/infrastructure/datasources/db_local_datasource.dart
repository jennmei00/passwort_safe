import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

abstract class DBLocalDatasource {
  Future<sql.Database> openDatabase();
  Future<void> deleteDatabase();
  Future<List<Map<String, dynamic>>> getData(String table,
      {List<String>? columns, String? where, String? orderBy});
  Future<Map<String, dynamic>> getOneData(String table,
      {List<String>? columns, String? where, String? orderBy});
  Future<void> multipleInsert(
      String table, List<Map<String, dynamic>> dataList);
  Future<void> multipleInsertOrUpdate(
      String table, List<Map<String, dynamic>> dataList, String primaryKey);
  Future<void> insert(String table, Map<String, dynamic> data);
  Future<void> update(String table, Map<String, dynamic> data, {String? where});
  Future<void> delete(String table, {String? where});
  Future<int> count(String table, {String where = ''});
}

class DBLocalDatasourceImpl implements DBLocalDatasource {
  static sql.Database? _database;
  static int _versionNumber = 1;

  @override
  Future<sql.Database> openDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return _database ??= await sql.openDatabase(
        path.join(dbPath, 'PasswordSafe.db'),
        onCreate: _createTables,
        onUpgrade: _upgradeTables,
        version: _versionNumber);
  }

  @override
  Future<void> deleteDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    await sql.deleteDatabase('$dbPath/PasswordSafe.db');
    _database = null;
  }

  @override
  Future<List<Map<String, dynamic>>> getData(String table,
      {List<String>? columns, String? where, String? orderBy}) async {
    final db = await this.openDatabase();
    return db.transaction((txn) async {
      return await txn.query(table,
          columns: columns, where: where, orderBy: orderBy);
    });
  }

  @override
  Future<Map<String, dynamic>> getOneData(String table,
      {List<String>? columns, String? where, String? orderBy}) async {
    List<Map<String, dynamic>> _data =
        await getData(table, columns: columns, where: where, orderBy: orderBy);

    return _data[0];
  }

  @override
  Future<void> multipleInsert(
      String table, List<Map<String, dynamic>> dataList) async {
    final db = await this.openDatabase();
    sql.Batch batch = db.batch();
    dataList.forEach((Map<String, dynamic> data) {
      batch.insert(table, data);
    });
    await batch.commit();
  }

  @override
  Future<void> multipleInsertOrUpdate(String table,
      List<Map<String, dynamic>> dataList, String primaryKey) async {
    final db = await this.openDatabase();
    sql.Batch batch = db.batch();
    for (var data in dataList) {
      var _primaryKeyValue = data[primaryKey];
      int _count = await count(table,
          where: "WHERE $primaryKey = '${data[primaryKey]}'");
      if (_count > 0) {
        data.removeWhere((k, v) => k == primaryKey);
        batch.update(table, data, where: "$primaryKey = '$_primaryKeyValue'");
      } else {
        batch.insert(table, data);
      }
    }
    await batch.commit();
  }

  @override
  Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await this.openDatabase();
    sql.Batch batch = db.batch();
    batch.insert(table, data);
    await batch.commit();
  }

  @override
  Future<void> update(String table, Map<String, dynamic> data,
      {String? where}) async {
    final db = await this.openDatabase();
    sql.Batch batch = db.batch();
    batch.update(table, data, where: where);
    await batch.commit();
  }

  @override
  Future<void> delete(String table, {String? where}) async {
    final db = await this.openDatabase();
    sql.Batch batch = db.batch();
    batch.delete(table, where: where);
    await batch.commit();
  }

  @override
  Future<int> count(String table, {String where = ''}) async {
    final db = await this.openDatabase();
    return await db.transaction((txn) async {
      return sql.Sqflite.firstIntValue(await txn.rawQuery(
              'SELECT COUNT(*) FROM $table${where.isNotEmpty ? ' $where' : ''}'))
          as Future<int>;
    });
  }

  Future<void> _createTables(sql.Database db, int version) async {
    await db.execute(
        'CREATE TABLE Password(id TEXT PRIAMRY KEY, title TEXT, name TEXT, email TEXT, password TEXT, '
        'link TEXT, codePoint INTEGER, fontFamily TEXT, fontPackage TEXT, matchTextDirection BOOLEAN, '
        'favoriteTag BOOLEAN, mailTag BOOLEAN, networkTag BOOLEAN);');
  }

  Future<void> _upgradeTables(
      sql.Database db, int oldVersion, int newVersion) async {
    //  if (oldVersion < 2) {
    //     try {
    //       await db.execute('ALTER TABLE StandingOrder ADD AccountToID TEXT');
    //       await db.execute('ALTER TABLE Transfer ADD StandingOrderID TEXT');
    //       await db.execute('ALTER TABLE Transfer ADD IsStandingOrder BOOLEAN');
    //       // await db.execute('ALTER TABLE StandingOrder ADD FOREIGN KEY(AccountToID) REFERENCES Account(ID)');
    //     } catch (ex) {
    //       FileHelper()
    //           .writeAppLog(AppLog(ex.toString(), 'Upgrade Tables Version 2'));

    //     print('DBHelper $ex');
    //     }
    //   }
  }
}
