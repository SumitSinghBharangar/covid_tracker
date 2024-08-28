import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'world_states_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 3000))
    ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Timer(const Duration(milliseconds: 3200), () {
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => const WorldStatesScreen(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              AnimatedBuilder(
                  animation: _controller,
                  child: const SizedBox(
                    width: 200,
                    height: 200,
                    child: Center(
                      child: Image(
                        image: AssetImage("assets/images/viruspicimg.png"),
                      ),
                    ),
                  ),
                  builder: (BuildContext context, Widget? child) {
                    return Transform.rotate(
                      angle: _controller.value * 2.0 * math.pi,
                      child: child,
                    );
                  }),
              AnimatedBuilder(
                  animation: _controller,
                  child: const Positioned(
                    width: 200,
                    height: 200,
                    child: Positioned(
                      left: 10,
                      child: Image(
                        image: AssetImage("assets/images/viruspicimg.png"),
                      ),
                    ),
                  ),
                  builder: (BuildContext context, Widget? child) {
                    return Transform.rotate(
                      angle: _controller.value * 2.0 * math.pi,
                      child: child,
                    );
                  }),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              " Covid - 19 \nTracker App",
              style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
            ),
          )
        ],
      )),
    );
  }
}