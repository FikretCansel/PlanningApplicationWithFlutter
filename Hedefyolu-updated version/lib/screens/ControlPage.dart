import 'package:Hedefyolu/screens/GetStarted.dart';
import 'package:Hedefyolu/screens/plan_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ControlPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ControlPageState();
  }
}
class ControlPageState extends State{
  bool getStartedBool=false;

  @override
  void initState() {
    dbControl();
    super.initState();
  }

  void dbControl() async {
    String dbPath = join(await getDatabasesPath(),"control.db");
    var planDb= await openDatabase(dbPath,version: 1,onCreate: setGetStartedBool);
    planDb.close();
  }
  void setGetStartedBool(Database db, int version) {
      setState(() {
        getStartedBool=true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return getStartedBool?GetStarted():PlanList();
  }

}