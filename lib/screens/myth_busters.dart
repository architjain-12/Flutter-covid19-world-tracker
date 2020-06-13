import 'package:flutter/material.dart';

class MythBusters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Container(
            decoration: BoxDecoration(
                  gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: [Color(0xff02aab0) , Color(0xff00adbc), ] ),
            ),
            child: CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  primary: true,
                  floating: true,
                  elevation: 20.0,
                  backgroundColor: Color(0xffeecda),
                  snap: true,
                  title: Text('Myth-Busters' , style: TextStyle(fontSize: 25.0 , fontWeight: FontWeight.bold , color: Colors.yellow[700]),),
                ),
                SliverPadding(padding: EdgeInsets.fromLTRB(20 ,10, 20 , 10),
                sliver: SliverToBoxAdapter(
                  child: Text('There is a lot of false information around. These are the facts.' ,style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.white),),
                ),
                ),
                SliverPadding(padding: EdgeInsets.fromLTRB(20 ,10, 20 , 10),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('FACTS' ,style: TextStyle(fontSize: 22 , fontWeight: FontWeight.bold , color: Colors.yellow[600]),),
                      Divider(color: Colors.white38 , indent: 50.0, endIndent: 50.0, thickness: 1.8,),
                    ],
                  ),
                ),
                ),
                MythCard(imagePath: 'assets/images/myths/cold_icon.png', text: 'Cold weather and snow CANNOT kill the CoronaVirus .'),
                MythCard(imagePath: 'assets/images/myths/corona_in_heat.png', text: 'The coronavirus CAN be transmitted in areas with hot and humid climates.'),
                MythCard(imagePath: 'assets/images/myths/mosquito.png', text: 'The coronavirus CANNOT be transmitted through mosquito bites.'),
                MythCard(imagePath: 'assets/images/myths/dog.png', text: 'There is NO evidence that companion animals/pets such as dogs or cats can transmit the coronavirus.'),
                MythCard(imagePath: 'assets/images/myths/hot_bath.png', text: 'Taking a hot bath DOES NOT prevent the coronavirus.'),
                MythCard(imagePath: 'assets/images/myths/hand_dryer.png', text: 'Hand dryers are NOT effective in killing the coronavirus.'),
                MythCard(imagePath: 'assets/images/myths/ultraviolet_light.png', text: 'Ultraviolet light SHOULD NOT be used for sterilization and can cause skin irritation.'),
                MythCard(imagePath: 'assets/images/myths/thermal_scanner.png', text: 'Thermal scanners CAN detect if people have a fever but CANNOT detect whether or not someone has the coronavirus.'),
                MythCard(imagePath: 'assets/images/myths/alcohol.png', text: 'Spraying alcohol or chlorine all over your body WILL NOT kill viruses that have already entered your body.'),
                MythCard(imagePath: 'assets/images/myths/vaccine.png', text: 'Vaccines against pneumonia, such as pneumococcal vaccine and Haemophilus influenzae type b (Hib) vaccine, DO NOT provide protection against the coronavirus.'),
                MythCard(imagePath: 'assets/images/myths/saline_water.png', text: 'There is NO evidence that regularly rinsing the nose with saline has protected people from infection with the coronavirus.'),
                MythCard(imagePath: 'assets/images/myths/garlic.png', text: 'Garlic is healthy but there is NO evidence from the current outbreak that eating garlic has protected people from the coronavirus.'),
                MythCard(imagePath: 'assets/images/myths/antibiotics.png', text: 'Antibiotics DO NOT work against viruses, antibiotics only work against bacteria.'),
                MythCard(imagePath: 'assets/images/myths/medicine.png', text: 'To date, there is NO specific medicine recommended to prevent or treat the coronavirus.'),
                SliverPadding(padding: EdgeInsets.fromLTRB(20 ,10, 20 , 10),
                sliver: SliverToBoxAdapter(
                  child: Divider(color: Colors.white38 , indent: 50.0, endIndent: 50.0, thickness: 1.8,),
                ),
                ),
                SliverPadding(padding: EdgeInsets.fromLTRB(20 ,10, 20 , 10),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.info , color: Colors.white,),
                      Text(' : Content is sourced from mygov.in/covid-19' , style: TextStyle(color: Colors.white ),)
                    ],
                  ),
                ),
                ),
              ],
            )
      ),
    );
  }
}

class MythCard extends StatelessWidget {
  final String text;
  final String imagePath;
  MythCard({this.text , this.imagePath});
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(20 ,5, 20 , 5),
    sliver: SliverToBoxAdapter(
      child: Card(
        color: Colors.transparent,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 5 , horizontal: 5),
          leading: Image.asset('$imagePath'),
          title: Text('$text', style: TextStyle(fontFamily: 'Monteserat' , color: Colors.white, letterSpacing: 1.1 ),),
        ),
      ),
    ),
    );
  }
}