import 'package:ebrarinplanlari/data/dbHelper.dart';
import 'package:ebrarinplanlari/models/Plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PlanAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PlanAddState();
  }


}

class PlanAddState extends State{
  TextEditingController txtTitle=new TextEditingController();
  TextEditingController txtDescription=new TextEditingController();
  String txtDay="Bugun";
  var dbHelper=DbHelper();
  String dropdownValue="Bugun";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Plan Ekle"),
      ),
      body:Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(children: <Widget>[
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField(),
          buildSaveButton(),
        ],),
      ),
    );

  }

  Widget buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Plan Başlıgı",hintText: "Matematik"),
      controller: txtTitle,
    ) ;
  }

  Widget buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Plan Açıklama",hintText: "Limit testi bitir"),
      controller: txtDescription,
    );

  }

  Widget buildUnitPriceField() {
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

  Widget buildSaveButton() {
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: (){
        addPlan();
      },
    );
  }

  void addPlan() async{
    var result =await dbHelper.insert((Plan(title:txtTitle.text,description:txtDescription.text,day: txtDay)));
    Navigator.pop(context,true);
  }
}