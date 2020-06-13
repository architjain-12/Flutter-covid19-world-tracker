class District{
  String cityName;

  District(this.cityName);

  factory District.fromJSON(Map<String,dynamic> json)
  {
    return District(json[0]);
  }
}



class CityList{
  String stateName;
  List<District> districts;

  CityList(this.stateName , this.districts);

  factory CityList.fromJSON(Map<String,dynamic> parsedJson){
    if(parsedJson == null){
      return null;
    }
    else{
      return CityList(parsedJson["state"] , parsedJson['districts']);
    }
  }
}