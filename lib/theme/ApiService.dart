import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ApiService {
  // static Uri url(url) {
  //   Uri Server = Uri.parse("http://z/projek/" + url);
  //   return Server;
  // }
//  static String urlString(String url) {
//     String Server = "http://172.17.202.43/Baticraft/baticraft/fh_db/" + url;
//     return Server;
// }
//   static String urlImageDatabase(url) {
//     String Server = "http://172.17.202.43/Baticraft/baticraft/fh_db/images/" + url;
//     return Server;
//   }
  final String baseUrl = "http://172.16.103.162/projek";
  // static String urlGambar(url) {
  //   String Server = "assets/images/" + url;
  //   return Server;
  // }
  Future<Map<String, dynamic>> login(String nik, String kata_sandi) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nik': nik,
          'kata_sandi': kata_sandi,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        throw Exception('Login failed. Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  Future<Map<String, dynamic>> daftarpoli(
      String nik,
      String id_poli,
      String tanggal_pendaftaran,
      String deskripsi_keluhan,
      String antrian) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pendaftaranpoli.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nik': nik,
          'id_poli': id_poli,
          'tanggal_pendaftaran': tanggal_pendaftaran,
          'deskripsi_keluhan': deskripsi_keluhan,
          'antrian': antrian,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        throw Exception(
            'Registration failed. Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }
}
