import 'dart:ffi';

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
                  color: Color(0xFFEAEAEA),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.all(20.0),
                  child: const Text(
                    'Tentang Aplikasi',
                    style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
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
                  padding: const EdgeInsets.all(20.0),
                  width: double.infinity,
                  height: 200.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              alignment: Alignment.topLeft,
                              child: const Text(
                                'Pengembang Aplikasi',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 104,
                                height: 143,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.3), // Warna bayangan
                                      blurRadius: 5, // Ukuran blur bayangan
                                      offset: Offset(
                                          0, 0), // Posisi bayangan (x, y)
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: FractionallySizedBox(
                                    widthFactor:
                                        1.5, // Faktor skala berdasarkan lebar kontainer
                                    child: Transform.scale(
                                      scale:
                                          1.0, // Faktor skala untuk perbesaran tambahan (opsional)
                                      child: Image.asset(
                                        'assets/images/lamser.jpg',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 104,
                                height: 143,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.3), // Warna bayangan
                                      blurRadius: 5, // Ukuran blur bayangan
                                      offset: Offset(
                                          0, 0), // Posisi bayangan (x, y)
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: FractionallySizedBox(
                                    widthFactor:
                                        1.5, // Faktor skala berdasarkan lebar kontainer
                                    child: Transform.scale(
                                      scale:
                                          1.0, // Faktor skala untuk perbesaran tambahan (opsional)
                                      child: Image.asset(
                                        'assets/images/rikcy.jpg',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 104,
                                height: 143,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.3), // Warna bayangan
                                      blurRadius: 5, // Ukuran blur bayangan
                                      offset: Offset(
                                          0, 0), // Posisi bayangan (x, y)
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: FractionallySizedBox(
                                    widthFactor:
                                        1.5, // Faktor skala berdasarkan lebar kontainer
                                    child: Transform.scale(
                                      scale:
                                          1.0, // Faktor skala untuk perbesaran tambahan (opsional)
                                      child: Image.asset(
                                        'assets/images/rido.jpg',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: 6), // Spacer antara kontainer dan teks
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 104,
                                child: const Text(
                                  "Lamser",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: const Text(
                                  "Rikcy",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Container(
                                width: 100,
                                child: const Text(
                                  "Rido",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 300,
                bottom: 0.0,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  width: double.infinity,
                  height: 100.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEAEAEA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Informasi',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                          height:
                              7), // Spacer untuk memberikan jarak antara teks pertama dan kedua
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            height: 1.35,
                            fontFamily: 'FontPoppins',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  'Aplikasi Sistem Rekomendasi Kamera ini dibuat menggunakan metode ',
                            ),
                            TextSpan(
                              text:
                                  'Weighted Aggregated Sum Product Assessment ',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: '(WASPAS) ',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text:
                                  'untuk mendapatkan rekomendasi kamera terbaik sesuai dengan kebutuhan pengguna. \n\nDengan memasukkan bobot terhadap spesifikasi kamera yang dibutuhkan, sistem dapat merekomendasikan kamera yang paling sesuai dengan kebutuhan pengguna. \n\nPengguna memasukkan data kebutuhan pada diagram likert yang memiliki nilai antara satu (1) sampai lima (5).',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
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
          backgroundColor: Color(0xFF404040),
          radius: 24,
          child: SvgPicture.asset(
            "assets/icons/tombup.svg",
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
