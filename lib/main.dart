import 'package:flutter/material.dart';
import 'package:project/widgets/main_navigation.dart';

void main() {
  runApp(const TruckShiftApp());
}

class TruckShiftApp extends StatelessWidget {
  const TruckShiftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TruckShift — Customer',
      home: const MainNavigation(), // only navigation here
    );
  }
}
