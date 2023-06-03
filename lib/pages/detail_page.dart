import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> documentSnapshot;

  const DetailPage({super.key, required this.documentSnapshot});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final CollectionReference camera =
      FirebaseFirestore.instance.collection('camera');

  bool isFavorite = false;

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getFavorite();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
          actions: [
            IconButton(
              onPressed: () => addRemoveFavorite(),
              icon: isFavorite
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    )
                  : const Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                    ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: StreamBuilder(
            stream: camera.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 660,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0,
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
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Image.network(
                                        widget.documentSnapshot['gambar'],
                                        loadingBuilder: (context, child,
                                                event) =>
                                            event == null
                                                ? child
                                                : SizedBox(
                                                    width: size.width * 0.24,
                                                    height: size.width * 0.24,
                                                    child: Center(
                                                      child: SizedBox(
                                                        width:
                                                            size.width * 0.24,
                                                        height:
                                                            size.width * 0.24,
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: event
                                                                  .cumulativeBytesLoaded /
                                                              (event.expectedTotalBytes ??
                                                                  1),
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                        errorBuilder: (context, url, error) =>
                                            Icon(
                                          Icons.broken_image_outlined,
                                          color: Colors.grey,
                                          size: size.width * 0.24,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      widget.documentSnapshot['namaProduk'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Rp. ${widget.documentSnapshot['harga']}',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(18.0),
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
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
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                        'Resolusi foto maksimal : ${widget.documentSnapshot['resGbr']} p \n'
                                        'Resolusi video maksimal : ${widget.documentSnapshot['resVid']} p \n'
                                        'ISO maksimal : ${widget.documentSnapshot['maxISO']} \n'
                                        'Baterai : ${widget.documentSnapshot['baterai']} mAh \n'
                                        'Berat : ${widget.documentSnapshot['berat']} g \n'
                                        // 'Sensor CMOS APS-C 24,1 megapiksel & DIGIC 4+ AF 9 titik dengan 1 titik AF tipe silang tengah \n'
                                        // 'Mendukung Wi-Fi dan NFC',
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
              );
            },
          ),
        ));
  }
}
