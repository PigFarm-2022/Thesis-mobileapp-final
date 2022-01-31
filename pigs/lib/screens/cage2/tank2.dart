import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class tanks2 extends StatefulWidget {
  @override
  _tanks2State createState() => _tanks2State();
}

class _tanks2State extends State<tanks2> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  double water_percent = 0.0;
  int water_level = 0;

  double feed_percent = 0.0;
  int feed_level = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tank1();
    _tank2();
  }

  void _tank1() {
    final StreamSubscription<DatabaseEvent> _testRef = FirebaseDatabase.instance
        .ref()
        .child("tanks/water_tank")
        .onValue
        .listen((event) {
      final int description = jsonDecode(jsonEncode(event.snapshot.value));
      setState(() {
        water_percent = description / 100;
        water_level = description;
      });
    });
  }

  void _tank2() {
    final StreamSubscription<DatabaseEvent> _testRef = FirebaseDatabase.instance
        .ref()
        .child("cage_2/feed_tank_2")
        .onValue
        .listen((event) {
      final int description = jsonDecode(jsonEncode(event.snapshot.value));
      setState(() {
        feed_percent = description / 100;
        feed_level = description;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TANKS"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            "Water",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          Center(
            child: CircularPercentIndicator(
              radius: 100,
              lineWidth: 20,
              percent: water_percent,
              progressColor: Colors.blue,
              backgroundColor: Colors.blue.shade100,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                water_level.toString() + "%",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 50),
          const Text(
            "Feed",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          Center(
            child: CircularPercentIndicator(
              radius: 100,
              lineWidth: 20,
              percent: feed_percent,
              progressColor: Colors.blue,
              backgroundColor: Colors.blue.shade100,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                feed_level.toString() + "%",
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}