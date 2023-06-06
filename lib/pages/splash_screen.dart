import 'package:camera_market_app/pages/home_page.dart';
import 'package:camera_market_app/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1F1F),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/Fotografi_splash.png',
                    width: 370,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 130.0,
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/icons/logo.svg',
                  color: Colors.white,
                  width: 167.72,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Temukan Kamera\nterbaik kamu',
                  style: TextStyle(
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFBCBCBC),
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
