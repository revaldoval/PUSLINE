import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:tolong_s_application1/presentation/models/user_model_baru.dart';
import 'package:tolong_s_application1/presentation/models/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ApiService {
  final String baseUrl = "http://puskesline.tifnganjuk.com/MobileApi/";
  final String imageUrl =
      "http://puskesline.tifnganjuk.com/MobileApi/images/foto_profil/";

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

  String get gambarArtikelUrl => '$baseUrl/';
  Future<Map<String, dynamic>> listArtikel(
      String idArtikel, String judul) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/artikel_list.php?id_artikel=$idArtikel'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Tidak perlu mengubah URL gambar karena sudah ada di PHP
        // String imagePath = responseData['data']['img_artikel'];
        // String imageUrl = '$baseUrl/$imagePath';

        // Tidak perlu mengubah nilai img_artikel dalam responseData menjadi URL gambar
        // responseData['data']['img_artikel'] = imageUrl;

        return responseData;
      } else {
        throw Exception(
            'View article failed. Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during view article: $e');
    }
  }

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

  // Read Profile
  Future<Map<String, dynamic>> readProfil(String nik) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/profil_read.php?nik=$nik'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Ambil image path dari responseData
        String imagePath = responseData['data']['img_profil'];
        // Gunakan image path dari responseData tanpa perubahan
        responseData['data']['img_profil'] = imagePath;

        return responseData;
      } else {
        throw Exception(
            'View profile failed. Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during view profile: $e');
    }
  }

  Future<Map<String, dynamic>> updateProfil({
    required String nik,
    required String nama,
    required String tanggal_lahir,
    required String jenis_kelamin,
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/profil_update.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nik': nik,
          'nama': nama,
          'tanggal_lahir': tanggal_lahir,
          'jenis_kelamin': jenis_kelamin,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Pastikan responseData memiliki struktur yang sesuai dengan respons dari server
        if (responseData.containsKey('status') &&
            responseData.containsKey('data')) {
          if (responseData['status'] == 'success') {
            // Ubah nilai img_profil dalam responseData menjadi URL gambar
            String imagePath = responseData['data']['img_profil'];
            String imageUrl =
                '$baseUrl/$imagePath'; // Sesuaikan dengan path gambar di server
            responseData['data']['img_profil'] = imageUrl;

            return responseData;
          } else {
            throw Exception(
                'Update profile failed: ${responseData['message']}');
          }
        } else {
          throw Exception('Invalid response format during update profile');
        }
      } else {
        throw Exception(
            'Update profile failed. Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during update profile: $e');
    }
  }

  Future<Map<String, dynamic>> beforenext(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/beforenext.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        throw Exception(
            'Checked Email failed. Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }

  Future<Map<String, dynamic>> beforenext2(String email, String nik) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/beforenext2.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'nik': nik,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        throw Exception(
            'Checked Email failed. Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }

    Future<Map<String, dynamic>> beforenext3 (String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/beforenext3.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        throw Exception(
            'Checked Email failed. Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }

  // Future<Map<String, dynamic>> getUserData(
  //     BuildContext context, String nik) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/get_user_data.php'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //         'nik': nik,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData = json.decode(response.body);

  //       // Set user data to UserProvider after fetching from API
  //       context.read<UserProvider>().setUserBaru(
  //             UserModelBaru(
  //               nik: responseData['nik'] ?? '',
  //               nama: responseData['nama'] ?? '',
  //               tanggal_lahir: responseData['tanggal_lahir'] ?? '',
  //               jenis_kelamin: responseData['jenis_kelamin'] ?? '',
  //               email: responseData['email'] ?? '',
  //               no_telepon: responseData['no_telepon'] ?? '',
  //               img_profil: responseData['img_profil'] ?? '',
  //               kode_otp: responseData['kode_otp'] ?? '',
  //               created_at: responseData['created_at'] ?? '',
  //               updated_at: responseData['updated_at'] ??
  //                   '', // Pastikan urutan parameter sesuai
  //             ),
  //           );

  //       return responseData;
  //     } else {
  //       throw Exception(
  //           'Failed to get product details. Server error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error getting product details: $e');
  //   }
  // }

  // Future<Map<String, dynamic>> getUserFotoProfil(
  //     BuildContext context, String username) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/get_user_data.php'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //         'username': username,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData = json.decode(response.body);

  //       // Update only the foto_profil in UserProvider after fetching from API
  //       context
  //           .read<UserProvider>()
  //           .updateUserFotoProfil(responseData['foto_profil'] ?? '');

  //       return responseData;
  //     } else {
  //       throw Exception(
  //           'Failed to get product details. Server error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error getting product details: $e');
  //   }
  // }
}
