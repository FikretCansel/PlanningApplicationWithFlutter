import 'package:Hedefyolu/data/dbHelper.dart';
import 'package:Hedefyolu/models/Plan.dart';
import 'package:Hedefyolu/screens/plan_add.dart';
import 'package:Hedefyolu/screens/plan_details.dart';
import 'package:Hedefyolu/screens/planPeriodsMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlanList();
  }

}

class _PlanList extends State {
  var dbHelper=new DbHelper();
  List<Plan> plans;
  int planCount=0;

  @override
  void initState() {
    getPlan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genel Hedef Listem'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.access_time),
            tooltip: 'Go to the planPeriodMenu',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanPeriodsMenu()));
              },
              )
        ],
      ),
      body:buildPlanList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Yeni Hedef Ekle",
        onPressed: (){
          goToPlanAdd();
        },
      ),
    );
  }

  ListView buildPlanList() {
    return ListView.builder(
        itemCount: planCount,
        itemBuilder: (BuildContext context,int position){
          return Card(
            color: getCardColor(position),
            elevation: 2.0,
            child: ListTile(
              title: Text(this.plans[position].title),
              subtitle: Text(this.plans[position].description),
              trailing: Text(getDateTimeString(position)),
              onTap: (){
                goToDetail(this.plans[position]);
              },
            ),
          );
        }
    );
  }
  Color getCardColor(int position){
    final DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(this.plans[position].dateTimeInt);
    var now=DateTime.now();
    if(dateTime.isAfter(DateTime(now.year,now.month,now.day-1))){
      return Colors.white60;
    }
    return Colors.red;
  }

  String getDateTimeString(int position){
    final DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(this.plans[position].dateTimeInt);
    var now=DateTime.now();

    if(dateTime==DateTime(now.year,now.month,now.day)){
      return "Bugun";
    }
    else if(dateTime==DateTime(now.year,now.month,now.day+1)){
      return "Yarın";
    }
    var formatDate=DateFormat.yMMMd().format(dateTime);
    return formatDate;
  }


  void goToPlanAdd()async {
    bool result =await Navigator.push(context, MaterialPageRoute(builder: (context)=>PlanAdd()));
    if(result!=null){
      if(result){
        getPlan();
      }
    }
  }
  void getPlan() async{
    var planFuture=dbHelper.getPlan();
    planFuture.then((data){
      setState(() {
        this.plans=data;

        planCount=data.length;
      });

    });
  }

  void goToDetail(Plan plan) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>PlanDetail(plan)));
    if(result!=null){
      if(result){
        getPlan();
      }
    }
  }
}

