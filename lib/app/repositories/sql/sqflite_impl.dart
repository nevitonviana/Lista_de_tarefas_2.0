import 'package:lista_de_tarefas_2_0/app/repositories/sql/sqflite.dart';
import '../../core/database/sqlite_connection_factory.dart';
import '../../core/exception/failure.dart';
import '../../core/helpers/constants.dart';
import '../../core/logger/app_logger.dart';
import '../../models/item_model.dart';

class SqfliteImpl implements Sqflite {
  final SqliteConnectionFactory _sqliteConnection;
  final AppLogger _log;

  const SqfliteImpl({
    required SqliteConnectionFactory sqliteConnection,
    required AppLogger log,
  })  : _sqliteConnection = sqliteConnection,
        _log = log;

  @override
  Future<void> createItem(ItemModel itemModel) async {
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
      final result = await conn.rawQuery('''
     select * from ${Constants.NAME_BD} where options = $option order by date asc
     ''');
      return result.map((e) => ItemModel.fromMap(e)).toList();
    } on Failure catch (e, s) {
      _log.error("erro ao buscar os dados", e, s);
      throw const Failure(message: "Erro ao buscar dados");
    }
  }

  @override
  Future<List<ItemModel>> searchItemBarcodeOrName(String search) async {
    try {
      var resultList;
      final conn = await _sqliteConnection.openConnection();
      final result = await conn.query(Constants.NAME_BD);
      resultList.add((result.map(
        (e) => ItemModel.fromMap(e).barcode == search,
      )) as Map<String, Object?>);
      resultList.add((result.map(
        (e) => ItemModel.fromMap(e).name == search,
      )) as Map<String, Object?>);
      return resultList;
    } on Failure catch (e, s) {
      _log.error("erro ao busca o itens", e, s);
      throw const Failure(message: "erro ao busca os itens");
    }
  }

  @override
  Future<void> updateItem(ItemModel itemModel) async {
    try {
      final conn = await _sqliteConnection.openConnection();
      await conn.update(Constants.NAME_BD, itemModel.toMap(), where: "id = ?", whereArgs: [itemModel.id]);
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
      _log.error("erro ao deleta o item", e, s);
      throw const Failure(message: "error ao deleta o item");
    }
  }
}
