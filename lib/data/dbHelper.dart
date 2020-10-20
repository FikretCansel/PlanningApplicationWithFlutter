import 'dart:async';

import 'package:[PROJECTNAME]/models/Plan.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DbHelper{
  Database _db;

  Future<Database> get db async{
    if(_db==null){
      _db= await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(),"etrade.db");
    var eTradeDb= await openDatabase(dbPath,version: 1,onCreate: createDb);
    return eTradeDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(("Create table plans(id integer primary key,title text,description text, day text)"));
  }
  Future<List<Plan>> getPlan() async{
    Database db= await this.db;
    var result = await db.query("plans");
    return List.generate(result.length,(index) {
      return Plan.fromObject(result[index]);
    });
    //id:result[index]["id"],name: result[index]["name"]
  }
  Future<int> insert(Plan plan) async{
    Database db= await this.db;
    var result=await db.insert("plans", plan.toMap());
  }
  Future<int> delete(int id) async{
    Database db= await this.db;
    var result=await db.delete("plans",where: "id=?",whereArgs: [id]);
    return result;
  }
  Future<int> update(Plan plan) async{
    Database db= await this.db;
    var result=await db.update("plans", plan.toMap(),where: "id=?",whereArgs: [plan.id]);
    return result;
  }
}
