import 'package:la_vie_app/models/cart/cart_model.dart';
import 'package:sqflite/sqflite.dart';

class SqlHelper {
  static late Database dataBase;
  static String dbName = "cart.db";
  static const String tableName = "cart_products";

  static Future<void> initDB({
    String tableName = tableName,
  }) async {
    dataBase = await openDatabase(
      dbName,
      version: 1,
      onCreate: (Database database, int x) async {
        await onCreateDataBase(database: database);
      },
    );
  }

  static Future<void> onCreateDataBase({
    required Database database,
    String tableName = tableName,
  }) async {
    await database.execute(
        'CREATE TABLE $tableName(product_id TEXT PRIMARY KEY, name TEXT, image_url TEXT, quantity INTEGER)');
  }

  static Future<void> closeDataBase() async {
    return await dataBase.close();
  }

  static Future<void> insertProduct(
    CartModel cartModel, {
    String tableName = tableName,
  }) async {
    await dataBase.rawInsert(
      'INSERT INTO $tableName(product_id, name, image_url, quantity) VALUES(?, ?, ?, ?)',
      [cartModel.id, cartModel.name, cartModel.imageUrl, cartModel.quantity],
    );
  }

  static Future<void> updateProductQuantity(String id, int quantity,
      {String tableName = tableName}) async {
    await initDB();
    await dataBase.rawUpdate(
      'UPDATE $tableName SET quantity = ? WHERE product_id = ?',
      [
        quantity,
        id,
      ],
    );
  }

  static Future<List<Map<String, dynamic>>> getAllCartProducts(
      {String tableName = tableName}) async {
    await initDB();
    return await dataBase.rawQuery('SELECT * FROM $tableName');
  }

  static Future<void> deleteRecorde(String id,
      {String tableName = tableName}) async {
    await initDB();
    await dataBase.rawDelete(
      'DELETE FROM $tableName WHERE product_id = ?',
      [
        id,
      ],
    );
  }
}
