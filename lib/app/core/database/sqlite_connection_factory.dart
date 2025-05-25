import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

import 'sqlite_migration_factory.dart';

class SqliteConnectionFactory {
  static const _version = 2;
  static const _databaseName = "LISTA_DE_TAREFAS_BD";
  static SqliteConnectionFactory? _instance;

  Database? _db;
  final _lock = Lock();

  SqliteConnectionFactory._();

  factory SqliteConnectionFactory() {
    _instance ??= SqliteConnectionFactory._();
    return _instance!;
  }

  Future<Database> openConnection() async {
    try {
      if (_db == null) {
        await _lock.synchronized(
          () async {
            if (_db == null) {
              final databasePath = await getDatabasesPath();
              final pathDatabase = join(databasePath, _databaseName);
              _db = await openDatabase(
                pathDatabase,
                version: _version,
                onConfigure: _onConfigure,
                onCreate: _onCreate,
                onUpgrade: _onUpgrade,
              );
            }
          },
        );
      }
      return _db!;
    } catch (e) {
      throw Exception("Erro ao abrir a conexão com o banco de dados");
    }
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
    // await db.execute("PRAGMA journal_mode = WAL");
  }

  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();
    final migrations = SqliteMigrationFactory().getCreateMigrations();
    for (var migration in migrations) {
      migration.create(batch);
    }
    await batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    final batch = db.batch();
    final migrations = SqliteMigrationFactory().getUpdateMigrations(oldVersion);
    for (var migration in migrations) {
      migration.update(batch);
    }
    await batch.commit();
  }

  void closeConnection() {
    try {
      _db?.close();
    } catch (e) {
      throw Exception("Erro ao fechar a conexão com o banco de dados");
    } finally {
      _db = null;
    }
  }
}
