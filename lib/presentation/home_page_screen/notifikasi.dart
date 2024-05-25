import 'package:flutter/material.dart';
import 'package:tolong_s_application1/presentation/notifikasi_2/detail_notifikasi.dart';
import 'package:tolong_s_application1/theme/custom_text_style.dart';
import 'package:get/get.dart';
import 'package:tolong_s_application1/theme/ApiService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/notifikasi_model.dart'; // Ubah import sesuai dengan nama file model yang sesuai
import '../models/user_model_baru.dart';
import '../models/user_provider.dart';
import 'package:provider/provider.dart';

class Notifikasi extends StatefulWidget {
  const Notifikasi({Key? key}) : super(key: key);

  @override
  State<Notifikasi> createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  late Future<List<NotifikasiListModel>> _NotifikasiList;

  @override
  void initState() {
    super.initState();
    _NotifikasiList = fetchNotiications();
  }

  Future<List<NotifikasiListModel>> fetchNotiications() async {
    final apiService = ApiService();
    UserModelBaru? user =
        Provider.of<UserProvider>(context, listen: false).userBaru;
    final String nik = user!.nik;
    try {
      final response = await http
          .get(Uri.parse('${apiService.baseUrl}/get_notifikasi.php?nik=$nik'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          final List<dynamic> jsonData = responseData['data'];
          return jsonData
              .map((item) => NotifikasiListModel.fromJson(item))
              .toList();
        } else {
          print(responseData['message']);
          return []; // Handle API errors gracefully
        }
      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print(error);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Notifikasi",
            style: CustomTextStyles.titleMediumMedium,
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF49A18C),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 3),
          child: FutureBuilder<List<NotifikasiListModel>>(
            future: _NotifikasiList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final notifications = snapshot.data!;
                if (notifications.isEmpty) {
                  return Center(child: Text('Belum ada notifikasi.'));
                }
                return ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notifikasi = notifications[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                      child: NotifBox(
                        notifikasi: notifikasi,
                        apiService: ApiService(), // Pass ApiService instance
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

// class NotifBox extends StatelessWidget {
//   final NotifikasiListModel notifikasi;
//   final ApiService apiService; // Add ApiService field

//   const NotifBox({Key? key, required this.notifikasi, required this.apiService})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Color backgroundColor;
//     Icon icon;
//     switch (notifikasi.status_pendaftaran) {
//       case 'Ditolak':
//         backgroundColor = Colors.red.withOpacity(0.1);
//         icon = Icon(Icons.error_outline, color: Colors.red, size: 40);
//         break;
//       case 'Diterima':
//         backgroundColor = Colors.green.withOpacity(0.1);
//         icon = Icon(Icons.check_circle_outline, color: Colors.green, size: 40);
//         break;
//       case 'Diproses':
//         backgroundColor = Colors.amber.withOpacity(0.1);
//         icon = Icon(Icons.watch_later_outlined, color: Colors.amber, size: 40);
//         break;
//       default:
//         backgroundColor = Colors.grey.withOpacity(0.1);
//         icon = Icon(Icons.notifications, color: Colors.grey, size: 40);
//     }

//     return GestureDetector(
//       onTap: () {
//         print('id_pendaftaran : ${notifikasi.id_pendaftaran}');
//         Get.to(
//             () => DetailNotifikasi(id_pendaftaran: notifikasi.id_pendaftaran));
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white, // Set background color to white
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: Offset(0, 3), // changes position of shadow
//             ),
//           ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             icon,
//             SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     notifikasi.status_pendaftaran,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Tanggal Pendaftaran: ${notifikasi.tanggal_pendaftaran}',
//                     style: TextStyle(fontSize: 14, color: Colors.grey),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Jenis Poli: ${notifikasi.jenis_poli}',
//                     style: TextStyle(fontSize: 14, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class NotifBox extends StatelessWidget {
  final NotifikasiListModel notifikasi;
  final ApiService apiService; // Add ApiService field

  const NotifBox({Key? key, required this.notifikasi, required this.apiService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Icon icon;
    switch (notifikasi.status_pendaftaran) {
      case 'Ditolak':
        backgroundColor = Colors.red.withOpacity(0.1);
        icon = Icon(Icons.error_outline, color: Colors.red, size: 40);
        break;
      case 'Diterima':
        backgroundColor = Colors.green.withOpacity(0.1);
        icon = Icon(Icons.check_circle_outline, color: Colors.green, size: 40);
        break;
      case 'Diproses':
        backgroundColor = Colors.amber.withOpacity(0.1);
        icon = Icon(Icons.watch_later_outlined, color: Colors.amber, size: 40);
        break;
      default:
        backgroundColor = Colors.grey.withOpacity(0.1);
        icon = Icon(Icons.notifications, color: Colors.grey, size: 40);
    }

    return GestureDetector(
      onTap: () {
        print('id_pendaftaran : ${notifikasi.id_pendaftaran}');
        Get.to(
            () => DetailNotifikasi(id_pendaftaran: notifikasi.id_pendaftaran),
            transition: Transition.fadeIn);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white, // Set background color to white
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notifikasi.status_pendaftaran,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black, // Set text color to black
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tanggal Pendaftaran: ${notifikasi.tanggal_pendaftaran}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87, // Set text color to black87
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Jenis Poli: ${notifikasi.jenis_poli}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87, // Set text color to black87
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
