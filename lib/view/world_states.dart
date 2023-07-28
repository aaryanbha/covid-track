import 'package:covidtracker_app/Services/WorldStatesServices.dart';
import 'package:covidtracker_app/view/Track_countries.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class WorldStatesScreen extends StatefulWidget{
  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}
class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin{
  late final AnimationController _controller  = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  WorldStateServices worldrecords = WorldStateServices();
  @override
  final colorList =<Color> [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height* 0.01,),
              FutureBuilder(
                future: worldrecords.getWorldRecords(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return Column(
                      children: [
                        PieChart(
                          dataMap:{
                            "Total":double.parse(snapshot.data!.cases.toString()),
                            "Recovered":double.parse(snapshot.data!.recovered.toString()),
                            "Deaths":double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartType: ChartType.ring,
                          colorList: colorList,
                          chartRadius: MediaQuery.of(context).size.width/3.2,
                          legendOptions:LegendOptions(legendPosition: LegendPosition.left),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 60,
                            left: 8,
                            right: 8,
                            bottom: 8,
                          ),
                          child: Card(
                            child: Column(
                              children: [
                                ReuseableRow(title: "Total Cases",value:snapshot.data!.cases.toString()),
                                ReuseableRow(title: "Recovered ",value:snapshot.data!.recovered.toString()),
                                ReuseableRow(title: "Deaths",value:snapshot.data!.deaths.toString()),
                                ReuseableRow(title: "Active Cases",value:snapshot.data!.active.toString()),
                                ReuseableRow(title: "Tests ",value:snapshot.data!.tests.toString()),
                                ReuseableRow(title: "Today Cases",value:snapshot.data!.todayCases.toString()),
                                ReuseableRow(title: "Today Recovered",value:snapshot.data!.todayRecovered.toString()),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top:40,
                            bottom: 10,
                          ),
                          child: GestureDetector(
                            child: Container(
                              child: Center(child: Text('Track Countries',style:TextStyle(color: Colors.white,fontSize: 23,))),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => Track_Countries(),));
                            },
                          ),
                        )
                      ],
                    );
                  }
                  else{
                    return Expanded(
                      flex: 1,
                        child: SpinKitFadingCircle(
                          controller: _controller,
                          color: Colors.white,
                          duration: Duration(seconds: 5),
                        ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ReuseableRow extends StatelessWidget{
  String title,value;
  ReuseableRow({Key? key,required this.title,required this.value}):super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: 8,
      ),
      child: Column(
        children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(title),
                 Text(value),
               ],
             ),
             SizedBox(height: 5),
             Divider(),
        ],
      ),
    );
  }

}

