import 'package:camera_market_app/widgets/camera_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:camera_market_app/pages/home_page.dart';
import 'package:camera_market_app/pages/about_page.dart';
import 'package:camera_market_app/pages/admin_page/admin_page.dart';
import 'package:camera_market_app/pages/recommendation_page.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);
  static const routeName = '/catalogPageRoute';

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final cameraCollection = FirebaseFirestore.instance.collection('camera');
  final TextEditingController searchInputController = TextEditingController();

  int selectedIndex = 1;

  final List<IconData> icons = [
    Icons.home,
    Icons.list_alt,
    Icons.info,
    Icons.person,
  ];

  List<QueryDocumentSnapshot<Map<String, dynamic>>> cameraList = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> cameraTempList = [];
  bool isLoading = true;
  String selectedBrand = '';

  Future<void> getCamera() async {
    isLoading = true;
    final result = await cameraCollection.get();

    setState(() {
      cameraList = result.docs;
      cameraList.sort((a, b) => (a.data()['namaProduk'] as String)
          .compareTo((b.data()['namaProduk'] as String)));
      cameraTempList = result.docs;
      cameraTempList.sort((a, b) => (a.data()['namaProduk'] as String)
          .compareTo((b.data()['namaProduk'] as String)));
      isLoading = false;
    });
  }

  void _onTapFilterCamera(String merek) {
    setState(() {
      if (searchInputController.text.isNotEmpty) {
        cameraList = cameraTempList
            .where((item) =>
                item.data()['merek'] == merek &&
                (item.data()['namaProduk'] as String)
                    .contains(searchInputController.text))
            .toList();
      } else {
        cameraList = cameraTempList
            .where((item) => item.data()['merek'] == merek)
            .toList();
      }

      cameraTempList.sort((a, b) => (a.data()['namaProduk'] as String)
          .compareTo((b.data()['namaProduk'] as String)));

      selectedBrand = merek;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCamera();
    });

    super.initState();
  }

  @override
  void dispose() {
    searchInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0.0,
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
        height: size.height,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
          color: Color(0xFFEAEAEA),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            TextFormField(
              controller: searchInputController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Cari kamera",
                hintStyle: TextStyle(
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xFFA8A8A8)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      searchInputController.clear();
                      cameraList = cameraTempList;
                    });
                  },
                  child: Icon(
                    Icons.close,
                    color: Color.fromARGB(208, 38, 38, 38),
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 20),
              ),
              onChanged: (value) {
                setState(() {
                  cameraList = cameraTempList
                      .where((item) => (item.data()['namaProduk'] as String)
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Pilih Merek',
                style: TextStyle(
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              width: size.width,
              height: 64,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 104,
                    height: 64,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: selectedBrand == 'SONY' ? 4 : 0,
                      child: InkWell(
                        onTap: () {
                          _onTapFilterCamera("SONY");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/sony.svg',
                              color: selectedBrand == 'SONY'
                                  ? Color(0xFF262626)
                                  : Color(0xFFA8A8A8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 104,
                    height: 64,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: selectedBrand == 'CANON' ? 4 : 0,
                      child: InkWell(
                        onTap: () {
                          _onTapFilterCamera("CANON");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/canon.svg',
                              color: selectedBrand == 'CANON'
                                  ? Color(0xFF262626)
                                  : Color(0xFFA8A8A8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 104,
                    height: 64,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: selectedBrand == 'NIKON' ? 4 : 0,
                      child: InkWell(
                        onTap: () {
                          _onTapFilterCamera("NIKON");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/nikon.svg',
                              color: selectedBrand == 'NIKON'
                                  ? Color(0xFF262626)
                                  : Color(0xFFA8A8A8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Produk Kamera',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'FontPoppins',
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (!isLoading)
              Flexible(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.72),
                  itemCount: cameraList.length,
                  itemBuilder: (context, index) {
                    final QueryDocumentSnapshot<Map<String, dynamic>>
                        documentSnapshot = cameraList[index];

                    return CameraItem(documentSnapshot: documentSnapshot);
                  },
                ),
              ),
          ],
        ),
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
            width: 25,
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
            // case 1:
            //   Navigator.pushReplacementNamed(context, CatalogPage.routeName);
            //   break;
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
