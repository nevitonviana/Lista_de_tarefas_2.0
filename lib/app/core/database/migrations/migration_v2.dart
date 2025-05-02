import 'package:sqflite/sqflite.dart';

import '../../helpers/constants.dart';
import 'migration.dart';

class MigrationV2 implements Migration {
  @override
  void create(Batch batch) {}

  @override
  void update(Batch batch) {
    batch.execute('''
    ALTER TABLE ${Constants.NAME_BD} ADD COLUMN show_notification INTEGER DEFAULT 0
    ''');
  }
}
