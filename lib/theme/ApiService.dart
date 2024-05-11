import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ApiService {
  final String baseUrl = "http://192.168.0.103/projek";
  final String fotoProfilUrl = "http://192.168.0.103/projek/images/profil/";

  Future<Map<String, dynamic>> register(
      String nik,
      String nama,
      String jenis_kelamin,
      String tanggal_lahir,
      String email,
      String no_telepon,
      String kata_sandi) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nik': nik,
          'nama': nama,
          'jenis_kelamin': jenis_kelamin,
          'tanggal_lahir': tanggal_lahir,
          'email': email,
          'no_telepon': no_telepon,
          'kata_sandi': kata_sandi,
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
      String status_pendaftaran,
      String antrian) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pendaftaranpoli.php'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'nik': nik,
          'id_poli': id_poli,
          'tanggal_pendaftaran': tanggal_pendaftaran,
          'deskripsi_keluhan': deskripsi_keluhan,
          'status_pendaftaran': status_pendaftaran,
          'antrian': antrian
        },
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

  Future<Map<String, dynamic>> updateSandi(
      String email, String kata_sandi) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update_sandi.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'kata_sandi': kata_sandi,
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

  // String get gambarArtikelUrl => '$baseUrl/';
  // Future<Map<String, dynamic>> listArtikel(
  //     String idArtikel, String judul) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/artikel_list.php?id_artikel=$idArtikel'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData = json.decode(response.body);

  //       // Tidak perlu mengubah URL gambar karena sudah ada di PHP
  //       // String imagePath = responseData['data']['img_artikel'];
  //       // String imageUrl = '$baseUrl/$imagePath';

  //       // Tidak perlu mengubah nilai img_artikel dalam responseData menjadi URL gambar
  //       // responseData['data']['img_artikel'] = imageUrl;

  //       return responseData;
  //     } else {
  //       throw Exception(
  //           'View article failed. Server error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error during view article: $e');
  //   }
  // }

  // Detail Artikel
  Future<Map<String, dynamic>> detailArtikel(String idArtikel) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/artikel_detail.php?id_artikel=$idArtikel'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData; // Mengembalikan responseData tanpa perubahan
      } else {
        throw Exception(
            'View article failed. Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during view article: $e');
    }
  }
}
