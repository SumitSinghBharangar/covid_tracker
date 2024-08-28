// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'world_states_screen.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalcases,
      todayCases,
      todaydeaths,
      totaldeaths,
      totalrecover,
      critical,
      todayrecovered,
      test,
      active;
  DetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.test,
    required this.totalcases,
    required this.todayCases,
    required this.todayrecovered,
    required this.todaydeaths,
    required this.totalrecover,
    required this.active,
    required this.critical,
    required this.totaldeaths,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(widget.name),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Card(
                  elevation: 11,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                        ),
                        ReusableRow(
                          title: "Test",
                          value: widget.test.toString(),
                          fsize: 21,
                          clr: Colors.black,
                        ),
                        ReusableRow(
                          title: "Total-Cases",
                          value: widget.totalcases.toString(),
                          fsize: 21,
                          clr: Colors.black,
                        ),
                        ReusableRow(
                          title: "Active",
                          value: widget.active.toString(),
                          fsize: 21,
                          clr: Colors.black,
                        ),
                        ReusableRow(
                          title: "Today-Cases",
                          value: widget.todayCases.toString(),
                          fsize: 21,
                          clr: Colors.black,
                        ),
                        ReusableRow(
                          title: "Recovered",
                          value: widget.totalrecover.toString(),
                          fsize: 21,
                          clr: Colors.black,
                        ),
                        ReusableRow(
                          title: "Today-Recovered",
                          value: widget.todayrecovered.toString(),
                          fsize: 21,
                          clr: Colors.black,
                        ),
                        ReusableRow(
                          title: "Critical",
                          value: widget.critical.toString(),
                          fsize: 21,
                          clr: Colors.black,
                        ),
                        ReusableRow(
                          title: "Total-Death",
                          value: widget.totaldeaths.toString(),
                          fsize: 21,
                          clr: Colors.black,
                        ),
                        ReusableRow(
                          title: "Today-Death",
                          value: widget.todaydeaths.toString(),
                          fsize: 21,
                          clr: Colors.black,
                        ),
                      ],
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
        ),
      )),
    );
  }
}
