import 'package:Hedefyolu/data/dbHelper.dart';
import 'package:Hedefyolu/models/Periods.dart';
import 'package:Hedefyolu/models/Plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PlanDetail extends StatefulWidget {
  Plan plan;
  PlanDetail(this.plan);

  @override
  State<StatefulWidget> createState() {
    return PlanDetailState(this.plan);
  }
}

enum Options { delete, update }

class PlanDetailState extends State {
  Plan plan;
  PlanDetailState(this.plan);
  var dbHelper = DbHelper();
  TextEditingController txtPlan = new TextEditingController();
  TextEditingController txtDescription = new TextEditingController();
  String txtDay;
  bool datePeriodBool = true;
  DateTime _selectedDate;
  int dropDownValue;

  @override
  void initState() {
    // TODO: implement initState
    txtPlan.text = plan.title;
    txtDescription.text = plan.description;
    _selectedDate=DateTime.fromMicrosecondsSinceEpoch(plan.dateTimeInt);
    dropDownValue = Periodss.fromDateTime(_selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Hedef : ${plan.title}"),
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
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildNameField(),
            buildDescriptionField(),
            SizedBox(height: 10),
            buildMethodPicker(),
            SizedBox(height: 10),
            datePeriodBool ? buildPeriodField() : buildDatePickerField(),


          ],
        ),
      ),
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
            DropdownMenuItem(
                child: Text("Haftalık"),
                value: 3
            ),
            DropdownMenuItem(
                child: Text("Aylık"),
                value: 4
            ),
            DropdownMenuItem(
                child: Text("Yıllık"),
                value: 5
            ),
            DropdownMenuItem(
                child: Text("Uzun Vadeli"),
                value: 6
            )
          ],
          onChanged: (value) {
            setState(() {
              dropDownValue = value;
            });
          }),
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


  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await deletePlan();
        Navigator.pop(context, true);
        var alert = AlertDialog(
          title: Text("Tebrikler"),
          content: Text(plan.title + " " + "Tamamlandı :)"),
        );
        showDialog(context: context, builder: (BuildContext context) => alert);

        break;
      case Options.update:
        if(datePeriodBool){
         await updatePlan(Periodss.toDateTime(dropDownValue));
        }else{
         await updatePlan(_selectedDate);
        }
        Navigator.pop(context, true);
        break;
      default:
    }
  }
  updatePlan(DateTime dateTime) {
     dbHelper.update(Plan.withId(
        id: plan.id,
        title: txtPlan.text,
        description: txtDescription.text,
        dateTimeInt: dateTime
            .microsecondsSinceEpoch
    ));
  }
  deletePlan(){
     dbHelper.delete(plan.id);
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
      maxLines: 4,
      decoration: InputDecoration(
          labelText: "Plan Açıklama",hintText: "Limit testi bitir"

      ),
      controller: txtDescription,
    );
  }
}
