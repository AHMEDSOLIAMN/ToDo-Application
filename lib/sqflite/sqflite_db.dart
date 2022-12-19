import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _database;

  get db async {
    if (_database == null) {
      return initDb();
    } else {
      return _database;
    }
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'TodoApp.db');
    Database myDb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 3,
      onUpgrade: _onUpgrade,
    );
    return myDb;
  }
// just when i change version
  _onUpgrade(Database db, int oldVersion, int newVersion) {
    db.execute('ALTER TABLE notes ADD COLUMN title');
    print('upgrade done ++++++++');
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, task TEXT, date TEXT)");
    print('data base created ++++++++++++++++++++++++');
  }

  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }
  deleteAllDatabase()async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'TodoApp.db');
    await deleteDatabase(path);
    print('database removed --------------------------------');
  }
}
// select
// insert
// update
// delete
