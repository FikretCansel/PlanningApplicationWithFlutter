import 'package:Hedefyolu/data/dbHelper.dart';
import 'package:Hedefyolu/models/Periods.dart';
import 'package:Hedefyolu/models/Plan.dart';
import 'package:Hedefyolu/screens/plan_details.dart';
import 'package:Hedefyolu/screens/plan_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanPeriod extends StatefulWidget {
  final int planId;

  //requiring the list of todos
  PlanPeriod({Key key, @required this.planId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PlanPeriodState();
  }
}

class PlanPeriodState extends State<PlanPeriod> {
  var dbHelper = new DbHelper();
  List<Plan> plans = [];
  int planCount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFilterData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(Periodss.getPeriodName(widget.planId) + "  Hedefim"),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PlanList()), (route) => false);
                })
          ],
        ),
        body: buildPlanList());
  }

  ListView buildPlanList() {
    return ListView.builder(
        itemCount: planCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white60,
            elevation: 2.0,
            child: ListTile(
              title: Text(this.plans[position].title),
              subtitle: Text(this.plans[position].description),
              trailing: Text(Periodss.getPeriodName(widget.planId)),
              onTap: () {
                goToDetail(this.plans[position]);
              },
            ),
          );
        });
  }

  getDataFilterData() async {
    var dateTime = Periodss.toDateTime(widget.planId);
    var planFuture = dbHelper.getByDateTime(dateTime);
    planFuture.then((data) => {
          setState(() {
            plans = data;
            planCount = data.length;
          })
        });
  }

  void goToDetail(Plan plan) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => PlanDetail(plan)));
    if (result != null) {
      if (result) {
        getDataFilterData();
      }
    }
  }
}
