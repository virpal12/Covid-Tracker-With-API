import 'package:covid_tracker/Screens/Detail.dart';
import 'package:covid_tracker/Services/Utilities/State_Services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  TextEditingController Search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextField(
              controller: Search,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: 'Search with County Name',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: stateServices.countriesList(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.black,
                                ),
                                title: Container(
                                  height: 10,
                                  width: 90,
                                  color: Colors.black,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 90,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ));
                    });
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = Text(
                        snapshot.data![index]['country'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ).toString();

                      if (Search.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => DetailScreen(
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              name: snapshot.data![index]
                                                  ['country'],
                                              totalCases: snapshot.data![index]
                                                  ['cases'],
                                              totalDeaths: snapshot.data![index]
                                                  ['deaths'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                            )));
                              },
                              child: ListTile(
                                leading: Image(
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                  height: 50,
                                  width: 50,
                                ),
                                title: Text(
                                  snapshot.data![index]['country'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    "Total Cases : ${snapshot.data![index]['cases'].toString()}"),
                              ),
                            )
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(Search.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => DetailScreen(
                                          image: snapshot.data![index]
                                          ['countryInfo']['flag'],
                                          name: snapshot.data![index]
                                          ['country'],
                                          totalCases: snapshot.data![index]
                                          ['cases'],
                                          totalDeaths: snapshot.data![index]
                                          ['deaths'],
                                          active: snapshot.data![index]
                                          ['active'],
                                          critical: snapshot.data![index]
                                          ['critical'],
                                        )));
                              },
                              child: ListTile(
                                leading: Image(
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                  height: 50,
                                  width: 50,
                                ),
                                title: Text(
                                  snapshot.data![index]['country'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    "Total Cases : ${snapshot.data![index]['cases'].toString()}"),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Column();
                      }
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}
