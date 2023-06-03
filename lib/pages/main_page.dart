import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:camera_market_app/pages/about_page.dart';
import 'package:camera_market_app/pages/admin_page/admin_page.dart';
import 'package:camera_market_app/pages/catalog_page.dart';
import 'package:camera_market_app/pages/home_page.dart';
import 'package:camera_market_app/pages/recommendation_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  List<Widget> pages = [
    const HomePage(),
    const CatalogPage(),
    const AboutPage(),
    const AdminPage(),
  ];

  List<IconData> icons = [
    Icons.home,
    Icons.list_alt,
    Icons.info,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedIndex == 0 ? Colors.grey : Colors.grey[200],
      body: pages[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 5,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const RecommendationPage()),
          );
        },
        child: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 24,
          child: Image.asset(
            "assets/icons/tumbup.png",
            width: 20,
          ),
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeIndex: selectedIndex,
        backgroundColor: Colors.white,
        activeColor: Colors.black,
        inactiveColor: Colors.grey,
        gapLocation: GapLocation.center,
        icons: icons,
        leftCornerRadius: 24,
        rightCornerRadius: 24,
        notchSmoothness: NotchSmoothness.sharpEdge,
        notchMargin: 0,
        shadow: const Shadow(
          color: Colors.grey,
          offset: Offset(0, 1),
          blurRadius: 10,
        ),
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
    );
  }
}
