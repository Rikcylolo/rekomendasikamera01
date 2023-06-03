import 'package:camera_market_app/pages/admin_page/update_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataListPage extends StatelessWidget {
  const DataListPage({Key? key}) : super(key: key);
  static const routeName = '/dataListPageRoute';

  @override
  Widget build(BuildContext context) {
    final CollectionReference camera =
        FirebaseFirestore.instance.collection('camera');
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
            icon: Image.asset(
              'assets/icons/backarrow.png',
              color: Color(0xFF262626),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 0),
          child: SizedBox(
            height: 30,
            width: 124.09,
            child: Image.asset(
              'assets/icons/Logo.png',
            ),
          ),
        ),
      ),
      body: Container(
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
                      'Selamat datang, Admin <adminID>',
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
            const SizedBox(
              height: 18,
            ),
            SizedBox(
              width: double.infinity,
              height: size.height * .7,
              child: StreamBuilder(
                stream: camera.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                      itemCount: streamSnapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        final documentSnapshot =
                            streamSnapshot.data?.docs[index];
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
                                    color: Colors.black,
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
                                          camera
                                              .doc(documentSnapshot.id)
                                              .delete();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Anda telah berhasil menghapus buku.'),
                                              duration:
                                                  Duration(milliseconds: 500),
                                            ),
                                          );
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
                    );
                  } else {
                    return const Center();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
