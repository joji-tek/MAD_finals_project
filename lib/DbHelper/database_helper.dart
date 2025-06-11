import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _openDatabase();
    return _database!;
  }

  // Method to open database
  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'session.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create the table when the database is created
        await db.execute('''
          CREATE TABLE regex_sessions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            regex_pattern TEXT NOT NULL,
            test_string TEXT NOT NULL,
            created_at DATE DEFAULT CURRENT_DATE,
            updated_at DATE DEFAULT CURRENT_DATE
          )
        ''');
      },
    );
  }

  // CREATE: Insert a new session into the database
  Future<int> insertSession(Map<String, dynamic> session) async {
    try {
      final db = await database;
      return await db.insert('regex_sessions', session);
    } catch (e) {
      // print('Error inserting session: $e');
      return -1;
    }
  }

  // READ: Get all sessions from the database
  Future<List<Map<String, dynamic>>> getAllSessions() async {
    try {
      final db = await database;
      return await db.query('regex_sessions');
    } catch (e) {
      // print('Error getting all sessions: $e');
      return [];
    }
  }

  // READ: Get a session by ID
  Future<Map<String, dynamic>?> getSessionById(int id) async {
    try {
      final db = await database;
      final result = await db.query(
        'regex_sessions',
        where: 'id = ?',
        whereArgs: [id],
      );
      return result.isNotEmpty ? result.first : null;
    } catch (e) {
      // print('Error getting session by ID: $e');
      return null;
    }
  }

  // UPDATE: Update an existing session by ID
  Future<int> updateSession(Map<String, dynamic> session, int id) async {
    try {
      final db = await database;
      session['updated_at'] = DateTime.now().toIso8601String();
      return await db.update(
        'regex_sessions',
        session,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      // print('Error updating session: $e');
      return -1;
    }
  }

  // DELETE: Delete a session by ID
  Future<int> deleteSession(int id) async {
    try {
      final db = await database;
      return await db.delete(
        'regex_sessions',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      // print('Error deleting session: $e');
      return -1;
    }
  }
}
