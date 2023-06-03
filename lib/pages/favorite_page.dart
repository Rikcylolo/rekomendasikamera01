import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/camera_item.dart';
import 'detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final cameraCollection = FirebaseFirestore.instance.collection('camera');

  List<QueryDocumentSnapshot<Map<String, dynamic>>> cameraList = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> cameraTempList = [];
  bool isLoading = true;

  Future<void> getCamera() async {
    isLoading = true;
    final result = await cameraCollection.get();

    setState(() {
      cameraTempList = result.docs;
      cameraTempList.sort((a, b) => (a.data()['namaProduk'] as String)
          .compareTo((b.data()['namaProduk'] as String)));
      isLoading = false;
    });
  }

  Future<void> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getStringList("favorites");
    if (result == null) {
      return;
    }
    setState(() {
      cameraList =
          cameraTempList.where((item) => result.contains(item.id)).toList();
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getCamera();
      await getFavorites();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: SizedBox(
          height: 50,
          width: 90,
          child: Image.asset(
            'assets/icons/Logo.png',
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(18.0),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : cameraList.isEmpty
                ? const Center(
                    child: Text("Favorite is empty"),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: cameraList.length,
                    itemBuilder: (context, index) {
                      final QueryDocumentSnapshot<Map<String, dynamic>>
                          documentSnapshot = cameraList[index];

                      return CameraItem(
                        documentSnapshot: documentSnapshot,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                  documentSnapshot: documentSnapshot),
                            ),
                          );
                          getFavorites();
                        },
                      );
                    },
                  ),
      ),
    );
  }
}
