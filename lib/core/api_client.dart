import 'dart:convert';
import 'package:uashopi_mobile/model/ruangan.dart';
import 'package:uashopi_mobile/model/booking.dart';
import 'package:http/http.dart' show Client;

// import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  Client client = Client();

  Future<void> registerUser(Map<String, dynamic>? data) async {
    try {
      final response = await client.post(
        Uri.parse("https://simaru.amisbudi.cloud/api/auth/register"),
        body: data,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Registrasi berhasil
        print('Registration successful');
      } else {
        // Registrasi gagal
        print('Registration failed: ${response.body}');
      }
    } catch (e) {
      // Tangani kesalahan
      print('Error during registration: $e');
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      final response = await client.post(
          Uri.parse('https://simaru.amisbudi.cloud/api/auth/login'),
          body: {
            'email': email,
            'password': password,
          });

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future<dynamic> getUserProfileData(String accessToken) async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var accessToken = localStorage.getString('accessToken');
    // try {
    final response =
        await client.get(Uri.parse('https://simaru.amisbudi.cloud/api/auth/me'),
            // queryParameters: {'apikey': ApiSecret.apiKey},
            headers: {'Authorization': 'Bearer $accessToken'});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
    // } catch (e) {
    //   throw Exception(e);
    // }
  }

  Future<dynamic> logout(String accessToken) async {
    try {
      final response = await client
          .get(Uri.parse('https://simaru.amisbudi.cloud/api/auth/logout'),
              // queryParameters: {'apikey': ApiSecret.apiKey},
              headers: {'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200) {
        return ruanganFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Ruangan>> getRuanganData(String accessToken) async {
    try {
      final response = await client.get(
        Uri.parse('https://simaru.amisbudi.cloud/api/ruangans/all'),
        // queryParameters: {'apikey': ApiSecret.apiKey},
        headers: {
          'Authorization': 'Bearer $accessToken',
          'content-type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        return ruanganFromJson(response.body);
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> addRuangan(
      String accessToken, Map<String, dynamic>? data) async {
    try {
      final response = await client.post(
        Uri.parse("https://simaru.amisbudi.cloud/api/ruangans/create"),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'content-type': 'application/json'
        },
        body: jsonEncode(data),
        // queryParameters: {'apikey': ApiSecret.apiKey},
        // options: Options(headers: {'X-LoginRadius-Sott': ApiSecret.sott})
      );
      // if (response.statusCode == 200) {
      //   return response;
      // } else {
      return response;
      // }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> delRuangan(String accessToken, dynamic id) async {
    try {
      final response = await client.delete(
        Uri.parse("https://simaru.amisbudi.cloud/api/ruangans/$id/delete"),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'content-type': 'application/json'
        },
        // body: jsonEncode(data),
        // queryParameters: {'apikey': ApiSecret.apiKey},
        // options: Options(headers: {'X-LoginRadius-Sott': ApiSecret.sott})
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> updateRuangan(
      String accessToken, Map<String, dynamic>? data, dynamic id) async {
    try {
      final response = await client.post(
        Uri.parse("https://simaru.amisbudi.cloud/api/ruangans/$id/update"),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'content-type': 'application/json'
        },
        body: jsonEncode(data),
        // queryParameters: {'apikey': ApiSecret.apiKey},
        // options: Options(headers: {'X-LoginRadius-Sott': ApiSecret.sott})
      );
      // if (response.statusCode == 200) {
      //   return response;
      // } else {
      return response;
      // }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Booking>> getBookingData(String accessToken) async {
    try {
      final response = await client.get(
        Uri.parse('https://simaru.amisbudi.cloud/api/bookings/all'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'content-type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return bookingFromJson(response.body);
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> addBooking(
      String accessToken, Map<String, dynamic>? data) async {
    try {
      final response = await client.post(
        Uri.parse("https://simaru.amisbudi.cloud/api/bookings/create"),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'content-type': 'application/json'
        },
        body: jsonEncode(data),
        // queryParameters: {'apikey': ApiSecret.apiKey},
        // options: Options(headers: {'X-LoginRadius-Sott': ApiSecret.sott})
      );
      // if (response.statusCode == 200) {
      //   return response;
      // } else {
      return response;
      // }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> delBooking(String accessToken, dynamic id) async {
    try {
      final response = await client.delete(
        Uri.parse("https://simaru.amisbudi.cloud/api/bookings/$id/delete"),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'content-type': 'application/json'
        },
        // body: jsonEncode(data),
        // queryParameters: {'apikey': ApiSecret.apiKey},
        // options: Options(headers: {'X-LoginRadius-Sott': ApiSecret.sott})
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> updateBooking(
      String accessToken, Map<String, dynamic>? data, dynamic id) async {
    try {
      final response = await client.post(
        Uri.parse("https://simaru.amisbudi.cloud/api/bookings/$id/update"),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'content-type': 'application/json'
        },
        body: jsonEncode(data),
        // queryParameters: {'apikey': ApiSecret.apiKey},
        // options: Options(headers: {'X-LoginRadius-Sott': ApiSecret.sott})
      );
      // if (response.statusCode == 200) {
      //   return response;
      // } else {
      return response;
      // }
    } catch (e) {
      throw Exception(e);
    }
  }
}
