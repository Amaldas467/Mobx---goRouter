import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:skincare_app/model/productResModel.dart'; // Import your ProductREsModel

class DBHelper {
  static Database? _database;

  // Singleton pattern for database initialization
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  // Initialize the database
  _initDb() async {
    var directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'favourites.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  // Create the favourites table if it doesn't exist
  _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favourites(
        id INTEGER PRIMARY KEY,
        title TEXT,
        price REAL,
        description TEXT,
        category TEXT,
        image TEXT,
        ratingRate REAL,
        ratingCount INTEGER
      )
    ''');
  }

  // Convert ProductREsModel to Map for SQLite
  Map<String, dynamic> toMap(ProductREsModel product) {
    return {
      'id': product.id,
      'title': product.title,
      'price': product.price,
      'description': product.description,
      'category': categoryValues.reverse[product.category],
      'image': product.image,
      'ratingRate': product.rating?.rate,
      'ratingCount': product.rating?.count,
    };
  }

  // Convert Map to ProductREsModel after retrieving from SQLite
  ProductREsModel fromMap(Map<String, dynamic> map) {
    return ProductREsModel(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      description: map['description'],
      category: categoryValues.map[map['category']],
      image: map['image'],
      rating: (map['ratingRate'] != null && map['ratingCount'] != null)
          ? Rating(rate: map['ratingRate'], count: map['ratingCount'])
          : null,
    );
  }

  // Insert a favourite product into the database
  Future<void> insertFavourite(ProductREsModel product) async {
    final db = await database;
    await db.insert('favourites', toMap(product),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get all favourite products from the database
  Future<List<ProductREsModel>> getFavouriteProducts() async {
    final db = await database;
    var res = await db.query('favourites');
    return res.isNotEmpty
        ? res.map((product) => fromMap(product)).toList()
        : [];
  }

  // Remove a favourite product from the database
  Future<void> removeFavourite(ProductREsModel product) async {
    final db = await database;
    await db.delete(
      'favourites',
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }
}
