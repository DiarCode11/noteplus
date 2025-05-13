import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/notes.dart'; // pastikan file model kamu diimport

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();

  factory DatabaseHelper() => instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Menghapus database lama
      await db.execute('DROP TABLE IF EXISTS notes');
      
      // Memanggil fungsi _onCreate untuk membuat ulang tabel
      await _onCreate(db, newVersion);
    }
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'notes.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        date TEXT NOT NULL,
        color TEXT NOT NULL
      )
    ''');
  }

  void deleteDatabaseFile() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'notes.db');
    await deleteDatabase(dbPath); // menghapus file database
  }

  Future<int> insertNote(Notes note) async {
    final db = await database;
    return await db.insert('notes', note.toMap());
  }

  Future<List<Notes>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return maps.map((e) => Notes.fromMap(e)).toList();
  }

  Future<int> updateNote(Notes note) async {
    final db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
