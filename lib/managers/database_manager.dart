// import 'dart:async';
// import 'dart:convert';
// import 'package:path/path.dart';
// import 'dart:io' as io;

// class DatabaseManager {
//   bool deleteItem = false;
//   static Database? _db;
//   Future<Database?> get db async {
//     if (_db != null) {
//       return _db!;
//     }
//     _db = await initDatabase();
//   }

//   initDatabase() async {
//     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, 'cart.db');
//     var db = await openDatabase(path, version: 1, onCreate: _onCreate);
//     return db;
//   }

//   _onCreate(Database db, int version) async {
//     await db.execute(
//         'CREATE TABLE cart (id INTEGER PRIMARY KEY,name TEXT,price TEXT,image TEXT )');
//   }

//   Future<CartObj> insert(CartObj cartObj) async {
//     var dbClient = await db;
//     await dbClient!.insert('cart', cartObj.toMap());
//     return cartObj;
//   }

//   Future<List<CartObj>> getCartList() async {
//     var dbClient = await db;
//     final List<Map<String, Object?>> queryResult =
//         await dbClient!.query('cart');
//     return queryResult.map((e) => CartObj.fromMap(e)).toList();
//   }

//   Future<int> delete(int id) async {
//     var dbClient = await db;
//     return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
//   }
// }
