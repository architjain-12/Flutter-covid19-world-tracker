import 'package:flutter/material.dart';
import 'package:covid19/utilities/http.dart';
import 'package:covid19/utilities/city_data.dart';
import 'dart:convert';
import 'package:covid19/widgets/stats_grid.dart';
import 'package:covid19/components/city_list.dart';

class StateScreen extends StatefulWidget {
  final stateName;
  final totalCases;
  final totalInfected;
  final totalDeaths;
  final totalRecovered;
  StateScreen({this.stateName , this.totalCases , this.totalDeaths , this.totalInfected ,this.totalRecovered});
  @override
  _StateScreenState createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {
  int index;
  String stateName;
  int totalCases;
  int totalInfected;
  int totalDeaths;
  int totalRecovered;
  void getStateData(String sName , int tCases , int tInfected , int tDeaths , int tRecovered){
      stateName = sName;
      totalCases = tCases;
      totalInfected = tInfected;
      totalDeaths = tDeaths;
      totalRecovered = tRecovered;
  }
  

  Map<String,dynamic> data = jsonDecode(cities);
  

  @override
  void initState() {
    getStateData(widget.stateName , widget.totalCases , widget.totalInfected , widget.totalDeaths , widget.totalRecovered);
    _getCities();
    super.initState();
  }

    dynamic getStateDataforDistricts() async{
      FetchData fetchData = FetchData('https://api.covid19india.org/state_district_wise.json');
       var stateData = await fetchData.getData();
      return stateData;
    }

    dynamic getDistricts(){
     var districtList=[];
      for (var i=0 ; i<data['states'].length ; i+=1)
      {
        if(data['states'][i]['state'].toString() == stateName )
        {
          for (var j = 0; j<data['states'][i]['districts'].length ; j++)
            {
              districtList.add(data['states'][i]['districts'][j].toString());
            }
          break;
        }
      }
      return districtList;
    }

    Future<List<City>> _getCities() async {
      var districtList = getDistricts();
      var stateData = await getStateDataforDistricts();
        List<City> cityList = [];
        for(var i=0 ; i<districtList.length ; i++)
          {
            if(stateData['$stateName']['districtData']['${districtList[i]}'] != null){
            var districtName = districtList[i].toString();
            int activeCases = stateData['$stateName']['districtData']['${districtList[i]}']['active'].toInt();
            int deceasedCases = stateData['$stateName']['districtData']['${districtList[i]}']['deceased'].toInt();
            int confirmedCases = stateData['$stateName']['districtData']['${districtList[i]}']['confirmed'].toInt();
            int recoveredCases = stateData['$stateName']['districtData']['${districtList[i]}']['recovered'].toInt();
            City cityData = City(districtName , activeCases , confirmedCases , deceasedCases , recoveredCases);
            cityList.add(cityData);
            
            }
            else{
              continue;
            }
          }
      return cityList;
      }


  @override
  Widget build(BuildContext context) {
    getStateDataforDistricts();
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0,),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: (){
                        Navigator.pop(context);
                      },
                      ),
                    ],
                  ),
              Column(
                children: <Widget>[
                  Wrap(
                    children: <Widget>[
                      Expanded(child: Text('$stateName' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25.0),
                      overflow: TextOverflow.clip
                      ),
                      ),
                    ],
                  ),
                ],
              ),
                ],
              ),


              Container(
                margin: EdgeInsets.only(top:10),
                  child: StatsGrid(totalCases: totalCases , totalDeaths: totalDeaths, totalInfected: totalInfected , totalRecovered: totalRecovered),
              ),



              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Districts',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                future: _getCities(),
                builder: (BuildContext context , AsyncSnapshot snapshot){
                  if(snapshot.data == null)
                  {
                    return Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 200.0),
                          child: Text('Loading...'),
                        ),
                      ),
                    );
                  }
                  else{
                  return Expanded(
                        child: ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context , int index){
                            // return ListTile(
                            //   title: Text(snapshot.data[index].cityName.toString(), style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold)),
                            //   subtitle: Text('Confirmed: ${snapshot.data[index].confirmed.toString()} \nDeceased: ${snapshot.data[index].deceased.toString()} \nRecovered ${snapshot.data[index].recovered.toString()}'),
                            // );
                            return CityCardList(
                             cityName: snapshot.data[index].cityName,
                             totalCases: snapshot.data[index].confirmed,
                             totalDeaths: snapshot.data[index].deceased,
                             totalRecovered: snapshot.data[index].recovered,
                            //  totalInfected: snapshot.data[index].totalInfected,
                              );
                        }
                      ),
                  );
                  }
                }
              ),
            Row(
              children: <Widget>[
                Expanded(
                                  child: FlatButton(
                    onPressed: () => Navigator.pop(context),
                      child: Icon(Icons.expand_less , size: 30,)
                      ),
                ),
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }


  static String cities = '{"states":[{"state":"Andaman and Nicobar Islands","districts":["Nicobars","North and Middle Andaman","South Andaman"]},{"state":"Andhra Pradesh","districts":["Foreign Evacuees","Anantapur","Chittoor","East Godavari","Guntur","Krishna","Kurnool","Other State","Prakasam","S.P.S. Nellore" ,"Srikakulam","Visakhapatnam","Vizianagaram","West Godavari","Y.S.R Kadapa","Unknown"]},{"state":"Arunachal Pradesh","districts":["Tawang","West Kameng","East Kameng","Papum Pare","Kurung Kumey","Pakke Kessang","Kra Daadi","Kamle","Lower Subansiri","Upper Subansiri","West Siang","East Siang","Siang","Upper Siang","Lower Siang","Lower Dibang Valley","Upper Dibang Valley","Dibang Valley","Anjaw","Shi Yomi","Lohit","Namsai","Changlang","Tirap","Lepa Rada","Longding"]},{"state":"Assam","districts":["Baksa","Barpeta","Biswanath","Bongaigaon","Cachar","Charaideo","Chirang","Darrang","Dhemaji","Dhubri","Dibrugarh","Dima Hasao","Goalpara","Golaghat","Hailakandi","Hojai","Jorhat","Kamrup Metropolitan","Kamrup","Karbi Anglong","Karimganj","Kokrajhar","Lakhimpur","Majuli","Morigaon","Nagaon","Nalbari","Sivasagar","Sonitpur","South Salmara Mankachar","Tinsukia","Udalguri","West Karbi Anglong","Other State","Unknown"]},{"state":"Bihar","districts":["Araria","Arwal","Aurangabad","Banka","Begusarai","Bhagalpur","Bhojpur","Buxar","Darbhanga","East Champaran","Gaya","Gopalganj","Jamui","Jehanabad","Kaimur","Katihar","Khagaria","Kishanganj","Lakhisarai","Madhepura","Madhubani","Munger","Muzaffarpur","Nalanda","Nawada","Patna","Purnia","Rohtas","Saharsa","Samastipur","Saran","Sheikhpura","Sheohar","Sitamarhi","Siwan","Supaul","Vaishali","West Champaran"]},{"state":"Chandigarh","districts":["Chandigarh"]},{"state":"Chhattisgarh","districts":["Balod","Baloda Bazar","Balrampur","Bastar","Bemetara","Bijapur","Bilaspur","Dakshin Bastar Dantewada","Dhamtari","Durg","Gariaband","Janjgir Champa","Jashpur","Kabeerdham","Uttar Bastar Kanker","Kondagaon","Korba","Koriya","Mahasamund","Mungeli","Narayanpur","Raigarh","Raipur","Rajnandgaon","Sukma","Surajpur  ","Surguja"]},{"state":"Dadra and Nagar Haveli and Daman and Diu","districts":["Dadra and Nagar Haveli","Daman","Diu"]},{"state":"Delhi","districts":["Central Delhi","East Delhi","New Delhi","North Delhi","North East  Delhi","North West  Delhi","Shahdara","South Delhi","South East Delhi","South West  Delhi","West Delhi","Unknown"]},{"state":"Goa","districts":["North Goa","South Goa"]},{"state":"Gujarat","districts":["Ahmedabad","Amreli","Anand","Aravalli","Banaskantha","Bharuch","Bhavnagar","Botad","Chhota Udepur","Dahod","Dangs","Devbhoomi Dwarka","Gandhinagar","Gir Somnath","Jamnagar","Junagadh","Kachchh","Kheda","Mahisagar","Mehsana","Morbi","Narmada","Navsari","Panchmahal","Patan","Porbandar","Rajkot","Sabarkantha","Surat","Surendranagar","Tapi","Vadodara","Valsad"]},{"state":"Haryana","districts":["Foreign Evacuees","Ambala","Bhiwani","Charkhi Dadri","Faridabad","Fatehabad","Gurugram","Hisar","Italians","Jhajjar","Jind","Kaithal","Karnal","Kurukshetra","Mahendragarh","Nuh","Palwal","Panchkula","Panipat","Rewari","Rohtak","Sirsa","Sonipat","Yamunanagar"]},{"state":"Himachal Pradesh","districts":["Bilaspur","Chamba","Hamirpur","Kangra","Kinnaur","Kullu","Lahaul and Spiti","Mandi","Shimla","Sirmaur","Solan","Una"]},{"state":"Jammu and Kashmir","districts":["Anantnag","Bandipore","Baramulla","Budgam","Doda","Ganderbal","Jammu","Kargil","Kathua","Kishtwar","Kulgam","Kupwara","Mirpur","Muzaffarabad","Punch","Pulwama","Rajouri","Ramban","Reasi","Samba","Shopiyan","Srinagar","Udhampur"]},{"state":"Jharkhand","districts":["Bokaro","Chatra","Deoghar","Dhanbad","Dumka","East Singhbhum","Garhwa","Giridih","Godda","Gumla","Hazaribag","Jamtara","Khunti","Koderma","Latehar","Lohardaga","Pakur","Palamu","Ramgarh","Ranchi","Sahibganj","Seraikela-Kharsawan","Simdega","West Singhbhum"]},{"state":"Karnataka","districts":["Bagalkote","Ballari","Belagavi","Bengaluru Rural","Bengaluru Urban","Bidar","Chamarajanagar","Chikkballapura","Chikkamagaluru","Chitradurga","Dakshina Kannada","Davanagere","Dharwad","Gadag","Hassan","Haveri","Kalaburagi","Kodagu","Kolar","Koppal","Mandya","Mysuru","Raichur","Ramanagara","Shivamogga","Tumakuru","Udupi","Uttara Kannada","Vijayapura","Yadgir"]},{"state":"Kerala","districts":["Alappuzha","Ernakulam","Idukki","Kannur","Kasaragod","Kollam","Kottayam","Kozhikode","Malappuram","Palakkad","Pathanamthitta","Thiruvananthapuram","Thrissur","Wayanad","Other State"]},{"state":"Ladakh","districts":["Kargil","Leh"]},{"state":"Lakshadweep","districts":["Lakshadweep","Agatti","Amini","Androth","Bithra","Chethlath","Kavaratti","Kadmath","Kalpeni","Kilthan","Minicoy"]},{"state":"Madhya Pradesh","districts":["Agar Malwa","Alirajpur","Anuppur","Ashoknagar","Balaghat","Barwani","Betul","Bhind","Bhopal","Burhanpur","Chhatarpur","Chhindwara","Damoh","Datia","Dewas","Dhar","Dindori","Guna","Gwalior","Harda","Hoshangabad","Indore","Jabalpur","Jhabua","Katni","Khandwa","Khargone","Mandla","Mandsaur","Morena","Narsinghpur","Neemuch","Niwari","Other Region","Panna","Raisen","Rajgarh","Ratlam","Rewa","Sagar","Satna","Sehore","Seoni","Shahdol","Shajapur","Sheopur","Shivpuri","Sidhi","Singrauli","Tikamgarh","Ujjain","Umaria","Vidisha"]},{"state":"Maharashtra","districts":["Ahmednagar","Akola","Amravati","Aurangabad","Beed","Bhandara","Buldhana","Chandrapur","Dhule","Gadchiroli","Gondia","Hingoli","Jalgaon","Jalna","Kolhapur","Latur","Mumbai","Mumbai Suburban","Nagpur","Nanded","Nandurbar","Nashik","Osmanabad","Other State","Palghar","Parbhani","Pune","Raigad","Ratnagiri","Sangli","Satara","Sindhudurg","Solapur","Thane","Wardha","Washim","Yavatmal"]},{"state":"Manipur","districts":["Bishnupur","Chandel","Churachandpur","Imphal East","Imphal West","Jiribam","Kakching","Kamjong","Kangpokpi","Noney","Pherzawl","Senapati","Tamenglong","Tengnoupal","Thoubal","Ukhrul","Unknown"]},{"state":"Meghalaya","districts":["East Garo Hills","East Jaintia Hills","East Khasi Hills","North Garo Hills","Ribhoi","South Garo Hills","South West Garo Hills ","South West Khasi Hills","West Garo Hills","West Jaintia Hills","West Khasi Hills","Unknown"]},{"state":"Mizoram","districts":["Aizawl","Champhai","Hnahthial","Khawzawl","Kolasib","Lawngtlai","Lunglei","Mamit","Saiha","Saitual","Serchhip"]},{"state":"Nagaland","districts":["Dimapur","Kiphire","Kohima","Longleng","Mokokchung","Mon","Peren","Phek","Tuensang","Wokha","Zunheboto"]},{"state":"Odisha","districts":["Angul","Balangir","Balasore","Bargarh","Bhadrak","Boudh","Cuttack","Deogarh","Dhenkanal","Gajapati","Ganjam","Jagatsinghpur","Jajpur","Jharsuguda","Kalahandi","Kandhamal","Kendrapara","Kendujhar","Khordha","Koraput","Malkangiri","Mayurbhanj","Nabarangpur","Nayagarh","Nuapada","Puri","Rayagada","Sambalpur","Sonepur","Subarnapur","Sundargarh","Unknown"]},{"state":"Puducherry","districts":["Karaikal","Mahe","Puducherry","Yanam"]},{"state":"Punjab","districts":["Amritsar","Barnala","Bathinda","Faridkot","Fatehgarh Sahib","Fazilka","Ferozepur","Gurdaspur","Hoshiarpur","Jalandhar","Kapurthala","Ludhiana","Mansa","Moga","Muktsar","Pathankot","Patiala","Rupnagar","Shahid Bhagat Singh Nagar","S.A.S. Nagar","Sangrur","Sri Muktsar Sahib","Tarn Taran"]},{"state":"Rajasthan","districts":["Ajmer","Alwar","Banswara","Baran","Barmer","Bharatpur","Bhilwara","Bikaner","BSF Camp","Bundi","Chittorgarh","Churu","Dausa","Dholpur","Dungarpur","Evacuees","Ganganagar","Hanumangarh","Italians","Jaipur","Jaisalmer","Jalore","Jhalawar","Jhunjhunu","Jodhpur","Karauli","Kota","Nagaur","Pali","Pratapgarh","Rajsamand","Sawai Madhopur","Sikar","Sirohi","Sri Ganganagar","Tonk","Udaipur","Other State"]},{"state":"Sikkim","districts":["East Sikkim","North Sikkim","South Sikkim","West Sikkim","Unknown"]},{"state":"Tamil Nadu","districts":["Ariyalur","Chengalpattu","Chennai","Coimbatore","Cuddalore","Dharmapuri","Dindigul","Erode","Kallakurichi","Kancheepuram","Kanyakumari","Karur","Krishnagiri","Madurai","Nagapattinam","Namakkal","Nilgiris","Perambalur","Pudukkottai","Ramanathapuram","Ranipet","Salem","Sivaganga","Tenkasi","Thanjavur","Theni","Thoothukudi","Tiruchirappalli","Tirunelveli","Tiruppur","Tiruvallur","Tiruvannamalai","Tiruvarur","Vellore","Viluppuram","Virudhunagar","Railway Quarantine","Airport Quarantine","Other State"]},{"state":"Telangana","districts":["Adilabad","Bhadradri Kothagudem","Hyderabad","Jagtial","Jangaon","Jayashankar Bhoopalpally","Jogulamba Gadwal","Kamareddy","Karimnagar","Khammam","Komaram Bheem","Mahabubabad","Mahabubnagar","Mancherial","Medak","Medchal Malkajgiri","Mulugu","Nagarkurnool","Nalgonda","Narayanpet","Nirmal","Nizamabad","Peddapalli","Rajanna Sircilla","Ranga Reddy","Sangareddy","Siddipet","Suryapet","Vikarabad","Wanaparthy","Warangal Rural","Warangal Urban","Yadadri Bhuvanagiri","Other State","Foreign Evacuees","Unknown"]},{"state":"Tripura","districts":["Dhalai","Gomati","Khowai","North Tripura","Sepahijala","South Tripura","Unakoti","West Tripura"]},{"state":"Uttarakhand","districts":["Almora","Bageshwar","Chamoli","Champawat","Dehradun","Haridwar","Nainital","Pauri Garhwal","Pithoragarh","Rudraprayag","Tehri Garhwal","Udham Singh Nagar","Uttarkashi"]},{"state":"Uttar Pradesh","districts":["Agra","Aligarh","Allahabad","Ambedkar Nagar","Amethi","Amroha","Auraiya","Ayodhya","Azamgarh","Baghpat","Bahraich","Ballia","Balrampur","Banda","Barabanki","Bareilly","Basti","Bhadohi","Bijnor","Budaun","Bulandshahr","Chandauli","Chitrakoot","Deoria","Etah","Etawah","Faizabad","Farrukhabad","Fatehpur","Firozabad","Gautam Buddha Nagar","Ghaziabad","Ghazipur","Gonda","Gorakhpur","Hamirpur","Hapur","Hardoi","Hathras","Jalaun","Jaunpur","Jhansi","Kannauj","Kanpur Dehat","Kanpur Nagar","Kasganj","Kaushambi","Kushinagar","Lakhimpur Kheri","Lalitpur","Lucknow","Maharajganj","Mahoba","Mainpuri","Mathura","Mau","Meerut","Mirzapur","Moradabad","Muzaffarnagar","Pilibhit","Pratapgarh","Prayagraj","Rae Bareli","Rampur","Saharanpur","Sambhal","Sant Kabir Nagar","Shahjahanpur","Shamali","Shrawasti","Siddharthnagar","Sitapur","Sonbhadra","Sultanpur","Unnao","Varanasi"]},{"state":"West Bengal","districts":["Alipurduar","Bankura","Birbhum","Cooch Behar","Dakshin Dinajpur","Darjeeling","Hooghly","Howrah","Jalpaiguri","Jhargram","Kalimpong","Kolkata","Malda","Murshidabad","Nadia","North 24 Parganas","Paschim Medinipur","Paschim Bardhaman","Purba Medinipur","Purba Medinipur","Purulia","South 24 Parganas","Uttar Dinajpur"]},{"state":"State Unassigned","districts":["Unassigned"]}]}';


}



