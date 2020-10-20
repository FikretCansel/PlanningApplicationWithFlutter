import 'package:ebrarinplanlari/data/dbHelper.dart';
import 'package:ebrarinplanlari/models/Plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class PlanDetail extends StatefulWidget {
  Plan plan;
  PlanDetail(this.plan);

  @override
  State<StatefulWidget> createState() {
    return _PlanDetailState(this.plan);
  }
}

enum Options { delete, update }

class _PlanDetailState extends State {
  Plan plan;

  _PlanDetailState(this.plan);

  var dbHelper = DbHelper();
  TextEditingController txtPlan = new TextEditingController();
  TextEditingController txtDescription = new TextEditingController();
  String txtDay;
  String dropdownValue = 'Bugun';
  @override
  void initState() {
    // TODO: implement initState
    txtPlan.text = plan.title;
    txtDescription.text = plan.description;
    txtDay = plan.day;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Planım : ${plan.title}"),
        actions: <Widget>[
          PopupMenuButton<Options>(
              onSelected: selectProcess,
              itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<Options>>[
                PopupMenuItem<Options>(
                  value: Options.delete,
                  child: Text("Bitirdim"),
                ),
                PopupMenuItem<Options>(
                  value: Options.update,
                  child: Text("Güncelle"),
                ),
              ])
        ],
      ),
      body: buildPlanDetail(),
    );
  }

  Widget buildPlanDetail() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField(),
        ],
      ),
    );
  }

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(plan.id);
        Navigator.pop(context, true);
        var alert = AlertDialog(
          title: Text("Tebrikler"),
          content: Text(plan.title + " " + "Tamamlandı :)"),
        );
        showDialog(context: context, builder: (BuildContext context) => alert);

        break;
      case Options.update:
        await dbHelper.update(Plan.withId(
            id: plan.id,
            title: txtPlan.text,
            description: txtDescription.text,
            day: txtDay
        ));
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  buildNameField() {
    return TextField(
      decoration:
      InputDecoration(labelText: "Plan Başlıgı", hintText: "Matematik"),
      controller: txtPlan,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(
          labelText: "Plan Açıklama", hintText: "Limit testi bitir"),
      controller: txtDescription,
    );
  }

  buildUnitPriceField() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
          txtDay=dropdownValue;
      },
      items: <String>['Bugun', 'Yarın']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
