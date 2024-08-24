
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../services/state_services.dart';
import 'detail_screen.dart';

class CountrylistScreen extends StatefulWidget {
  const CountrylistScreen({super.key});

  @override
  State<CountrylistScreen> createState() => _CountrylistScreenState();
}

class _CountrylistScreenState extends State<CountrylistScreen> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: searchcontroller,
              onChanged: (value) {
                setState(() {});
              },
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  hintText: "Search with Country Name"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Expanded(
              child: FutureBuilder(
                  future: stateServices.fecthCountryListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  height: 10,
                                  width: 90,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 90,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        );
                      });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]["country"];
                            if (searchcontroller.text.isEmpty) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    child: ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]["countryInfo"]
                                                ["flag"]),
                                      ),
                                      title: Text(
                                          snapshot.data![index]["country"]),
                                      subtitle: Text(snapshot.data![index]
                                              ["cases"]
                                          .toString()),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                              name: snapshot.data![index]
                                                  ["country"],
                                              image: snapshot.data![index]
                                                  ["countryInfo"]['flag'],
                                              test: snapshot.data![index]
                                                  ["tests"],
                                              totalcases: snapshot.data![index]
                                                  ["cases"],
                                              active: snapshot.data![index]
                                                  ["active"],
                                              todayCases: snapshot.data![index]
                                                  ["todayCases"],
                                              totalrecover: snapshot
                                                  .data![index]["recovered"],
                                              todayrecovered:
                                                  snapshot.data![index]
                                                      ["todayRecovered"],
                                              critical: snapshot.data![index]
                                                  ["critical"],
                                              totaldeaths: snapshot.data![index]
                                                  ["deaths"],
                                              todaydeaths: snapshot.data![index]
                                                  ["todayDeaths"],
                                            ),
                                          ));
                                    },
                                  )
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                searchcontroller.text.toLowerCase())) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    child: ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]["countryInfo"]
                                                ["flag"]),
                                      ),
                                      title: Text(
                                          snapshot.data![index]["country"]),
                                      subtitle: Text(
                                        snapshot.data![index]["cases"]
                                            .toString(),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                              name: snapshot.data![index]
                                                  ["country"],
                                              image: snapshot.data![index]
                                                  ["countryInfo"]['flag'],
                                              test: snapshot.data![index]
                                                  ["tests"],
                                              totalcases: snapshot.data![index]
                                                  ["cases"],
                                              active: snapshot.data![index]
                                                  ["active"],
                                              todayCases: snapshot.data![index]
                                                  ["todayCases"],
                                              totalrecover: snapshot
                                                  .data![index]["recovered"],
                                              todayrecovered:
                                                  snapshot.data![index]
                                                      ["todayRecovered"],
                                              critical: snapshot.data![index]
                                                  ["critical"],
                                              totaldeaths: snapshot.data![index]
                                                  ["deaths"],
                                              todaydeaths: snapshot.data![index]
                                                  ["todayDeaths"],
                                            ),
                                          ));
                                    },
                                  )
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  }),
            )
          ],
        ),
      )),
    );
  }
}