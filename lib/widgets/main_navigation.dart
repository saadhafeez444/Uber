import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project/screens/create_request.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/offer.dart';
import 'package:project/screens/rate_review.dart';
import 'package:project/screens/tracking.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _page = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    CreateRequestScreen(),
    TrackingScreen(),
    OffersScreen(),
    RateReviewScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_page],
      bottomNavigationBar: CurvedNavigationBar(
        index: _page,
        height: 60,
        backgroundColor: Colors.transparent,
        color: Colors.orangeAccent,
        buttonBackgroundColor: Colors.orange,
        animationDuration: const Duration(milliseconds: 400),
        items: const [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.add_box_outlined, color: Colors.white),
          Icon(Icons.map_outlined, color: Colors.white),
          Icon(Icons.history_outlined, color: Colors.white),
        ],
        onTap: (i) => setState(() => _page = i),
      ),
    );
  }
}
