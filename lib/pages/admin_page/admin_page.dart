import 'package:camera_market_app/pages/admin_page/edit_data_page.dart';
import 'package:camera_market_app/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);
  static const routeName = '/adminPageRoute';

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _sandiController = TextEditingController();
  bool isHidePassword = true;

  Future<void> _login() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final login = await FirebaseFirestore.instance
        .collection("login")
        .where("admin_id", isEqualTo: _idController.text)
        .where("sandi", isEqualTo: _sandiController.text)
        .limit(1)
        .get();

    if (login.docs.isEmpty) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
            content: Text(
                'Admin ID atau Kata Sandi salah, silahkan cek ulang kembali')),
      );
      return;
    }

    navigator.pushNamed(EditDataPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.only(top: 0),
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/backarrow.svg',
              color: Color(0xFF262626),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => HomePage(),
                ),
              );
            },
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
      body: Container(
        height: double.infinity,
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Masuk Sebagai Admin',
              style: TextStyle(
                fontFamily: 'FontPoppins',
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Admin ID',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'FontPoppins',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // border: Border.all(),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      width: 250,
                      child: TextField(
                        style: TextStyle(
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
                  height: 16.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Kata Sandi',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'FontPoppins',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // border: Border.all(),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      width: 250,
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        controller: _sandiController,
                        obscureText: isHidePassword,
                        obscuringCharacter: '*',
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 18.0),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isHidePassword = !isHidePassword;
                              });
                            },
                            icon: Icon(isHidePassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              child: Container(
                width: 150,
                height: 45,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: const Text(
                  'Masuk',
                  style: TextStyle(
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () => _login(),
            ),
          ],
        ),
      ),
    );
  }
}
