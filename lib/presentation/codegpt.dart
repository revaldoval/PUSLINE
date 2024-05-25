              // ElevatedButton(
              //   onPressed: () {
              //     showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         return AlertDialog(
              //           contentPadding: EdgeInsets.zero,
              //           content: Container(
              //             height: 200,
              //             width: 350,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.only(
              //                 topLeft: Radius.circular(20),
              //                 topRight: Radius.circular(20),
              //                 bottomLeft: Radius.circular(20),
              //                 bottomRight: Radius.circular(20),
              //               ),
              //               color: Colors.white,
              //             ),
              //             child: Column(
              //               mainAxisSize: MainAxisSize.min,
              //               crossAxisAlignment: CrossAxisAlignment.stretch,
              //               children: [
              //                 Container(
              //                   decoration: BoxDecoration(
              //                     color: Color(0xFF15AFA7),
              //                     borderRadius: BorderRadius.only(
              //                       topLeft: Radius.circular(20),
              //                       topRight: Radius.circular(20),
              //                     ),
              //                   ),
              //                   padding: EdgeInsets.all(15),
              //                   child: Text(
              //                     'Daftar Pasien',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       color: Colors.white,
              //                       fontSize: 20,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(height: 20),
              //                 Padding(
              //                   padding:
              //                       const EdgeInsets.symmetric(horizontal: 20),
              //                   child: Text(
              //                     'Yakin Ingin Daftar Imunisasi?',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       color: Colors.black,
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(height: 20),
              //                 Row(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceEvenly,
              //                   children: [
              //                     ElevatedButton(
              //                       onPressed: () {
              //                         Navigator.of(context).pop();
              //                       },
              //                       style: ElevatedButton.styleFrom(
              //                         primary: Colors.white,
              //                         shape: RoundedRectangleBorder(
              //                           borderRadius: BorderRadius.circular(15),
              //                           side: BorderSide(
              //                               color: Color(0xFF15AFA7)),
              //                         ),
              //                       ),
              //                       child: Padding(
              //                         padding: EdgeInsets.symmetric(
              //                             horizontal: 30, vertical: 15),
              //                         child: Text(
              //                           'Tidak',
              //                           style: TextStyle(
              //                             color: Colors.black,
              //                             fontSize: 16,
              //                             fontWeight: FontWeight.bold,
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                     ElevatedButton(
              //                       onPressed: () {
              //                         if (_dateController.text.isEmpty) {
              //                           // Tampilkan pesan kesalahan jika _dateController kosong
              //                           showDialog(
              //                             context: context,
              //                             builder: (BuildContext context) {
              //                               return AlertDialog(
              //                                 title: Text("Gagal!",
              //                                     textAlign: TextAlign.center),
              //                                 content: Text(
              //                                     "Tanggal harus diisi.",
              //                                     textAlign: TextAlign.center),
              //                                 actions: <Widget>[
              //                                   TextButton(
              //                                     child: Text("OK"),
              //                                     onPressed: () {
              //                                       Navigator.of(context).pop();
              //                                     },
              //                                   )
              //                                 ],
              //                               );
              //                             },
              //                           );
              //                         } else {
              //                           // Lanjutkan proses jika _dateController tidak kosong
              //                           datarpoliimunisasi(context);
              //                         }
              //                       },
              //                       style: ElevatedButton.styleFrom(
              //                         primary: Color(0xFF15AFA7),
              //                         shape: RoundedRectangleBorder(
              //                           borderRadius: BorderRadius.circular(15),
              //                         ),
              //                       ),
              //                       child: Padding(
              //                         padding: EdgeInsets.symmetric(
              //                             horizontal: 45, vertical: 15),
              //                         child: Text(
              //                           'Ya',
              //                           style: TextStyle(
              //                             color: Colors.white,
              //                             fontSize: 16,
              //                             fontWeight: FontWeight.bold,
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //         );
              //       },
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     padding: EdgeInsets.symmetric(horizontal: 20),
              //     minimumSize: Size(double.infinity, 80),
              //     backgroundColor: Color(0xFF15AFA7),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(4),
              //     ),
              //   ),
              //   child: Text(
              //     'Daftar Pasien',
              //     style:
              //         CustomTextStyles.poppins13.copyWith(color: Colors.white),
              //   ),
              // ),