import '../../core/database/sqlite_connection_factory.dart';
import '../../core/exception/failure.dart';
import '../../core/helpers/constants.dart';
import '../../core/logger/app_logger.dart';
import '../../models/item_model.dart';
import 'sqflite_repository.dart';

class SqfliteRepositoryImpl implements SqfliteRepository {
  final SqliteConnectionFactory _sqliteConnection;
  final AppLogger _log;

  const SqfliteRepositoryImpl({
    required SqliteConnectionFactory sqliteConnection,
    required AppLogger log,
  })  : _sqliteConnection = sqliteConnection,
        _log = log;

  @override
  Future<void> saveItem(ItemModel itemModel) async {
    try {
      final conn = await _sqliteConnection.openConnection();
      await conn.insert(Constants.NAME_BD, itemModel.toMap());
    } on Failure catch (e, s) {
      _log.error("Erro ao salvar dados no banco de dados", e, s);
      throw const Failure(message: "Erro ao salvar dados no banco de dados");
    }
  }

  @override
  Future<List<ItemModel>> getItemOption(String option) async {
    try {
      final conn = await _sqliteConnection.openConnection();
      final result = await conn.rawQuery(
          'SELECT * FROM ${Constants.NAME_BD} WHERE options = ? order by date ASC ', [option]);
      return result.map((e) => ItemModel.fromMap(e)).toList();
    } on Failure catch (e, s) {
      _log.error("Erro ao buscar os itens", e, s);
      throw const Failure(message: "Erro ao buscar os itens");
    }
  }

  @override
  Future<List<ItemModel>> searchItemBarcodeOrName(String search) async {
    try {
      final conn = await _sqliteConnection.openConnection();
      final result = await conn.query(
        Constants.NAME_BD,
        where: 'name LIKE ? OR barcode LIKE ?',
        whereArgs: ['%$search%', '%$search%'],
      );
      return result.map((e) => ItemModel.fromMap(e)).toList();
    } on Failure catch (e, s) {
      _log.error("Erro ao buscar os itens", e, s);
      throw const Failure(message: "Erro ao buscar os itens");
    }
  }

  @override
  Future<void> updateItem(ItemModel itemModel) async {
    try {
      final conn = await _sqliteConnection.openConnection();
      await conn
          .update(Constants.NAME_BD, itemModel.toMap(), where: 'id = ?', whereArgs: [itemModel.id]);
    } on Failure catch (e, s) {
      _log.error("error ao atualizar o item", e, s);
      throw const Failure(message: "Erro ao atualizar o Item");
    }
  }

  @override
  Future<void> deleteItemAllOfOptions(String option) async {
    try {
      final conn = await _sqliteConnection.openConnection();
      await conn.delete(Constants.NAME_BD, where: "options = ?", whereArgs: [option]);
    } on Failure catch (e, s) {
      _log.error("Erro ao deleta todos as itens", e, s);
      throw const Failure(message: "Erro ao deleta todos as itens");
    }
  }

  @override
  Future<void> deleteItem(int id) async {
    try {
      final conn = await _sqliteConnection.openConnection();
      await conn.delete(Constants.NAME_BD, where: "id = ?", whereArgs: [id]);
    } on Failure catch (e, s) {
      _log.error("Erro ao deletar item no banco de dados", e, s);
      throw const Failure(message: "error ao deleta o item");
    }
  }

  @override
  Future<ItemModel?> findByBarcode(String barcode) async {
    try {
      final conn = await _sqliteConnection.openConnection();
      final result = await conn.query(
        Constants.NAME_BD,
        where: 'barcode = ?',
        whereArgs: [barcode],
        limit: 1,
      );

      if (result.isNotEmpty) {
        return ItemModel.fromMap(result.first);
      }
      return null;
    } on Failure catch (e, s) {
      _log.error("Erro ao buscar item por código de barras", e, s);
      throw const Failure(message: "Erro ao buscar item por código de barras");
    }
  }
}
