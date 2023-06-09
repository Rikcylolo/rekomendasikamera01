import 'package:camera_market_app/pages/admin_page/update_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DataListPage extends StatefulWidget {
  const DataListPage({Key? key}) : super(key: key);
  static const routeName = '/dataListPageRoute';

  @override
  State<DataListPage> createState() => _DataListPageState();
}

class _DataListPageState extends State<DataListPage> {
  final cameraCollection = FirebaseFirestore.instance.collection('camera');
  final TextEditingController searchInputController = TextEditingController();

  List<QueryDocumentSnapshot<Map<String, dynamic>>> cameraList = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> cameraTempList = [];
  bool isLoading = true;

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

  Future<void> deleteCamera(
      QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) async {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Hapus",
                style: TextStyle(
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Apakah anda yakin ingin menghapus kamera ${documentSnapshot!['namaProduk']}?",
                style: TextStyle(
                    fontFamily: 'FontPoppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1F1F1F),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        "Tidak",
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFEAEAEA),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        await cameraCollection
                            .doc(documentSnapshot.id)
                            .delete();
                        getCamera();
                        navigator.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Anda telah berhasil menghapus data.'),
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: const Text(
                        "Ya",
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            color: Color(0xFF1F1F1F),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
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
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xFFEAEAEA),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Selamat datang Admin',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'FontPoppins',
                          fontSize: 14,
                        ),
                      ),
                      // SizedBox(
                      //   height: 6.0,
                      // ),
                      Text(
                        'Camera List',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'FontPoppins',
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Banyak data : ${cameraList.length}",
                  style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cameraList.length,
                itemBuilder: (context, index) {
                  final documentSnapshot = cameraList[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Ink(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdatePage(
                                  documentSnapshot: documentSnapshot),
                            ),
                          );
                        },
                        child: ListTile(
                          title: DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF000000),
                            ),
                            child: Text(documentSnapshot!['namaProduk']),
                          ),
                          trailing: SizedBox(
                            width: size.width * 0.3,
                            child: Row(
                              children: [
                                Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    deleteCamera(documentSnapshot);
                                    searchInputController.clear();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
