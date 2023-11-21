// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_details_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MenuDetailsDoa? _menuDetailsDoaInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MenuDetailsTable` (`id` INTEGER NOT NULL, `groupName` TEXT NOT NULL, `groupData` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MenuDetailsDoa get menuDetailsDoa {
    return _menuDetailsDoaInstance ??=
        _$MenuDetailsDoa(database, changeListener);
  }
}

class _$MenuDetailsDoa extends MenuDetailsDoa {
  _$MenuDetailsDoa(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _menuDetailsTableInsertionAdapter = InsertionAdapter(
            database,
            'MenuDetailsTable',
            (MenuDetailsTable item) => <String, Object?>{
                  'id': item.id,
                  'groupName': item.groupName,
                  'groupData': item.groupData
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MenuDetailsTable> _menuDetailsTableInsertionAdapter;

  @override
  Future<MenuDetailsTable?> findGroupDataByName(String groupName) async {
    return _queryAdapter.query(
        'SELECT * FROM MenuDetailsTable WHERE groupName = ?1',
        mapper: (Map<String, Object?> row) => MenuDetailsTable(row['id'] as int,
            row['groupName'] as String, row['groupData'] as String),
        arguments: [groupName]);
  }

  @override
  Future<List<MenuDetailsTable>> findAllMenuDetails() async {
    return _queryAdapter.queryList('SELECT * FROM MenuDetailsTable',
        mapper: (Map<String, Object?> row) => MenuDetailsTable(row['id'] as int,
            row['groupName'] as String, row['groupData'] as String));
  }

  @override
  Future<void> insertGroupData(MenuDetailsTable menuDetailsTable) async {
    await _menuDetailsTableInsertionAdapter.insert(
        menuDetailsTable, OnConflictStrategy.abort);
  }
}
