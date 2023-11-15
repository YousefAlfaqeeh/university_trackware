// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// class SqlDb{
//   static Database?_db;
//   Future<Database?> get db async{
//     if(_db==null)
//       {
//         _db =await intialDb();
//         return _db;
//       }
//     return _db;
//   }
//   intialDb() async {
//     String databasepath= await getDatabasesPath();
//     String path =join(databasepath,'university_trackware.db');
//     Database mydb=await openDatabase(path,onCreate: _onCreate,version: 1,onUpgrade: _onUpgrade);
//     return mydb;
//   }
//   _onCreate(Database db,int version) async {
//     await  db.execute('''
//     CREATE TABLE "profile" (
//     "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
//     "image" TEXT, "name" TEXT,"mobile" TEXT,"lang" TEXT,"user_id" INTEGER,"notify" INTEGER,"token" TEXT,"authorization" TEXT,"distance" TEXT
//     )
//     ''');
//     await  db.execute('''
//     CREATE TABLE "rout" (
//     "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
//      "name" TEXT,"rout_id" INTEGER
//     )
//     ''');
//
//
//
//
//
//
//     await  db.execute('''
//     CREATE TABLE "station" (
//     "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
//     "time" TEXT, "name" TEXT,"station_id" INTEGER,"long" REAL,"lat" REAL,"rout_id" INTEGER
//     )
//     ''');
//
//
//
//
//
//     await  db.execute('''
//     CREATE TABLE "round" (
//     "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
//     "driver_name" TEXT, "name" TEXT,"time" TEXT,"bus_num" TEXT,"station_id" INTEGER
//     )
//     ''');
//
//
//   }
//
//
//   _onUpgrade(Database db,int oldversion,int newversion) async {
//     await  db.execute('''
//     CREATE TABLE "profile" (
//     "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
//     "image" TEXT, "name" TEXT,"mobile" TEXT,"lang" TEXT,"user_id" INTEGER,"notify" INTEGER,"token" TEXT,"authorization" TEXT,"distance" TEXT
//     )
//     ''');
//
//
//     await  db.execute('''
//     CREATE TABLE "rout" (
//     "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
//      "name" TEXT,"rout_id" INTEGER
//     )
//     ''');
//
//
//
//
//
//
//     await  db.execute('''
//     CREATE TABLE "station" (
//     "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
//     "time" TEXT, "name" TEXT,"station_id" INTEGER,"long" TEXT,"lat" TEXT,"rout_id" INTEGER
//     )
//     ''');
//
//
//
//
//
//     await  db.execute('''
//     CREATE TABLE "profile" (
//     "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
//     "driver_name" TEXT, "name" TEXT,"time" TEXT,"bus_num" TEXT,"station_id" INTEGER
//     )
//     ''');
//
//
//   }
//   readData(String sql) async{
//     Database? mydb=await db;
//     List<Map> response= await mydb!.rawQuery(sql);
//     return response;
//   }
//
//
//   insertData(String sql) async{
//     Database? mydb=await db;
//     int response= await mydb!.rawInsert(sql);
//     return response;
//   }
//
//   updateData(String sql) async{
//     Database? mydb=await db;
//     int response= await mydb!.rawUpdate(sql);
//     return response;
//   }
//
//   deleteData(String sql) async{
//     Database? mydb=await db;
//     int response= await mydb!.rawDelete(sql);
//     return response;
//   }
//
// }