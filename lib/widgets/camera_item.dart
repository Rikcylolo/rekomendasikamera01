import 'package:camera_market_app/pages/detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CameraItem extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot;
  final double? q;
  final Function()? onTap;

  const CameraItem({
    Key? key,
    required this.documentSnapshot,
    this.q,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap ??
          () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailPage(documentSnapshot: documentSnapshot),
                ),
              ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 30, 8, 0),
        margin: const EdgeInsets.fromLTRB(6, 0, 6, 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/images/background_image.png",
                fit: BoxFit.fill,
                width: 130,
                height: 125,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 110,
                    height: 110,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Image.network(
                      documentSnapshot['gambar'],
                      width: size.width * 0.24,
                      loadingBuilder: (context, child, event) => event == null
                          ? child
                          : Center(
                              child: CircularProgressIndicator(
                                value: event.cumulativeBytesLoaded /
                                    (event.expectedTotalBytes ?? 1),
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                      errorBuilder: (context, url, error) => Icon(
                        Icons.broken_image_outlined,
                        color: Colors.grey,
                        size: size.width * 0.24,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  documentSnapshot['namaProduk'],
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 10,
                        color: Color(0xFF262626),
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SizedBox(height: 4.0),
                if (q != null)
                  Text(
                    "Nilai: ${q!.toStringAsFixed(3)}",
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 10,
                          color: Color(0xFF262626),
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                SizedBox(height: 4.0),
                Text(
                  "Rp. ${documentSnapshot['harga']}",
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 10,
                        color: Color(0xFF262626),
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
