import 'package:camera_market_app/pages/about_page.dart';
import 'package:camera_market_app/pages/admin_page/admin_page.dart';
import 'package:camera_market_app/pages/admin_page/delete_page.dart';
import 'package:camera_market_app/pages/admin_page/edit_data_page.dart';
import 'package:camera_market_app/pages/admin_page/insert_page.dart';
import 'package:camera_market_app/pages/admin_page/list_page.dart';
import 'package:camera_market_app/pages/catalog_page.dart';
import 'package:camera_market_app/pages/home_page.dart';
import 'package:camera_market_app/pages/recommendation_page.dart';
import 'package:camera_market_app/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      // home: const HomePage(),
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        AdminPage.routeName: (context) => const AdminPage(),
        RecommendationPage.routeName: (context) => const RecommendationPage(),
        // ResultPage.routeName: (context) => const ResultPage(),
        AboutPage.routeName: (context) => const AboutPage(),
        CatalogPage.routeName: (context) => const CatalogPage(),
        EditDataPage.routeName: (context) => const EditDataPage(),
        InsertPage.routeName: (context) => const InsertPage(),
        DeletePage.routeName: (context) => const DeletePage(),
        DataListPage.routeName: (context) => const DataListPage(),
      },
    );
  }
}
