import 'package:camera_market_app/widgets/camera_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
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
    );
  }
}
