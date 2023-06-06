import 'package:camera_market_app/widgets/camera_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:camera_market_app/pages/home_page.dart';
import 'package:camera_market_app/pages/about_page.dart';
import 'package:camera_market_app/pages/admin_page/admin_page.dart';
import 'package:camera_market_app/pages/recommendation_page.dart';
import 'package:camera_market_app/pages/catalog_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.waspasTempResult});
  static const routeName = '/resultPageRoute';

  final List<List> waspasTempResult;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<List> waspasResult = [];
  int? limit;
  bool switchTop5 = false;

  int selectedIndex = 2;

  final List<IconData> icons = const [
    Icons.home,
    Icons.list_alt,
    Icons.info,
    Icons.person,
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        waspasResult = widget.waspasTempResult;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference camera =
        FirebaseFirestore.instance.collection('camera');

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.only(top: 0),
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/backarrow.svg',
              color: Color(0xFF262626),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 0),
          child: SizedBox(
            height: 30,
            width: 124.09,
            child: SvgPicture.asset(
              'assets/icons/logo.svg',
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Color(0xFFEAEAEA),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Rating Terbaik',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Switch(
                    activeColor: Color(0xFF1F1F1F),
                    value: switchTop5,
                    onChanged: (value) {
                      setState(() {
                        switchTop5 = value;
                        limit = value ? 5 : null;
                      });
                    },
                  )
                ],
              ),
            ),
            Flexible(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.72),
                itemCount: limit != null
                    ? waspasResult.length < limit!
                        ? waspasResult.length
                        : limit!
                    : waspasResult.length,
                itemBuilder: (context, index) {
                  final QueryDocumentSnapshot<Map<String, dynamic>>
                      documentSnapshot = waspasResult[index][2][0];
                  // print(documentSnapshot.data());
                  return CameraItem(
                    documentSnapshot: documentSnapshot,
                    q: waspasResult[index][1],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: selectedIndex == 0 ? Colors.white : Colors.white,
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
          child: SvgPicture.asset(
            "assets/icons/tombup.svg",
          ),
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeIndex: selectedIndex,
        backgroundColor: Colors.white,
        activeColor: Colors.grey,
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

          switch (selectedIndex) {
            case 0:
              Navigator.pushReplacementNamed(context, HomePage.routeName);
              break;
            case 1:
              Navigator.pushReplacementNamed(context, CatalogPage.routeName);
              break;
            case 2:
              Navigator.pushReplacementNamed(context, AboutPage.routeName);
              break;
            case 3:
              Navigator.pushReplacementNamed(context, AdminPage.routeName);
              break;
          }
        },
      ),
    );
  }
}
