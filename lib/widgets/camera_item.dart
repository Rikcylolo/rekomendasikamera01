import 'package:camera_market_app/pages/detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
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
            if (q != null)
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Nilai: ${q!.toStringAsFixed(3)}   ",
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 10,
                        color: const Color(0xFF262626),
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/background_image.png",
                  fit: BoxFit.fill,
                  width: 115,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 0),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 12),
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
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      (documentSnapshot['namaProduk'].length <= 22)
                          ? documentSnapshot['namaProduk']
                          : documentSnapshot['namaProduk'].substring(0, 20),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 12,
                            color: const Color(0xFF262626),
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Rp",
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF262626),
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: NumberFormat("#,##0", "en_US")
                                .format(documentSnapshot['harga'])
                                .replaceAll(",", ".")
                                .substring(
                                    0,
                                    NumberFormat("#,##0", "en_US")
                                            .format(documentSnapshot['harga'])
                                            .replaceAll(",", ".")
                                            .length -
                                        3),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF262626),
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: NumberFormat("#,##0", "en_US")
                                .format(documentSnapshot['harga'])
                                .replaceAll(",", ".")
                                .substring(NumberFormat("#,##0", "en_US")
                                        .format(documentSnapshot['harga'])
                                        .replaceAll(",", ".")
                                        .length -
                                    3),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF262626),
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
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
