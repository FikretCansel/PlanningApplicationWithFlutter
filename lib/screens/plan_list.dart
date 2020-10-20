import 'package:ebrarinplanlari/data/dbHelper.dart';
import 'package:ebrarinplanlari/models/Plan.dart';
import 'package:ebrarinplanlari/screens/plan_add.dart';
import 'package:ebrarinplanlari/screens/plan_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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
        title: Text("PlanApp"),
      ),
      body:buildPlanList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Yeni Plan Ekle",
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
            color: Colors.green,
            elevation: 2.0,
            child: ListTile(
              title: Text(this.plans[position].title),
              subtitle: Text(this.plans[position].description),
              trailing: Text(this.plans[position].day),
              onTap: (){

                goToDetail(this.plans[position]);
              },
            ),
          );
        }
    );
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

