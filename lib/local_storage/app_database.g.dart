// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

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

  MenuDetailsDao? _menuDetailsDoaInstance;

  CartItemsDao? _cartItemsDoaInstance;

  OrderCreateResponseDoa? _orderCreateResponseDoaInstance;

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
            'CREATE TABLE IF NOT EXISTS `MenuDetailsEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `groupName` TEXT NOT NULL, `groupData` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CartItemsEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `itemName` TEXT NOT NULL, `itemQuantity` INTEGER NOT NULL, `selectedBase` TEXT NOT NULL, `selectedSize` TEXT NOT NULL, `addon` INTEGER NOT NULL, `basePrice` INTEGER NOT NULL, `itemModel` TEXT NOT NULL, `orderCreateResponse` TEXT NOT NULL, `isOffer` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OrderCreateResponseEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `resData` TEXT NOT NULL, `resId` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MenuDetailsDao get menuDetailsDoa {
    return _menuDetailsDoaInstance ??=
        _$MenuDetailsDao(database, changeListener);
  }

  @override
  CartItemsDao get cartItemsDoa {
    return _cartItemsDoaInstance ??= _$CartItemsDao(database, changeListener);
  }

  @override
  OrderCreateResponseDoa get orderCreateResponseDoa {
    return _orderCreateResponseDoaInstance ??=
        _$OrderCreateResponseDoa(database, changeListener);
  }
}

class _$MenuDetailsDao extends MenuDetailsDao {
  _$MenuDetailsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _menuDetailsEntityInsertionAdapter = InsertionAdapter(
            database,
            'MenuDetailsEntity',
            (MenuDetailsEntity item) => <String, Object?>{
                  'id': item.id,
                  'groupName': item.groupName,
                  'groupData': item.groupData
                }),
        _menuDetailsEntityUpdateAdapter = UpdateAdapter(
            database,
            'MenuDetailsEntity',
            ['id'],
            (MenuDetailsEntity item) => <String, Object?>{
                  'id': item.id,
                  'groupName': item.groupName,
                  'groupData': item.groupData
                }),
        _menuDetailsEntityDeletionAdapter = DeletionAdapter(
            database,
            'MenuDetailsEntity',
            ['id'],
            (MenuDetailsEntity item) => <String, Object?>{
                  'id': item.id,
                  'groupName': item.groupName,
                  'groupData': item.groupData
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MenuDetailsEntity> _menuDetailsEntityInsertionAdapter;

  final UpdateAdapter<MenuDetailsEntity> _menuDetailsEntityUpdateAdapter;

  final DeletionAdapter<MenuDetailsEntity> _menuDetailsEntityDeletionAdapter;

  @override
  Future<MenuDetailsEntity?> findGroupDataByName(String groupName) async {
    return _queryAdapter.query(
        'SELECT * FROM MenuDetailsEntity WHERE groupName = ?1',
        mapper: (Map<String, Object?> row) => MenuDetailsEntity(
            groupName: row['groupName'] as String,
            groupData: row['groupData'] as String),
        arguments: [groupName]);
  }

  @override
  Future<List<MenuDetailsEntity>> findAllMenuDetails() async {
    return _queryAdapter.queryList('SELECT * FROM MenuDetailsEntity',
        mapper: (Map<String, Object?> row) => MenuDetailsEntity(
            groupName: row['groupName'] as String,
            groupData: row['groupData'] as String));
  }

  @override
  Future<void> insertGroupData(MenuDetailsEntity menuDetailsTable) async {
    await _menuDetailsEntityInsertionAdapter.insert(
        menuDetailsTable, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMenuDetails(MenuDetailsEntity menuDetailsTable) async {
    await _menuDetailsEntityUpdateAdapter.update(
        menuDetailsTable, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteSingleMenuDetails(
      MenuDetailsEntity menuDetailsTable) async {
    await _menuDetailsEntityDeletionAdapter.delete(menuDetailsTable);
  }

  @override
  Future<int> deleteAllMenu(List<MenuDetailsEntity> menuDetailsTable) {
    return _menuDetailsEntityDeletionAdapter
        .deleteListAndReturnChangedRows(menuDetailsTable);
  }
}

class _$CartItemsDao extends CartItemsDao {
  _$CartItemsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _cartItemsEntityInsertionAdapter = InsertionAdapter(
            database,
            'CartItemsEntity',
            (CartItemsEntity item) => <String, Object?>{
                  'id': item.id,
                  'itemName': item.itemName,
                  'itemQuantity': item.itemQuantity,
                  'selectedBase': item.selectedBase,
                  'selectedSize': item.selectedSize,
                  'addon': item.addon,
                  'basePrice': item.basePrice,
                  'itemModel': item.itemModel,
                  'orderCreateResponse': item.orderCreateResponse,
                  'isOffer': item.isOffer ? 1 : 0
                }),
        _cartItemsEntityUpdateAdapter = UpdateAdapter(
            database,
            'CartItemsEntity',
            ['id'],
            (CartItemsEntity item) => <String, Object?>{
                  'id': item.id,
                  'itemName': item.itemName,
                  'itemQuantity': item.itemQuantity,
                  'selectedBase': item.selectedBase,
                  'selectedSize': item.selectedSize,
                  'addon': item.addon,
                  'basePrice': item.basePrice,
                  'itemModel': item.itemModel,
                  'orderCreateResponse': item.orderCreateResponse,
                  'isOffer': item.isOffer ? 1 : 0
                }),
        _cartItemsEntityDeletionAdapter = DeletionAdapter(
            database,
            'CartItemsEntity',
            ['id'],
            (CartItemsEntity item) => <String, Object?>{
                  'id': item.id,
                  'itemName': item.itemName,
                  'itemQuantity': item.itemQuantity,
                  'selectedBase': item.selectedBase,
                  'selectedSize': item.selectedSize,
                  'addon': item.addon,
                  'basePrice': item.basePrice,
                  'itemModel': item.itemModel,
                  'orderCreateResponse': item.orderCreateResponse,
                  'isOffer': item.isOffer ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CartItemsEntity> _cartItemsEntityInsertionAdapter;

  final UpdateAdapter<CartItemsEntity> _cartItemsEntityUpdateAdapter;

  final DeletionAdapter<CartItemsEntity> _cartItemsEntityDeletionAdapter;

  @override
  Future<List<CartItemsEntity>> findAllCartItems() async {
    return _queryAdapter.queryList('SELECT * FROM CartItemsEntity',
        mapper: (Map<String, Object?> row) => CartItemsEntity(
            orderCreateResponse: row['orderCreateResponse'] as String,
            itemModel: row['itemModel'] as String,
            itemName: row['itemName'] as String,
            itemQuantity: row['itemQuantity'] as int,
            selectedBase: row['selectedBase'] as String,
            selectedSize: row['selectedSize'] as String,
            addon: row['addon'] as int,
            basePrice: row['basePrice'] as int,
            isOffer: (row['isOffer'] as int) != 0,
            id: row['id'] as int?));
  }

  @override
  Future<void> deleteSingleCartItem(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM CartItemsEntity where id=?1',
        arguments: [id]);
  }

  @override
  Future<void> insertCartItem(CartItemsEntity cartItemsEntity) async {
    await _cartItemsEntityInsertionAdapter.insert(
        cartItemsEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCartItem(CartItemsEntity cartItemEntity) async {
    await _cartItemsEntityUpdateAdapter.update(
        cartItemEntity, OnConflictStrategy.replace);
  }

  @override
  Future<int> deleteAllCart(List<CartItemsEntity> cartItemsEntity) {
    return _cartItemsEntityDeletionAdapter
        .deleteListAndReturnChangedRows(cartItemsEntity);
  }
}

class _$OrderCreateResponseDoa extends OrderCreateResponseDoa {
  _$OrderCreateResponseDoa(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _orderCreateResponseEntityInsertionAdapter = InsertionAdapter(
            database,
            'OrderCreateResponseEntity',
            (OrderCreateResponseEntity item) => <String, Object?>{
                  'id': item.id,
                  'resData': item.resData,
                  'resId': item.resId
                }),
        _orderCreateResponseEntityUpdateAdapter = UpdateAdapter(
            database,
            'OrderCreateResponseEntity',
            ['id'],
            (OrderCreateResponseEntity item) => <String, Object?>{
                  'id': item.id,
                  'resData': item.resData,
                  'resId': item.resId
                }),
        _orderCreateResponseEntityDeletionAdapter = DeletionAdapter(
            database,
            'OrderCreateResponseEntity',
            ['id'],
            (OrderCreateResponseEntity item) => <String, Object?>{
                  'id': item.id,
                  'resData': item.resData,
                  'resId': item.resId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OrderCreateResponseEntity>
      _orderCreateResponseEntityInsertionAdapter;

  final UpdateAdapter<OrderCreateResponseEntity>
      _orderCreateResponseEntityUpdateAdapter;

  final DeletionAdapter<OrderCreateResponseEntity>
      _orderCreateResponseEntityDeletionAdapter;

  @override
  Future<OrderCreateResponseEntity?> findById(String id) async {
    return _queryAdapter.query(
        'SELECT * FROM OrderCreateResponseEntity WHERE resId = ?1',
        mapper: (Map<String, Object?> row) => OrderCreateResponseEntity(
            resData: row['resData'] as String,
            resId: row['resId'] as String,
            id: row['id'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<OrderCreateResponseEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM OrderCreateResponseEntity',
        mapper: (Map<String, Object?> row) => OrderCreateResponseEntity(
            resData: row['resData'] as String,
            resId: row['resId'] as String,
            id: row['id'] as int?));
  }

  @override
  Future<void> insertResData(
      OrderCreateResponseEntity orderCreateResponseEntity) async {
    await _orderCreateResponseEntityInsertionAdapter.insert(
        orderCreateResponseEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateResData(
      OrderCreateResponseEntity orderCreateResponseEntity) async {
    await _orderCreateResponseEntityUpdateAdapter.update(
        orderCreateResponseEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteSingleResData(
      OrderCreateResponseEntity orderCreateResponseEntity) async {
    await _orderCreateResponseEntityDeletionAdapter
        .delete(orderCreateResponseEntity);
  }

  @override
  Future<int> deleteAllResData(
      List<OrderCreateResponseEntity> orderCreateResponseEntities) {
    return _orderCreateResponseEntityDeletionAdapter
        .deleteListAndReturnChangedRows(orderCreateResponseEntities);
  }
}
