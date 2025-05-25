import 'migrations/migration.dart';
import 'migrations/migration_v1.dart';
import 'migrations/migration_v2.dart';

// class SqliteMigrationFactory {
//   List<Migration> getCreateMigrations() => [
//         MigrationV1(),
//       ];
//
//   List<Migration> getUpdateMigrations(int version) {
//     final migrations = <Migration>[];
//     if (version == 1) {
//       migrations.add(MigrationV2());
//     }
//     return migrations;
//   }
// }

class SqliteMigrationFactory {
  final _migrations = <int, Migration>{
    1: MigrationV1(),
    2: MigrationV2(),
    // futuras versões
  };

  List<Migration> getCreateMigrations() =>
      _migrations.entries.map((e) => e.value).toList();

  List<Migration> getUpdateMigrations(int fromVersion) {
    final migrations = <Migration>[];
    for (var i = fromVersion + 1; i <= _migrations.length; i++) {
      final migration = _migrations[i];
      if (migration != null) {
        migrations.add(migration);
      }
    }
    return migrations;
  }
}
