import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //defining channel
  static const String _channelName = "huzaif/battery";
  static const _channel = MethodChannel(_channelName);
  String batteryLevel = 'Unknown';
  // Method for channel invoke

  Future<Void?> _getBatteryLevel() async {
    String _batteryLevel;
    try {
      final int result = await _channel.invokeMethod('getBatteryLevel');
      _batteryLevel = 'Battery Level at $result';
    } on PlatformException catch (e) {
      _batteryLevel = "Failed";
      log(e.message.toString());
    }
    setState(() {
      batteryLevel = _batteryLevel;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(batteryLevel),
            IconButton(
                onPressed: _getBatteryLevel, icon: Icon(Icons.battery_5_bar))
          ],
        ),
      ),
    );
  }
}
