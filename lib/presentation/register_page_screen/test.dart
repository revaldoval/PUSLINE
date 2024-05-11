// import 'package:flutter/material.dart';
// import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';

// class MyWidget extends StatelessWidget {
//   final User? user;

//   MyWidget({this.user});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       child: FittedBox(
//         fit: BoxFit.scaleDown,
//         child: AutoSizeText(
//           "Selamat Datang! " + (user != null ? user!.nama.toString() : ""),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: CustomTextStyles.poppin15,
//         ),
//       ),
//     );
//   }
// }
