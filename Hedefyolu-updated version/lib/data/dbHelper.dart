import 'package:Hedefyolu/models/Plan.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';


class DbHelper{
  Database _db;

  Future<Database> get db async{
    if(_db==null){
      _db= await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(),"target.db");
    var planDb= await openDatabase(dbPath,version: 1,onCreate: createDb);
    return planDb;
  }



  
  void createDb(Database db, int version) async {
    await db.execute(("Create table plans(id integer primary key,title text,description text, dateTimeInt integer)"));
  }
  Future<List<Plan>> getPlan() async{
    Database db= await this.db;
    var result = await db.query("plans",orderBy: "dateTimeInt" );
    return List.generate(result.length,(index) {
      return Plan.fromObject(result[index]);
    });
  }

  Future<List<Plan>> getByDateTime(DateTime dateTime) async{
    Database db= await this.db;

    int dateTimeInt= dateTime.microsecondsSinceEpoch;
    var whereString;

    int differenceDay = (dateTime.year-DateTime.now().year)*365+(dateTime.month-DateTime.now().month)*30+dateTime.day-DateTime.now().day;

    if(differenceDay<=1){
      whereString="dateTimeInt=" +dateTimeInt.toString();
    }
    else if(differenceDay<=7 && differenceDay>=2){
      whereString="dateTimeInt between "+convertMicroSec(2,0)+" and "+convertMicroSec(7,0);
    }
    else if(differenceDay<=30 && differenceDay>7){
      whereString="dateTimeInt between "+convertMicroSec(8,0)+" and "+convertMicroSec(0,1);
    }
    else if(differenceDay<=365 && differenceDay>30){
    whereString="dateTimeInt between "+convertMicroSec(1,1)+" and "+convertMicroSec(0,12);
    }
    else whereString= "dateTimeInt between "+convertMicroSec(1,12)+" and "+convertMicroSec(0,12*100);

    var result =await db.query("plans",where: whereString);

    return List.generate(result.length, (index) {
      return Plan.fromObject(result[index]);
    });
  }


  void insert(Plan plan) async{
    Database db= await this.db;
    await db.insert("plans", plan.toMap());
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
  String convertMicroSec(int day,int mount){
    DateTime now=DateTime.now();
    return DateTime(now.year,now.month+mount,now.day+day).microsecondsSinceEpoch.toString();
}
