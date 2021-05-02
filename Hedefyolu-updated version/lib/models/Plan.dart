class Plan{
  int id;
  String title;
  String description;
  int dateTimeInt;

  Plan({this.title,this.description,this.dateTimeInt});
  Plan.withId({this.id , this.title,this.description,this.dateTimeInt});

  Map<String,dynamic> toMap(){
    var map=new Map<String,dynamic>();//new e gerek yok ama yinede yazdım
    map["title"]=title;
    map["description"]=description;
    map["dateTimeInt"]=dateTimeInt;
    if(id!=null){
      map["id"]=id;
    }
    return map;
  }


  Plan.fromObject(dynamic o){
    this.id=int.tryParse(o["id"].toString());
    this.title=o["title"];
    this.description=o["description"];
    this.dateTimeInt=o["dateTimeInt"];
  }
}