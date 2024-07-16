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
      final result = await conn
          .rawQuery('SELECT * FROM ${Constants.NAME_BD} WHERE options = ? order by date ASC ', [option]);
      return result.map((e) => ItemModel.fromMap(e)).toList();
    } on Failure catch (e, s) {
      _log.error("erro ao buscar os dados", e, s);
      throw const Failure(message: "Erro ao buscar dados");
    }
  }

  @override
  Future<List<ItemModel>> searchItemBarcodeOrName(String search) async {
    try {
      List<ItemModel> resultList = [];
      final conn = await _sqliteConnection.openConnection();
      final result = await conn.query(Constants.NAME_BD);
      result.map<ItemModel>((e) => ItemModel.fromMap(e)).forEach(
        (element) {
          if (element.name.contains(search) || element.barcode.contains(search)) {
            resultList.add(element);
          }
        },
      );
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
      await conn.update(Constants.NAME_BD, itemModel.toMap(), where: 'id = ?', whereArgs: [itemModel.id]);
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
