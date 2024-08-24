// ignore_for_file: must_be_immutable

import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../models/world_state_model.dart';
import '../services/state_services.dart';
import 'country_list.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 3000))
    ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Color> colorslist = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FutureBuilder(
                future: stateServices.fecthWorldStaterecord(),
                builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.black,
                          size: 100,
                          controller: _controller,
                        ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            // "totoal": 30,
                            // "death": 20,
                            // "recovered": 10
                            "Death": double.tryParse(
                                    snapshot.data?.deaths?.toString() ?? '0') ??
                                0,
                            "total": double.tryParse(
                                    snapshot.data?.cases?.toString() ?? '0') ??
                                0,
                            "Recovered": double.tryParse(
                                    snapshot.data?.recovered?.toString() ??
                                        '0') ??
                                0,
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          animationDuration: const Duration(milliseconds: 2000),
                          chartType: ChartType.ring,
                          colorList: const [
                            Color(0xffde5246),
                            Color(0xff4285f4),
                            Color(0xff1aa260),
                          ],
                          chartRadius: 160,
                          ringStrokeWidth: 30,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        ReusableRow(
                          title: "total",
                          value: snapshot.data!.cases.toString(),
                          fsize: 21,
                          clr: Colors.black,
                        ),
                        ReusableRow(
                            title: "Recovered",
                            value: snapshot.data!.recovered.toString(),
                            fsize: 21,
                            clr: Colors.black),
                        ReusableRow(
                          title: "Death",
                          value: snapshot.data!.deaths.toString(),
                          fsize: 21,
                          clr: Colors.black,
                        ),
                        ReusableRow(
                          title: "Critical",
                          value: snapshot.data!.critical.toString(),
                          fsize: 21,
                          clr: Colors.black,
                        ),
                        ReusableRow(
                          title: "Active",
                          value: snapshot.data!.active.toString(),
                          fsize: 21,
                          clr: Colors.black,
                        ),
                        ReusableRow(
                          title: "Today Cases",
                          value: snapshot.data!.todayCases.toString(),
                          fsize: 21,
                          clr: Colors.black,
                        ),
                        ReusableRow(
                          title: "Today Recovered",
                          value: snapshot.data!.todayRecovered.toString(),
                          fsize: 21,
                          clr: Colors.black,
                        ),
                        ReusableRow(
                          title: "Today Death",
                          value: snapshot.data!.todayDeaths.toString(),
                          fsize: 21,
                          clr: Colors.black,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        GestureDetector(
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                color: Colors.purple),
                            child: Center(
                              child: loading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 4,
                                    )
                                  : const Text(
                                      "Track Countries",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              loading = true;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CountrylistScreen(),
                              ),
                            );
                            Timer(const Duration(milliseconds: 300), () {
                              loading = false;
                            });
                          },
                        ),
                      ],
                    );
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

class ReusableRow extends StatelessWidget {
  String title, value;
  double fsize;
  Color clr;
  ReusableRow(
      {super.key,
      required this.title,
      required this.value,
      required this.fsize,
      required this.clr});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: fsize, color: clr),
            ),
            Text(
              value,
              style: TextStyle(fontSize: fsize - 2, color: clr),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(
          color: Colors.black,
        )
      ],
    );
  }
}