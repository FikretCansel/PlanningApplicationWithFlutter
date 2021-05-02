import 'package:Hedefyolu/data/dbHelper.dart';
import 'package:Hedefyolu/models/Plan.dart';
import 'package:Hedefyolu/screens/plan_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GetStartedState();
  }
}

class GetStartedState extends State {

  TextEditingController _text=new TextEditingController();
  bool _validation = false;
  var dbHelper = new DbHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(
      body: Center(
            child: Container(
                width: 300,
                height: 600,
            child:
            SingleChildScrollView(
              child: Column(
          children: [
              getImage(),
              //TextBox

              Text("Başarıya giden yol hedefler koymak ve o yolda ilerlemektir."
                  "Herşey her zaman istedigin gibi olmayabilir ama kalkıp devam etmek gerekir. Hadi hedefini gir ve HedefYolunda adım at.",
                style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
              ),

              SizedBox(height: 30,),

              TextField(controller:_text ,decoration: InputDecoration(hintText: "Hedefin Ne?",errorText: _validation?"Hedefini gir":null),),

              SizedBox(height: 30,),

              ElevatedButton(
                child: Center(child: Text("Hadi Başlayalım"),),
                  onPressed: () async{
                    setState(() {
                      _text.text.isEmpty ? _validation=true: _validation=false;
                    });
                    if(!_validation){
                      var now=DateTime.now();
                       await dbHelper.insert(
                          Plan(
                              dateTimeInt: DateTime(now.year+11,now.month,now.day).microsecondsSinceEpoch,
                              title: _text.text,
                              description: ""
                          )

                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PlanList()));
                    }

                  }
                  ),
          ],
        ),
            )),
    ));
  }

  Widget getImage() {
    return Image(
        image: AssetImage('images/getStartedPic.jpg'));
  }
}
