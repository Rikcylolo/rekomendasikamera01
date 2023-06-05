import 'package:flutter/material.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:camera_market_app/pages/home_page.dart';
import 'package:camera_market_app/pages/admin_page/admin_page.dart';
import 'package:camera_market_app/pages/recommendation_page.dart';
import 'package:camera_market_app/pages/catalog_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  static const routeName = '/aboutPageRoute';

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int selectedIndex = 2;

  final List<IconData> icons = const [
    Icons.home,
    Icons.list_alt,
    Icons.info,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              Container(
                height: 659 - 16,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.all(18.0),
                  child: const Text(
                    'Tentang Aplikasi',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 60.0,
                bottom: 0.0,
                child: Container(
                  padding: const EdgeInsets.all(18.0),
                  width: double.infinity, // mengisi seluruh lebar layar
                  height: 200.0, // tinggi container kedua
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 100,
                            height: 130,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Container(
                            width: 100,
                            height: 130,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Container(
                            width: 100,
                            height: 130,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Informasi",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                          "Aplikasi Sistem Rekomendasi Kamera ini dibuat menggunakan metode Weighted Aggregated Sum Product Assessment (WASPAS) untuk mendapatkan rekomendasi kamera terbaik sesuai dengan kebutuhan pengguna. Dengan memasukkan bobot terhadap spesifikasi kamera yang dibutuhkan, sistem dapat merekomendasikan kamera yang paling sesuai dengan kebutuhan pengguna. Pengguna memasukkan data kebutuhan pada diagram likert yang memiliki nilai antara satu (1) sampai lima (5)."),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      backgroundColor: selectedIndex == 0 ? Colors.grey[200] : Colors.grey[200],
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

          switch (selectedIndex) {
            case 0:
              Navigator.pushReplacementNamed(context, HomePage.routeName);
              break;
            case 1:
              Navigator.pushReplacementNamed(context, CatalogPage.routeName);
              break;
            // case 2:
            //   Navigator.pushReplacementNamed(context, AboutPage.routeName);
            //   break;
            case 3:
              Navigator.pushReplacementNamed(context, AdminPage.routeName);
              break;
          }
        },
      ),
    );
  }
}
