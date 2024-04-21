import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'World.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WordState()));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _controller,
              child: Container(
                height: 300,
                width: 300,
                child: Image(
                  image: AssetImage("Images/virus.png"),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              }),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.5,
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                'Covid 19 Tracker App',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
