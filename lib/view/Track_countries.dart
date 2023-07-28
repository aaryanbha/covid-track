import 'package:covidtracker_app/Services/WorldStatesServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'detail_screen.dart';

class Track_Countries extends StatefulWidget{
  @override
  State<Track_Countries> createState() => _Track_CountriesState();
}
class _Track_CountriesState extends State<Track_Countries> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    WorldStateServices countriesListViewer = WorldStateServices();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchcontroller,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  hintText: 'Select Country',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  )
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: countriesListViewer.countriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>>  snapshot){
                  print(snapshot);
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        String Name = snapshot.data![index]['country'];
                        if(searchcontroller.text.isEmpty){
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetailScreen(
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'] ,
                                    totalCases:  snapshot.data![index]['cases'] ,
                                    totalRecovered: snapshot.data![index]['recovered'] ,
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    critical: snapshot.data![index]['critical'] ,
                                  )));
                                },
                                child: ListTile(
                                  // title: snapshot.data![index]['country'],
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text("Effected: "+snapshot.data![index]['cases'].toString()),
                                ),
                              ),
                            ],
                          );
                        }
                        else if(Name.toLowerCase().contains(searchcontroller.text.toLowerCase())){
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetailScreen(
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'] ,
                                    totalCases:  snapshot.data![index]['cases'] ,
                                    totalRecovered: snapshot.data![index]['recovered'] ,
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    critical: snapshot.data![index]['critical'] ,
                                  )));
                                },
                                child: ListTile(
                                  // title: snapshot.data![index]['country'],
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text("Effected: "+snapshot.data![index]['cases'].toString()),
                                ),
                              ),
                            ],
                          );
                        }
                        else{
                          return Container();
                        }
                      },);
                  }else{
                    return Shimmer.fromColors(
                        baseColor: Colors.grey.shade500,
                        highlightColor: Colors.grey.shade100,
                        enabled:  true,
                        child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index){
                            return Column(
                              children: [
                                ListTile(
                                  // title: snapshot.data![index]['country'],
                                  leading: Container(
                                    color: Colors.white,
                                 height: 50,
                                      width: 50,
                            ),
                                  title: Container(
                                    width: 100,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    width: 100,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          },),
                    );
                  }
                  },
              ),
            )

          ],
        ),
      ),
    );
  }
}