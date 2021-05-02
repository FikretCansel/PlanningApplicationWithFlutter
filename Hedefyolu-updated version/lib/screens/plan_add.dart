import 'package:Hedefyolu/data/dbHelper.dart';
import 'package:Hedefyolu/models/Periods.dart';
import 'package:Hedefyolu/models/Plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PlanAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PlanAddState();
  }
}

class PlanAddState extends State {
  TextEditingController txtTitle = new TextEditingController();
  TextEditingController txtDescription = new TextEditingController();
  bool datePeriodBool = true;
  DateTime _selectedDate;
  int dropDownValue = 1;
  var dbHelper = DbHelper();

  @override
  void initState() {
     var now =DateTime.now();
     _selectedDate=DateTime(now.year,now.month,now.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Hedef Ekle"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildNameField(),
              buildDescriptionField(),
              SizedBox(height: 10),
              buildMethodPicker(),
              SizedBox(height: 10),
              datePeriodBool ? buildPeriodField() : buildDatePickerField(),
              buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMethodPicker() {
    return new Container(
      height: 40.0,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              setState(() {
                datePeriodBool = true;
              });
            },
            child: SizedBox(
              child: Center(
                  child: Text(
                "Periyotla",
              )),
              width: 100,
              height: 100,
            ),
            color: datePeriodBool ? Colors.lightBlue : Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(500.0),
                side: BorderSide(color: Colors.lightBlue)),
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                datePeriodBool = false;
              });
            },
            child: SizedBox(
              child: Center(
                  child: Text(
                "Tarihle",
              )),
              width: 100,
              height: 100,
            ),
            color: datePeriodBool ? Colors.white : Colors.lightBlue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(500.0),
                side: BorderSide(color: Colors.lightBlue)),
          ),
        ],
      ),
    );
  }

  Widget buildDatePickerField() {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "${_selectedDate.toLocal()}".split(' ')[0],
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () => _selectDate(context), // Refer step 3
            child: Text(
              'Tarih Seç',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            color: Colors.greenAccent,
          ),
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // Refer step 1
      firstDate: DateTime(2021),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Widget buildNameField() {
    return TextField(
      decoration:
          InputDecoration(labelText: "Plan Başlıgı", hintText: "Matematik"),
      controller: txtTitle,
    );
  }

  Widget buildDescriptionField() {
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(
          labelText: "Plan Açıklama", hintText: "Limit testi bitir"),
      controller: txtDescription,
    );
  }

  Widget buildPeriodField() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: DropdownButton(
          value: dropDownValue,
          items: [
            DropdownMenuItem(
              child: Text("Bugun"),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text("Yarın"),
              value: 2,
            ),
            DropdownMenuItem(child: Text("Haftalık"), value: 3),
            DropdownMenuItem(child: Text("Aylık"), value: 4),
            DropdownMenuItem(child: Text("Yıllık"), value: 5),
            DropdownMenuItem(child: Text("Uzun Vadeli"), value: 6)
          ],
          onChanged: (value) {
            setState(() {
              dropDownValue = value;
            });
          }),
    );
  }

  Widget buildSaveButton() {
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: () {
        if (datePeriodBool) {
          addPlan(Periodss.toDateTime(dropDownValue));
        } else {
          addPlan(_selectedDate);
        }
      },
    );
  }

  void addPlan(DateTime selectedDate) async {
    var result = await dbHelper.insert((Plan(
        title: txtTitle.text,
        description: txtDescription.text,
        dateTimeInt: selectedDate.microsecondsSinceEpoch)));
    Navigator.pop(context, true);
  }
}
