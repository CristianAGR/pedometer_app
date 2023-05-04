import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class StepsScreen extends StatefulWidget {
  StepsScreen({Key? key}) : super(key: key);

  @override
  State<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
  int stepCount = 0;
  Color stateColor = Colors.green;
  String url = "https://megadexter.com/uploads/dex/pkmn/official/pikachu.png";

  void setColor() {
    if (stepCount < 10) {
      stateColor = Colors.green;
      url = "https://megadexter.com/uploads/dex/pkmn/official/pikachu.png";
    } else if (stepCount < 20) {
      stateColor = Colors.amber;
      url = "https://i.blogs.es/08ab42/pokemon/840_560.jpeg";
    } else {
      stateColor = Colors.red;
      url = "https://pbs.twimg.com/media/C8P_QIzXgAEQ1s8.jpg";
    }
  }

  void resetStepCount() {
    setState(() {
      stepCount = 0;
      setColor();
    });
  }

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      double x = event.x;
      double y = event.y;
      double z = event.z;
      double acceleration = sqrt(x * x + y * y + z * z);
      if (acceleration > 10) {
        setState(() {
          stepCount++;
          setColor();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: stateColor,
      floatingActionButton: FloatingActionButton(onPressed: resetStepCount, child: Icon(Icons.restore_outlined, color: Colors.amberAccent,), backgroundColor: Colors.white),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text('Pasos: $stepCount', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 16),
            SizedBox(height: 16),
            Image.network(url)
          ],
        ),
      ),
    );
  }
}
