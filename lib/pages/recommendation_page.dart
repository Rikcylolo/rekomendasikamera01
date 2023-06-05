import 'dart:math';

import 'package:camera_market_app/pages/result_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({Key? key}) : super(key: key);
  static const routeName = '/recommendationPageRoute';

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  String _selectedValue = 'ALL';
  int _resolusiFotoValue = 1;
  int _resolusiVideoValue = 1;
  int _isoValue = 1;
  int _bateraiValue = 1;
  int _beratValue = 1;
  int _hargaValue = 1;

  late Stream<QuerySnapshot<Map<String, dynamic>>> camera;

  void _onSelectFilterCamera() {
    if (_selectedValue == 'ALL') {
      camera = FirebaseFirestore.instance.collection('camera').snapshots();
    } else {
      camera = FirebaseFirestore.instance
          .collection('camera')
          .where("merek", isEqualTo: _selectedValue)
          .snapshots();
    }
  }

  @override
  void initState() {
    _onSelectFilterCamera();

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
        body: Column(
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
                  child: Container(
                    margin: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Rekomemdasi Kamera',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                            'Kamera direkomendasikan berdasarkan kebutuhan terhadap spesifikasi kamera yang kamu butuhkan.'),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  top: 90.0,
                  bottom: 0.0,
                  child: Container(
                    padding: const EdgeInsets.all(18.0),
                    width: double.infinity,
                    // mengisi seluruh lebar layar
                    height: 200.0,
                    // tinggi container kedua
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    // warna putih
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IntrinsicHeight(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ), //
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Filter berdasarkan merek',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: DropdownButton<String>(
                                      value: _selectedValue,
                                      alignment: AlignmentDirectional.center,
                                      underline: const Center(),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      hint: const Text(
                                        "Merek Kamera",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      items: const [
                                        DropdownMenuItem(
                                          value: "ALL",
                                          child: Text("SEMUA MEREK"),
                                        ),
                                        DropdownMenuItem(
                                          value: "SONY",
                                          child: Text("SONY"),
                                        ),
                                        DropdownMenuItem(
                                          value: "CANON",
                                          child: Text("CANON"),
                                        ),
                                        DropdownMenuItem(
                                          value: "NIKON",
                                          child: Text("NIKON"),
                                        ),
                                      ],
                                      onChanged: (String? value) {
                                        // kode yang akan dipanggil setiap kali pilihan diubah
                                        setState(() {
                                          _selectedValue =
                                              value!; // menyimpan nilai pilihan yang dipilih
                                          _onSelectFilterCamera();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          // Resolusi Foto
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Resolusi Foto',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const Text(
                                            'Resolusi gambar yang semakin besar memungkinkan kemampuan kamera dalam menangkap gambar yang lebih baik.'),
                                        Row(
                                          // crossAxisAlignment: WrapCrossAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Tidak\nPenting',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    activeColor: Colors.black,
                                                    value: 1,
                                                    groupValue:
                                                        _resolusiFotoValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _resolusiFotoValue =
                                                            value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('1'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    activeColor: Colors.black,
                                                    value: 2,
                                                    groupValue:
                                                        _resolusiFotoValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _resolusiFotoValue =
                                                            value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('2'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    activeColor: Colors.black,
                                                    value: 3,
                                                    groupValue:
                                                        _resolusiFotoValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _resolusiFotoValue =
                                                            value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('3'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    activeColor: Colors.black,
                                                    value: 4,
                                                    groupValue:
                                                        _resolusiFotoValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _resolusiFotoValue =
                                                            value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('4'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    activeColor: Colors.black,
                                                    value: 5,
                                                    groupValue:
                                                        _resolusiFotoValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _resolusiFotoValue =
                                                            value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('5'),
                                                ],
                                              ),
                                            ),
                                            const Expanded(
                                              child: Text(
                                                'Sangat\nPenting',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          // Resolusi Video
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Resolusi Video',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const Text(
                                            'Resolusi video yang semakin besar memungkinkan kemampuan kamera dalam menangkap video yang lebih baik.'),
                                        Row(
                                          // crossAxisAlignment: WrapCrossAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Tidak\nPenting',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    activeColor: Colors.black,
                                                    value: 1,
                                                    groupValue:
                                                        _resolusiVideoValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _resolusiVideoValue =
                                                            value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('1'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    activeColor: Colors.black,
                                                    value: 2,
                                                    groupValue:
                                                        _resolusiVideoValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _resolusiVideoValue =
                                                            value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('2'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    activeColor: Colors.black,
                                                    value: 3,
                                                    groupValue:
                                                        _resolusiVideoValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _resolusiVideoValue =
                                                            value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('3'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    activeColor: Colors.black,
                                                    value: 4,
                                                    groupValue:
                                                        _resolusiVideoValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _resolusiVideoValue =
                                                            value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('4'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    activeColor: Colors.black,
                                                    value: 5,
                                                    groupValue:
                                                        _resolusiVideoValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _resolusiVideoValue =
                                                            value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('5'),
                                                ],
                                              ),
                                            ),
                                            const Expanded(
                                              child: Text(
                                                'Sangat\nPenting',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'ISO',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const Text(
                                            'Semakin tinggi ISO, maka semakin terang kualitas gambar yang didapatkan di dalam kondisi yang gelap. ISO yang tinggi biasanya sering digunakan ketika ingin menangkap gambar dalam kondisi yang cukup gelap.'),
                                        Row(
                                          // crossAxisAlignment: WrapCrossAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Tidak\nPenting',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 1,
                                                    activeColor: Colors.black,
                                                    groupValue: _isoValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _isoValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('1'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 2,
                                                    activeColor: Colors.black,
                                                    groupValue: _isoValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _isoValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('2'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 3,
                                                    activeColor: Colors.black,
                                                    groupValue: _isoValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _isoValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('3'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 4,
                                                    activeColor: Colors.black,
                                                    groupValue: _isoValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _isoValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('4'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 5,
                                                    activeColor: Colors.black,
                                                    groupValue: _isoValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _isoValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('5'),
                                                ],
                                              ),
                                            ),
                                            const Expanded(
                                              child: Text(
                                                'Sangat\nPenting',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Baterai',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const Text(
                                            'Semakin besar kapasitas baterai, maka semakin lama pula daya tahan kamera saat digunakan.'),
                                        Row(
                                          // crossAxisAlignment: WrapCrossAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Tidak\nPenting',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 1,
                                                    activeColor: Colors.black,
                                                    groupValue: _bateraiValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _bateraiValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('1'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 2,
                                                    activeColor: Colors.black,
                                                    groupValue: _bateraiValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _bateraiValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('2'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 3,
                                                    activeColor: Colors.black,
                                                    groupValue: _bateraiValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _bateraiValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('3'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 4,
                                                    activeColor: Colors.black,
                                                    groupValue: _bateraiValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _bateraiValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('4'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 5,
                                                    activeColor: Colors.black,
                                                    groupValue: _bateraiValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _bateraiValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('5'),
                                                ],
                                              ),
                                            ),
                                            const Expanded(
                                              child: Text(
                                                'Sangat\nPenting',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Berat',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const Text(
                                            'Spesifikasi kamera berpengaruh terhadap berat kamera. Semakin besar spesifikasi kamera, maka semakin berat pula bobot kamera.'),
                                        Row(
                                          // crossAxisAlignment: WrapCrossAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Tidak\nPenting',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 1,
                                                    activeColor: Colors.black,
                                                    groupValue: _beratValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _beratValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('1'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 2,
                                                    activeColor: Colors.black,
                                                    groupValue: _beratValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _beratValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('2'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 3,
                                                    activeColor: Colors.black,
                                                    groupValue: _beratValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _beratValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('3'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 4,
                                                    activeColor: Colors.black,
                                                    groupValue: _beratValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _beratValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('4'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 5,
                                                    activeColor: Colors.black,
                                                    groupValue: _beratValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _beratValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('5'),
                                                ],
                                              ),
                                            ),
                                            const Expanded(
                                              child: Text(
                                                'Sangat\nPenting',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Harga',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const Text(
                                            'Pada umumnya, harga kamera berkisar antara Rp2jt hingga Rp20jt. Semakin besar harga kamera, potensi kamera juga semakin besar.'),
                                        Row(
                                          // crossAxisAlignment: WrapCrossAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Paling\nMurah',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'FontPoppins',
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 1,
                                                    activeColor: Colors.black,
                                                    groupValue: _hargaValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _hargaValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('1'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 2,
                                                    activeColor: Colors.black,
                                                    groupValue: _hargaValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _hargaValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('2'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 3,
                                                    activeColor: Colors.black,
                                                    groupValue: _hargaValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _hargaValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('3'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 4,
                                                    activeColor: Colors.black,
                                                    groupValue: _hargaValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _hargaValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('4'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Radio(
                                                    value: 5,
                                                    activeColor: Colors.black,
                                                    groupValue: _hargaValue,
                                                    onChanged: (int? value) {
                                                      setState(() {
                                                        _hargaValue = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('5'),
                                                ],
                                              ),
                                            ),
                                            const Expanded(
                                              child: Text(
                                                'Paling\nMahal',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'FontPoppins',
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: camera,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final List<
                                        QueryDocumentSnapshot<
                                            Map<String, dynamic>>>
                                    documentSnapshot = snapshot.data!.docs;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Container(
                                        width: 200,
                                        height: 45,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: const Text(
                                          'Submit',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ResultPage(
                                            waspasTempResult: rekomendasi(
                                              documentSnapshot,
                                              _resolusiFotoValue,
                                              _resolusiVideoValue,
                                              _isoValue,
                                              _beratValue,
                                              _beratValue,
                                              _hargaValue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  // Future<void> getDataFromFirebase() async {
  //   final DataSnapshot snapshot = (await _database.reference().child("camera_id").once()) as DataSnapshot;
  //   final Object? data = snapshot.value;
  //   print(data);
  // }

  // void rekomendasiWaspas(
  //     List<double> c1, // Resolusi Gambar Maksimal
  //     List<double> c2, // Resoulusi Video Maksimal
  //     List<double> c3, // ISO Maksimal
  //     List<double> c4, // Baterai
  //     List<double> c5, // Harga
  //     List<double> c6, // Berat
  //     )
  // {
  //   double maxC(List<double> c) {
  //     final CollectionReference camera = FirebaseFirestore.instance.collection('camera');
  //
  //     double maxNumber = c[0];
  //     for(int i = 1; i < c.length; i++) {
  //       maxNumber = max(maxNumber, c[i]);
  //     }
  //     return maxNumber;
  //   }
  //
  //   double minC(List<double> c) {
  //     double minNumber = c[0];
  //     for(int i = 1; i < c.length; i++) {
  //       minNumber = min(minNumber, c[i]);
  //     }
  //     return minNumber;
  //   }
  //
  //   List<List<double>> dataFromDatabase = []; // connect to Firebase Database
  //   // List<List<double>> dataFromDatabase = [
  //   //   [6000, 1920, 25600, 1020, 15900000, 556],
  //   //   [6720, 3840, 102400, 1865, 28999000, 395],
  //   //   [6016, 1920, 51200, 1900, 30999000, 670],
  //   //   [6000, 3480, 102400, 1080, 13699000, 403]
  //   // ];
  //
  //   List<double> sonyA7 = [
  //     dataFromDatabase[0][0],
  //     dataFromDatabase[1][0],
  //     dataFromDatabase[2][0],
  //     dataFromDatabase[3][0],
  //   ];
  //
  //   double maxC1 = maxC(sonyA7);
  //
  //   // double macC1 = maxC(c1);
  //   double maxC2 = maxC(c2);
  //   double maxC3 = maxC(c3);
  //   double maxC4 = maxC(c4);
  //   double minC5 = minC(c5);
  //   double minC6 = minC(c6);
  //
  //
  //
  //   List<List<double>> dataFromParameter = [c1, c2, c3, c4, c5, c6,];
  //
  //   dataFromParameter[1][1];
  //
  //   List<List<double>> camera = []; // result
  //
  //   // for(int i = 1; i <= c1.length; i ++) {
  //   //
  //   //   if (i == 1) {
  //   //     for(int j = 1; j <= 6; j ++) {
  //   //       if(j <= 4) {
  //   //         dataFromDatabase[i][j] /= maxC1;
  //   //       }
  //   //     }
  //   //   }
  //   //   if (i == 2) {
  //   //     for(int j = 1; j <= 6; j ++) {
  //   //       if(j <= 4) {
  //   //         dataFromDatabase[i][j] /= maxC2;
  //   //       }
  //   //     }
  //   //   }
  //   // }
  //
  //   // maxC1
  //
  //   for(int i = 1; i <= 6; i ++) {
  //     // C1
  //     if (i == 1) {
  //       for(int j = 1; j <= c1.length; j ++) {
  //         dataFromDatabase[i][j] /= maxC1;
  //       }
  //     }
  //     // C2
  //     if (i == 2) {
  //       for(int j = 1; j <= c2.length; j ++) {
  //         dataFromDatabase[i][j] /= maxC2;
  //       }
  //     }
  //     // C3
  //     if (i == 3) {
  //       for(int j = 1; j <= c3.length; j ++) {
  //         dataFromDatabase[i][j] /= maxC3;
  //       }
  //     }
  //     // C4
  //     if (i == 4) {
  //       for(int j = 1; j <= c4.length; j ++) {
  //         dataFromDatabase[i][j] /= maxC4;
  //       }
  //     }
  //     // C5
  //     if (i == 5) {
  //       for(int j = 1; j <= c5.length; j ++) {
  //         dataFromDatabase[i][j] = minC5 / dataFromDatabase[i][j];
  //       }
  //     }
  //     // C6
  //     if (i == 6) {
  //       for(int j = 1; j <= c6.length; j ++) {
  //         dataFromDatabase[i][j] = minC6 / dataFromDatabase[i][j];
  //       }
  //     }
  //   }
  // }

  List<List> rekomendasi(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documentSnapshot,
    int resolusiFoto,
    int resolusiVideo,
    int iso,
    int baterai,
    int berat,
    int harga,
  ) {
    List<DocumentSnapshot<Object?>> dataFromDatabase =
        []; // connect to Firebase Database
    List<List<double>> normalization = []; // normalisasi
    List<String> productName = [];
    List<QueryDocumentSnapshot<Map<String, dynamic>>> camera = [];
    List<List<dynamic>> hasilWaspas = [];

    double maxC(List<double> c) {
      double maxNumber = c[0];
      for (int i = 1; i < c.length; i++) {
        maxNumber = max(maxNumber, c[i]);
      }
      return maxNumber;
    }

    double minC(List<double> c) {
      double minNumber = c[0];
      for (int i = 1; i < c.length; i++) {
        minNumber = min(minNumber, c[i]);
      }
      return minNumber;
    }

    List<double> listC1 = []; // max_image_resolution
    List<double> listC2 = []; // max_video_resolution
    List<double> listC3 = []; // iso_max
    List<double> listC4 = []; // battery
    List<double> listC5 = []; // price
    List<double> listC6 = []; // weight

    for (int i = 0; i < documentSnapshot.length; i++) {
      dataFromDatabase.add(documentSnapshot[i]);
      camera.add(documentSnapshot[i]);
      productName.add(documentSnapshot[i]['namaProduk']);
      listC1.add(documentSnapshot[i]['resGbr'].toDouble());
      listC2.add(documentSnapshot[i]['resVid'].toDouble());
      listC3.add(documentSnapshot[i]['maxISO'].toDouble());
      listC4.add(documentSnapshot[i]['baterai'].toDouble());
      listC5.add(documentSnapshot[i]['harga'].toDouble());
      listC6.add(documentSnapshot[i]['berat'].toDouble());
    }

    double maxC1 = maxC(listC1);
    double maxC2 = maxC(listC2);
    double maxC3 = maxC(listC3);
    double maxC4 = maxC(listC4);
    double minC5 = minC(listC5);
    double minC6 = minC(listC6);

    for (int i = 0; i < 6; i++) {
      // C1
      if (i == 0) {
        for (int j = 0; j < listC1.length; j++) {
          listC1[j] = listC1[j] / maxC1;
        }
        normalization.add(listC1);
      }

      // C2
      if (i == 1) {
        for (int j = 0; j < listC2.length; j++) {
          listC2[j] /= maxC2;
        }
        normalization.add(listC2);
      }

      // C3
      if (i == 2) {
        for (int j = 0; j < listC3.length; j++) {
          listC3[j] /= maxC3;
        }
        normalization.add(listC3);
      }

      // C4
      if (i == 3) {
        for (int j = 0; j < listC4.length; j++) {
          listC4[j] /= maxC4;
        }
        normalization.add(listC4);
      }

      // C5
      if (i == 4) {
        for (int j = 0; j < listC5.length; j++) {
          listC5[j] = minC5 / listC5[j];
        }
        normalization.add(listC5);
      }

      // C6
      if (i == 5) {
        for (int j = 0; j < listC6.length; j++) {
          listC6[j] = minC6 / listC6[j];
        }
        normalization.add(listC6);
      }
    }

    for (int i = 0; i < productName.length; i++) {
      //    int resolusiFoto,
      //       int resolusiVideo,
      //       int iso,
      //       int baterai,
      //       int berat,
      //       int harga,

      final q = 0.5 *
              ((normalization[0][i] * resolusiFoto.toDouble()) +
                  (normalization[1][i] * resolusiVideo.toDouble()) +
                  (normalization[2][i] * iso.toDouble()) +
                  (normalization[3][i] * baterai.toDouble()) +
                  (normalization[4][i] * berat.toDouble()) +
                  (normalization[5][i] * harga.toDouble())) +
          0.5 *
              (pow(normalization[0][i], resolusiFoto.toDouble()) +
                  pow(normalization[1][i], resolusiVideo.toDouble()) +
                  pow(normalization[2][i], iso.toDouble()) +
                  pow(normalization[3][i], baterai.toDouble()) +
                  pow(normalization[4][i], berat.toDouble()) +
                  pow(normalization[5][i], harga.toDouble()));

      hasilWaspas.add(
        [
          productName[i],
          q,
          [camera[i]],
        ],
      );
    }

    hasilWaspas.sort((a, b) {
      return (b[1] as double).compareTo(a[1] as double);
    });

    return hasilWaspas;
  }
}
