import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key, required this.documentSnapshot});
  final DocumentSnapshot documentSnapshot;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final ImagePicker _imagePicker = ImagePicker();

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _maxImageResolutionController =
      TextEditingController();
  final TextEditingController _maxVideoResolutionController =
      TextEditingController();
  final TextEditingController _isoMaxController = TextEditingController();
  final TextEditingController _batteryController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String? _imageUrl;
  late String _selectedValue;
  XFile? _selectedImage;

  Future<void> _selectImage() async {
    final pick = await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = pick;
    });
  }

  @override
  void initState() {
    _idController.text = widget.documentSnapshot['cameraID'];
    _productNameController.text = widget.documentSnapshot['namaProduk'];
    _imageUrl = widget.documentSnapshot['gambar'];
    _maxImageResolutionController.text =
        widget.documentSnapshot['resGbr'].toString();
    _maxVideoResolutionController.text =
        widget.documentSnapshot['resVid'].toString();
    _isoMaxController.text = widget.documentSnapshot['maxISO'].toString();
    _batteryController.text = widget.documentSnapshot['baterai'].toString();
    _weightController.text = widget.documentSnapshot['berat'].toString();
    _priceController.text = widget.documentSnapshot['harga'].toString();
    _selectedValue = widget.documentSnapshot['merek'] ?? "SONY";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference camera =
        FirebaseFirestore.instance.collection('camera');

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
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      // SizedBox(
                      //   height: 6.0,
                      // ),
                      Text(
                        'Update Data',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            fontFamily: 'FontPoppins'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Center(
                child: Container(
                  width: 334,
                  height: 53,
                  decoration: BoxDecoration(
                    color: Color(0xFF404040),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Ubah kriteria data kamera',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        fontFamily: 'FontPoppins',
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 13),
                        padding: EdgeInsets.only(bottom: 1),
                        child: const Text(
                          'ID',
                          style: TextStyle(
                            color: Color(0xFF262626),
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          // border: Border.all(),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        width: 80,
                        height: 45,
                        child: TextField(
                          style: TextStyle(
                            color: Color(0xFF262626),
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          controller: _idController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 18.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 13),
                        padding: EdgeInsets.only(bottom: 1),
                        child: const Text(
                          'Nama Produk',
                          style: TextStyle(
                            color: Color(0xFF262626),
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          // border: Border.all(),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        width: 200,
                        height: 45,
                        child: TextField(
                          style: TextStyle(
                            color: Color(0xFF262626),
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          controller: _productNameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 18.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 13),
                    padding: EdgeInsets.only(bottom: 1),
                    child: const Text(
                      'Merek',
                      style: TextStyle(
                        color: Color(0xFF262626),
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // border: Border.all(),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    width: 200,
                    height: 45,
                    child: DropdownButton<String>(
                      value: _selectedValue,
                      underline: const Center(),
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'FontPoppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      hint: const Text(
                        "Merek Kamera",
                        style: TextStyle(color: Colors.black),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "SONY",
                          child: Text("Sony"),
                        ),
                        DropdownMenuItem(
                          value: "CANON",
                          child: Text("Canon"),
                        ),
                        DropdownMenuItem(
                          value: "NIKON",
                          child: Text("Nikon"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value ?? "Sony";
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 13),
                        padding: EdgeInsets.only(bottom: 1),
                        child: const Text(
                          'Gambar',
                          style: TextStyle(
                            color: Color(0xFF262626),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            fontFamily: 'FontPoppins',
                          ),
                        ),
                      ),
                      Container(
                        height: 45,
                        margin: EdgeInsets.only(
                            bottom: 7), // Atur nilai top sesuai kebutuhan Anda
                        child: ElevatedButton(
                          onPressed: () {
                            _selectImage();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1F1F1F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          child: const Text(
                            "Pilih Gambar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              if (_selectedImage == null && _imageUrl != null)
                Image.network(
                  _imageUrl!,
                  height: 300,
                ),
              if (_selectedImage != null)
                Image.file(
                  File(_selectedImage!.path),
                  height: 300,
                ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 13),
                        padding: EdgeInsets.only(bottom: 1),
                        child: const Text(
                          'Resolusi Gambar Maksimal',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FontPoppins',
                            color: Color(0xFF262626),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // border: Border.all(),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(26),
                            ),
                            width: 100,
                            height: 45,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Color(0xFF262626),
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              controller: _maxImageResolutionController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 18.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const Text(
                            'mp',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'FontPoppins'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 13),
                        padding: EdgeInsets.only(bottom: 1),
                        child: const Text(
                          'Resolusi Video Maksimal',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FontPoppins',
                            color: Color(0xFF262626),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // border: Border.all(),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            width: 100,
                            height: 45,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Color(0xFF262626),
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              controller: _maxVideoResolutionController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 18.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const Text(
                            'p',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'FontPoppins',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 13),
                        padding: EdgeInsets.only(bottom: 1),
                        child: const Text(
                          'ISO maks',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FontPoppins',
                            color: Color(0xFF262626),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          // border: Border.all(),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        width: 150,
                        height: 45,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Color(0xFF262626),
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          controller: _isoMaxController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 18.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 13),
                        padding: EdgeInsets.only(bottom: 1),
                        child: const Text(
                          'Baterai',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FontPoppins',
                            color: Color(0xFF262626),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          // border: Border.all(),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        width: 150,
                        height: 45,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Color(0xFF262626),
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          controller: _batteryController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 18.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 13),
                        padding: EdgeInsets.only(bottom: 1),
                        child: const Text(
                          'Berat',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FontPoppins',
                            color: Color(0xFF262626),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // border: Border.all(),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            width: 100,
                            height: 45,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Color(0xFF262626),
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              controller: _weightController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 18.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const Text(
                            'gram',
                            style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 13),
                        padding: EdgeInsets.only(bottom: 1),
                        child: const Text(
                          'Harga',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FontPoppins',
                            color: Color(0xFF262626),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // border: Border.all(),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            width: 200,
                            height: 45,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Color(0xFF262626),
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              controller: _priceController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 18.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const Text(
                            'Rupiah',
                            style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      final navigator = Navigator.of(context);
                      String? getImageUrl;

                      if (_selectedImage != null) {
                        final FirebaseStorage firebaseStorage =
                            FirebaseStorage.instance;

                        final uploadFile = await firebaseStorage
                            .ref()
                            .child("$_selectedValue/${_selectedImage!.name}")
                            .putFile(File(_selectedImage!.path));

                        getImageUrl = await uploadFile.ref.getDownloadURL();
                      }
                      await camera.doc(widget.documentSnapshot.id).set({
                        "namaProduk": _productNameController.text,
                        "gambar": getImageUrl ?? _imageUrl,
                        "resGbr":
                            double.parse(_maxImageResolutionController.text),
                        "resVid": int.parse(_maxVideoResolutionController.text),
                        "maxISO": int.parse(_isoMaxController.text),
                        "baterai": int.parse(_batteryController.text),
                        "berat": int.parse(_weightController.text),
                        "harga": int.parse(_priceController.text),
                        "merek": _selectedValue,
                      }, SetOptions(merge: true));

                      scaffoldMessenger.showSnackBar(
                        const SnackBar(content: Text('Data sudah diupdate')),
                      );
                      Navigator.popAndPushNamed(context, 'list_page');
                    },
                    child: Container(
                      width: 150,
                      height: 45,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color(0xFF1F1F1F),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: const Text(
                        'UPDATE',
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
