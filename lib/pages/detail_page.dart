import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:camera_market_app/pages/home_page.dart';
import 'package:camera_market_app/pages/about_page.dart';
import 'package:camera_market_app/pages/admin_page/admin_page.dart';
import 'package:camera_market_app/pages/recommendation_page.dart';
import 'package:camera_market_app/pages/catalog_page.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> documentSnapshot;

  const DetailPage({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final CollectionReference camera =
      FirebaseFirestore.instance.collection('camera');

  bool isFavorite = false;
  int selectedIndex = 1;

  final List<IconData> icons = [
    Icons.home,
    Icons.list_alt,
    Icons.info,
    Icons.person,
  ];

  Future<void> getFavorite() async {
    final prefs = await SharedPreferences.getInstance();

    final getFavorites = prefs.getStringList("favorites");
    if (getFavorites == null) {
      return;
    }

    setState(() {
      isFavorite = getFavorites
          .where((item) => item == widget.documentSnapshot.id)
          .isNotEmpty;
    });
  }

  Future<void> addRemoveFavorite() async {
    final prefs = await SharedPreferences.getInstance();

    final getFavorites = prefs.getStringList("favorites");
    if (getFavorites == null) {
      final List<String> result = [];
      result.add(widget.documentSnapshot.id);
      prefs.setStringList("favorites", result);
      setState(() {
        isFavorite = true;
      });
      return;
    }

    final List<String> result = getFavorites;
    if (isFavorite) {
      result.removeWhere((item) => item == widget.documentSnapshot.id);
      prefs.setStringList("favorites", result);
      setState(() {
        isFavorite = false;
      });
    } else {
      result.add(widget.documentSnapshot.id);
      prefs.setStringList("favorites", result);
      setState(() {
        isFavorite = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      getFavorite();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.only(top: 0),
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/backarrow.svg',
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
        actions: [
          IconButton(
            onPressed: () => addRemoveFavorite(),
            icon: isFavorite
                ? const Icon(
                    Icons.favorite,
                    color: Colors.black,
                  )
                : const Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  height: 660,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFEAEAEA),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                ),
                Positioned(
                  top: 20.0,
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          height: 360,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEAEAEA),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: Image.network(
                                    widget.documentSnapshot['gambar'],
                                    loadingBuilder: (context, child, event) {
                                      if (event == null) {
                                        return child;
                                      } else {
                                        return SizedBox(
                                          width: size.width * 0.24,
                                          height: size.width * 0.24,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              value: event
                                                      .cumulativeBytesLoaded /
                                                  (event.expectedTotalBytes ??
                                                      1),
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    errorBuilder: (context, url, error) => Icon(
                                      Icons.broken_image_outlined,
                                      color: Colors.grey,
                                      size: size.width * 0.24,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                widget.documentSnapshot['namaProduk'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Rp",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF262626),
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: NumberFormat("#,##0", "en_US")
                                          .format(
                                              widget.documentSnapshot['harga'])
                                          .replaceAll(",", ".")
                                          .substring(
                                              0,
                                              NumberFormat("#,##0", "en_US")
                                                      .format(widget
                                                              .documentSnapshot[
                                                          'harga'])
                                                      .replaceAll(",", ".")
                                                      .length -
                                                  3),
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Color(0xFF262626),
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: NumberFormat("#,##0", "en_US")
                                          .format(
                                              widget.documentSnapshot['harga'])
                                          .replaceAll(",", ".")
                                          .substring(
                                              NumberFormat("#,##0", "en_US")
                                                      .format(widget
                                                              .documentSnapshot[
                                                          'harga'])
                                                      .replaceAll(",", ".")
                                                      .length -
                                                  3),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF262626),
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Spesifikasi',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'FontPoppins',
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Resolusi foto maksimal : ${widget.documentSnapshot['resGbr']} px \n'
                                'Resolusi video maksimal : ${widget.documentSnapshot['resVid']} p \n'
                                'ISO maksimal : ${widget.documentSnapshot['maxISO']} \n'
                                'Baterai : ${widget.documentSnapshot['baterai']} mAh \n'
                                'Berat : ${widget.documentSnapshot['berat']} g \n',
                                // 'Sensor CMOS APS-C 24,1 megapiksel & DIGIC 4+ AF 9 titik dengan 1 titik AF tipe silang tengah \n'
                                // 'Mendukung Wi-Fi dan NFC',
                                style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
