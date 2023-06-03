import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);
  static const routeName = '/aboutPageRoute';

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
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.all(18.0),
                    child: const Text(
                      'Tentang Aplikasi',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  top: 60.0,
                  bottom: 0.0,
                  child: Container(
                    padding: const EdgeInsets.all(18.0),
                    width: double.infinity, // mengisi seluruh lebar layar
                    height: 200.0, // tinggi container kedua
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100,
                              height: 130,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)
                              ),

                            ),
                            Container(
                              width: 100,
                              height: 130,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)
                              ),

                            ),
                            Container(
                              width: 100,
                              height: 130,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)
                              ),

                            ),
                          ],
                        ),

                        const SizedBox(height: 20,),
                        const Text("Informasi", style: TextStyle(fontWeight: FontWeight.bold),),
                        const SizedBox(height: 20,),
                        const Text("Aplikasi Sistem Rekomendasi Kamera ini dibuat menggunakan metode Weighted Aggregated Sum Product Assessment (WASPAS) untuk mendapatkan rekomendasi kamera terbaik sesuai dengan kebutuhan pengguna. Dengan memasukkan bobot terhadap spesifikasi kamera yang dibutuhkan, sistem dapat merekomendasikan kamera yang paling sesuai dengan kebutuhan pengguna. Pengguna memasukkan data kebutuhan pada diagram likert yang memiliki nilai antara satu (1) sampai lima (5)."),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        )
    );
  }
}