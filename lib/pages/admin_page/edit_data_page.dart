import 'package:camera_market_app/pages/admin_page/insert_page.dart';
import 'package:camera_market_app/pages/admin_page/list_page.dart';
import 'package:flutter/material.dart';

class EditDataPage extends StatelessWidget {
  const EditDataPage({Key? key}) : super(key: key);
  static const routeName = 'editDataPageRoute';

  @override
  Widget build(BuildContext context) {
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              height: constraints.maxHeight,
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
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Edit Data',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 140,
                  ),
                  _buildEditButton(
                    'Insert Data',
                    () => Navigator.pushNamed(context, InsertPage.routeName),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildEditButton(
                    'List Data Camera',
                    () => Navigator.pushNamed(context, DataListPage.routeName),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InkWell _buildEditButton(String title, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // border: Border.all(),
          color: Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(30),
        ),
        width: 200,
        height: 45,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'FontPoppins',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
