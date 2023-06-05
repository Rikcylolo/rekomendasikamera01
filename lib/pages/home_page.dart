import 'package:camera_market_app/pages/about_page.dart';
import 'package:camera_market_app/pages/admin_page/admin_page.dart';
import 'package:camera_market_app/pages/catalog_page.dart';
import 'package:camera_market_app/pages/favorite_page.dart';
import 'package:camera_market_app/pages/recommendation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/homePageRoute';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FavoritePage(),
                ),
              ),
              icon: const Icon(Icons.favorite),
            ),
          ),
          SizedBox(
            height: size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: SizedBox(
                    child: SvgPicture.asset(
                      'assets/icons/logo.svg',
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Temukan Kamera Terbaik Kamu",
                  style: TextStyle(
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    //letterSpacing: 0.7,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 63),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFFEAEAEA),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            height: size.height * .7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeContainer(
                      icon: Image.asset('assets/icons/tumbup.png'),
                      nama: 'Rekomendasi',
                      tujuan: () => Navigator.pushNamed(
                          context, RecommendationPage.routeName),
                    ),
                    HomeContainer(
                      icon: Image.asset('assets/icons/newspaper.png'),
                      nama: 'Katalog',
                      tujuan: () =>
                          Navigator.pushNamed(context, CatalogPage.routeName),
                    )
                  ],
                ),
                const SizedBox(height: 15 - 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeContainer(
                      icon: Image.asset('assets/icons/info.png'),
                      nama: 'Tentang',
                      tujuan: () =>
                          Navigator.pushNamed(context, AboutPage.routeName),
                    ),
                    HomeContainer(
                      icon: Image.asset('assets/icons/user.png'),
                      nama: 'Admin',
                      tujuan: () =>
                          Navigator.pushNamed(context, AdminPage.routeName),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContainer extends StatelessWidget {
  final Function tujuan;
  final Widget icon;
  final String nama;

  const HomeContainer({
    required this.nama,
    required this.icon,
    required this.tujuan,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => tujuan(),
      child: Container(
        margin: const EdgeInsets.all(15),
        height: 207,
        width: 151,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              height: 28,
            ),
            Text(
              nama,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'FontPoppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
