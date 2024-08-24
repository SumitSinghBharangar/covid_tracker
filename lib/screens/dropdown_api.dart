
import 'package:flutter/material.dart';

import '../services/state_services.dart';

class DropDownApi extends StatefulWidget {
  const DropDownApi({super.key});

  @override
  State<DropDownApi> createState() => _DropDownApiState();
}

class _DropDownApiState extends State<DropDownApi> {
  var selectedvalue;
  @override
  Widget build(BuildContext context) {
    StateServices obj = StateServices();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dropdown Api"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
                future: obj.getPostApi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton(
                      hint: const Text("select value"),
                      value: selectedvalue,
                      items: snapshot.data!.map((e) {
                        return DropdownMenuItem(
                          value: e.id.toString(),
                          child: Text(
                            e.id.toString(),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedvalue = value;
                        setState(() {});
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                })
          ],
        ),
      ),
    );
  }
}