import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/remesa.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'remesas.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE remesas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre_cliente TEXT NOT NULL,
        monto REAL NOT NULL,
        fecha_envio INTEGER NOT NULL,
        usuario_registro TEXT NOT NULL,
        fecha_creacion INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertRemesa(Remesa remesa) async {
    final db = await database;
    return await db.insert('remesas', remesa.toMap());
  }

  Future<List<Remesa>> getAllRemesas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'remesas',
      orderBy: 'fecha_creacion DESC',
    );

    return List.generate(maps.length, (i) {
      return Remesa.fromMap(maps[i]);
    });
  }

  Future<List<Remesa>> searchRemesas(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'remesas',
      where: 'nombre_cliente LIKE ? OR usuario_registro LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'fecha_creacion DESC',
    );

    return List.generate(maps.length, (i) {
      return Remesa.fromMap(maps[i]);
    });
  }

  Future<int> updateRemesa(Remesa remesa) async {
    final db = await database;
    return await db.update(
      'remesas',
      remesa.toMap(),
      where: 'id = ?',
      whereArgs: [remesa.id],
    );
  }

  Future<int> deleteRemesa(int id) async {
    final db = await database;
    return await db.delete('remesas', where: 'id = ?', whereArgs: [id]);
  }

  Future<double> getTotalMonto() async {
    final db = await database;
    final result = await db.rawQuery('SELECT SUM(monto) as total FROM remesas');
    return result.first['total'] as double? ?? 0.0;
  }

  Future<int> getTotalRemesas() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM remesas');
    return result.first['count'] as int? ?? 0;
  }
}
