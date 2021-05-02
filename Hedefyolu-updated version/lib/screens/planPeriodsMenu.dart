import 'package:Hedefyolu/screens/planPeriod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanPeriodsMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PlanPeriodsMenuState();
  }
}

class PlanPeriodsMenuState extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Hedeflerim"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            buildListTile("Bugun",1,Icons.today),
            buildListTile("Yarın",2,IconData(59143, fontFamily: 'MaterialIcons')),
            buildListTile("Haftalık",3,IconData(57528, fontFamily: 'MaterialIcons')),
            buildListTile("Aylık",4,IconData(58916, fontFamily: 'MaterialIcons')),
            buildListTile("Yıllık",5,IconData(61670, fontFamily: 'MaterialIcons')),
            buildListTile("Temel Hedefim",6,IconData(59506, fontFamily: 'MaterialIcons')),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(String text,int planId,IconData icon) {
    return Card(
        child: InkWell(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlanPeriod(planId: planId,)));
          },
      child: ListTile(
        leading:  Icon(icon),
        title: Text(text),
      ),
    ));
  }
}
