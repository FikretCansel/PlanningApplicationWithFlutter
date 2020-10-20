class Plan{
  int id;
  String title;
  String description;
  String day;

  Plan({this.title,this.description,this.day});
  Plan.withId({this.id , this.title,this.description,this.day});

  Map<String,dynamic> toMap(){
    var map=new Map<String,dynamic>();//new e gerek yok ama yinede yazdım
    map["title"]=title;
    map["description"]=description;
    map["day"]=day;
    if(id!=null){
      map["id"]=id;
    }
    return map;
  }


  Plan.fromObject(dynamic o){
    this.id=int.tryParse(o["id"].toString());
    this.title=o["title"];
    this.description=o["description"];
    this.day=o["day"];
  }
}