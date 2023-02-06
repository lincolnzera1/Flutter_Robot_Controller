//import 'dart:html';

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:num_remap/num_remap.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SlidePage(),
    );
  }
}

class SlidePage extends StatefulWidget {
  const SlidePage({super.key});

  @override
  State<SlidePage> createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> {
  double valor = 0;
  double porcentagem = 0;
  List<double> _accelData = List.filled(3, 0.0);
  StreamSubscription? _accelSubscription;

  Color cor = Colors.red;
  Color cor1 = Colors.blue;
  Color cor2 = Colors.green;
  Color cor3 = Colors.orange;
  Color corDinamica = const Color.fromARGB(255, 216, 58, 47);

  bool controle = false;
  bool controle1 = false;
  bool controle2 = false;
  bool controle3 = false;
  bool controleBarra = false;

  Future<void> _startAccelerometer() async {
    if (_accelSubscription != null) return;
    if (true) {
      final stream = await SensorManager().sensorUpdates(
        sensorId: Sensors.ACCELEROMETER,
        interval: Sensors.SENSOR_DELAY_FASTEST,
      );
      _accelSubscription = stream.listen((sensorEvent) {
        setState(() {
          _accelData = sensorEvent.data;
          print("Acceldata: ${_accelData[0].ceil()}");
          if(_accelData[0].ceil() >= 10){
            controleBarra = true;
          }
          if(_accelData[0].ceil() <= -10){
            controleBarra = false;
          }
        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _startAccelerometer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* Container(
              height: 100,
              width: 1000,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  left: BorderSide(width: valor*1000, color: valor*1000 >= 500 ? Colors.red : corDinamica)
                )
              ),
            ), */

            AnimatedContainer(
              height: 100,
              width: 1000,
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear,
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(
                          width: (_accelData[0]).remap(-10, 10, 0, 500) > 0
                              ? (_accelData[0]).remap(-10, 10, 0, 500)
                              : 0,
                          color:
                              valor * 1000 > 390 ? Colors.red : corDinamica)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 5,
                      spreadRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                  color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "[0](X) = ${(_accelData[0]).remap(-10, 10, 0, 100).ceil()}",
              textAlign: TextAlign.center,
            ),
            /* Container(
              height: 100,
              width: 1000,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(width: valor*1000, color: Colors.red)
                )
              ),
            ), */
            /* Slider(
              value: valor, 
              onChanged: (v){
                setState(() {
                  valor = v;
                  porcentagem = v;
                  print(v*1000);
                });
              }
            ), */
            /* Container(
              height: 100,
              width: 100,
              color: controle ? cor : Colors.white,
            ), */
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                /* Container(
                  height: 100,
                  width: 100,
                  color: controle1 ? cor1 : Colors.white,
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: controle2 ? cor2 : Colors.white,
                ), */
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              width: 100,
              color: controle3 ? cor3 : Colors.white,
            ),
            const SizedBox(
              height: 50,
            ),
            /* Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Listener(
                  onPointerUp: (event) {
                    setState(() {
                      controle = false;
                    });
                  },
                  onPointerDown: (event) {
                    setState(() {
                      controle = true;
                      if (controle && controle2) {
                        print("direita e cima");
                      } else {
                        print('cima');
                      }
                    });
                  },
                  child: Container(
                    color: Colors.red,
                    height: 60,
                    width: 60,
                    child: Center(child: Text("CIMA")),
                  ),
                ),
                SizedBox(
                  width: 80,
                ),
                Listener(
                  onPointerUp: (event) {
                    setState(() {
                      controle2 = false; // false quando solta
                    });
                  },
                  onPointerDown: (event) {
                    setState(() {
                      controle2 = true;
                      if (controle && controle2) {
                        print("cima e direita");
                      } else {
                        print("direita");
                      }
                    });
                  },
                  child: Container(
                    color: Colors.red,
                    height: 60,
                    width: 60,
                    child: Center(child: Text("DIREITA")),
                  ),
                ),
              ],
            ), */
            AnimatedContainer(
              height: 100,
              width: 1000,
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear,
              decoration: BoxDecoration(
                  border: Border(

                    
                    
                      left: BorderSide(
                          width: (_accelData[0]).remap(-10, 10, 0, 500) > 0
                              ? (_accelData[0]).remap(-10, 10, 0, 500)
                              : 0,
                          color:
                              valor * 1000 > 390 ? Colors.red : corDinamica)
                          ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 5,
                      spreadRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
