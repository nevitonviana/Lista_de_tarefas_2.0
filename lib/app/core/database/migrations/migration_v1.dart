import 'package:sqflite/sqflite.dart';

import '../../helpers/constants.dart';
import 'migration.dart';

class MigrationV1 extends Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
    CREATE TABLE ${Constants.NAME_BD}(
    id Integer primary key autoincrement,
    name text not null,
    barcode text not null,
    description text,
    quantity text,
    date datetime not null,
    options text not null,
    finished integer default 0
    )
    ''');
  }

  @override
  void update(Batch batch) {}
}
