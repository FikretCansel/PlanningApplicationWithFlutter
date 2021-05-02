class Periodss{

  Periodss();

  static String getPeriodName(id){
    String period="";
    switch(id){
      case 1:
        period="Bugün";//today
        break;
      case 2:
        period="Yarın";//tomorrow
        break;
      case 3:
        period="Haftalık";//week
        break;
      case 4:
        period="Aylık";//month
        break;
      case 5:
        period="Yıllık";//year
        break;
      case 6:
        period="Temel";
        break;
    }
    return period;
    }

  static DateTime toDateTime(id){
    var dateTime;
    var now=DateTime.now();

    switch(id){
      case 1:
        dateTime=DateTime(now.year,now.month,now.day);//today
        break;
      case 2:
        dateTime=DateTime(now.year,now.month,now.day+1);//tomorrow
        break;
      case 3:
        dateTime=DateTime(now.year,now.month,now.day+7);//week
        break;
      case 4:
        dateTime=DateTime(now.year,now.month+1,now.day);//month
        break;
      case 5:
        dateTime=DateTime(now.year+1,now.month,now.day);//year
        break;
      case 6:
        dateTime=DateTime(now.year+10,now.month,now.day);
        break;
      default:
        dateTime=dateTime=DateTime(now.year,now.month+1,now.day);
        break;
    }
    return dateTime;
  }

  static int fromDateTime(DateTime dateTime){
    int differenceDay = (dateTime.year-DateTime.now().year)*365+(dateTime.month-DateTime.now().month)*30+dateTime.day-DateTime.now().day;
    int id;
    if(differenceDay==0) id=1;
    else if(differenceDay==1) id=2;
    else if(differenceDay<=7 && differenceDay>=2) id=3;
    else if(differenceDay<=30 && differenceDay>7) id=4;
    else if(differenceDay<=365 && differenceDay>30)id=5;
    else id=6;
    return id;
  }




}