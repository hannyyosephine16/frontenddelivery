import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConfig {
  static Database? _database;
  static const String _databaseName = 'delpick_local.db';
  static const int _databaseVersion = 1;

  // Table names
  static const String userTable = 'users';
  static const String cartTable = 'cart_items';
  static const String favoritesTable = 'favorites';
  static const String ordersTable = 'orders';
  static const String addressesTable = 'addresses';
  static const String notificationsTable = 'notifications';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    // Create users table for caching user data
    await db.execute('''
      CREATE TABLE $userTable (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        phone TEXT,
        role TEXT NOT NULL,
        avatar TEXT,
        created_at TEXT,
        updated_at TEXT
      )
    ''');

    // Create cart items table
    await db.execute('''
      CREATE TABLE $cartTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        menu_item_id INTEGER NOT NULL,
        store_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        quantity INTEGER NOT NULL,
        image_url TEXT,
        notes TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create favorites table
    await db.execute('''
      CREATE TABLE $favoritesTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        store_id INTEGER NOT NULL,
        menu_item_id INTEGER,
        type TEXT NOT NULL, -- 'store' or 'menu_item'
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create offline orders table
    await db.execute('''
      CREATE TABLE $ordersTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        server_id INTEGER,
        store_id INTEGER NOT NULL,
        customer_id INTEGER NOT NULL,
        items TEXT NOT NULL, -- JSON string
        total REAL NOT NULL,
        status TEXT NOT NULL,
        notes TEXT,
        delivery_address TEXT NOT NULL,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        synced INTEGER DEFAULT 0
      )
    ''');

    // Create addresses table
    await db.execute('''
      CREATE TABLE $addressesTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        address TEXT NOT NULL,
        latitude REAL,
        longitude REAL,
        is_default INTEGER DEFAULT 0,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create notifications table
    await db.execute('''
      CREATE TABLE $notificationsTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        body TEXT NOT NULL,
        type TEXT NOT NULL,
        data TEXT, -- JSON string
        is_read INTEGER DEFAULT 0,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  static Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    // Handle database upgrades
    if (oldVersion < newVersion) {
      // Add migration logic here
    }
  }

  static Future<void> clearDatabase() async {
    final db = await database;
    await db.delete(cartTable);
    await db.delete(favoritesTable);
    await db.delete(ordersTable);
    await db.delete(addressesTable);
    await db.delete(notificationsTable);
  }

  static Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
