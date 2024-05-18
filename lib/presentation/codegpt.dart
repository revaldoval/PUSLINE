  // Future<Map<String, dynamic>> getUserData(
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

  //       // Set user data to UserProvider after fetching from API
  //       context.read<UserProvider>().setUserBaru(
  //             UserModelBaru(
  //               username: responseData['username'] ?? '',
  //               nama: responseData['nama'] ?? '',
  //               foto_profil: responseData['foto_profil'] ?? '',
  //               email: responseData['email'] ?? '',
  //               noHp: responseData['no_hp'] ?? '',
  //               created: responseData['created'] ?? '',
  //               kode_otp: responseData['kode_otp'] ?? '',
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