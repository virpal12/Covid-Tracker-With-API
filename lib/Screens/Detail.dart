import 'package:covid_tracker/Screens/World.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases, totalDeaths, active, critical;
  DetailScreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.active,
    required this.critical,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade200,
          title: Text(
            widget.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * .067),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.sizeOf(context).height * .06),
                          ReusableRow(
                              title: 'cases',
                              value: widget.totalCases.toString()),
                          ReusableRow(
                              title: 'Deaths',
                              value: widget.totalDeaths.toString()),
                          ReusableRow(
                              title: 'Critical',
                              value: widget.critical.toString()),
                          ReusableRow(
                              title: 'cases',
                              value: widget.totalCases.toString()),
                          ReusableRow(
                              title: 'Active cases',
                              value: widget.active.toString())
                        ],
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ));
  }
}
