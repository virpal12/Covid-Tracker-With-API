import 'package:covid_tracker/Model/WorldStateModel.dart';
import 'package:covid_tracker/Screens/Country_List.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Services/Utilities/State_Services.dart';

class WordState extends StatefulWidget {
  const WordState({super.key});

  @override
  State<WordState> createState() => _WordStateState();
}

class _WordStateState extends State<WordState> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        title: Text("Wolrd Covid's  Report", style: TextStyle(fontWeight: FontWeight.w600),),
        centerTitle: true,
        backgroundColor: Colors.grey.shade200,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10, top: 10, bottom: 5),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),
                FutureBuilder(
                    future: stateServices.fetchWorkStateRecord(),
                    builder:
                        (context, AsyncSnapshot<WorldStateModel> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                            flex: 1,
                            child: SpinKitFadingCircle(
                              color: Colors.black,
                              controller: _controller,
                            ));
                      } else {
                        return Column(
                          children: [
                            PieChart(
                            chartType:  ChartType.disc  ,                             chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true
                              ),
                              colorList: [Colors.blue, Colors.green, Colors.red],
                                chartRadius: 200,
                                animationDuration: Duration(milliseconds: 1200),
                                dataMap: {
                                  "Total ": double.parse(snapshot.data!.cases!.toString()),
                                  "Recovered": double.parse(snapshot.data!.recovered!.toString()),
                                  "Active":  double.parse(snapshot.data!.active!.toString()),
                                }),

                            SizedBox(height: 50,),
                            Container(
                              child: Column(
                                children: [
                                  ReusableRow(title: 'Active', value: snapshot.data!.active!.toString()),
                                  ReusableRow(title: 'Deaths', value: snapshot.data!.deaths!.toString()),
                                  ReusableRow(title: 'Recovered', value: snapshot.data!.recovered!.toString()),
                                  ReusableRow(title: 'Today Cases', value: snapshot.data!.todayCases!.toString()),
                                  ReusableRow(title: 'Critical ', value: snapshot.data!.critical!.toString()),
                                ],
                              ),
                            ),

                            SizedBox(height: 70,),

                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryList()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade600,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Track Countries',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(value),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Divider(),
      ],
    );
  }
}
