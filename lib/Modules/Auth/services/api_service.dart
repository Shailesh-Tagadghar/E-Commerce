import 'dart:convert';
import 'dart:io';
import 'package:ecommerce/Utils/Constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiService {
  // Register a user
  static Future<void> registerUser(
      Map<String, dynamic> registrationData) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.register}');

    final storage = GetStorage();
    final fcmToken = storage.read('fcm_token');

    try {
      // print('Sending request to $url with data: $registrationData');

      var request = http.MultipartRequest('POST', url)
        ..fields['name'] = registrationData['name']
        ..fields['email'] = registrationData['email']
        ..fields['password'] = registrationData['password']
        ..fields['number'] = registrationData['number']
        ..fields['gender'] = registrationData['gender']
        ..fields['address'] = registrationData['address']
        ..fields['fcm_token'] = fcmToken ?? 'dummy_fcm_token'
        ..fields['login_type'] = registrationData['login_type'];

      if (registrationData['image'] != null) {
        var imageFile = File(registrationData['image']);
        var imageExtension = imageFile.path.split('.').last.toLowerCase();
        var mimeType;

        // Set MIME type based on file extension
        if (imageExtension == 'jpg' || imageExtension == 'jpeg') {
          mimeType = 'image/jpeg';
        } else if (imageExtension == 'png') {
          mimeType = 'image/png';
        } else {
          throw Exception('Unsupported image format');
        }

        request.files.add(await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType: MediaType.parse(mimeType),
        ));
      }

      var response = await request.send().timeout(
          const Duration(seconds: 30)); // Adding a timeout for network requests

      response.stream.transform(utf8.decoder).listen((value) {
        // print('Response body: $value');
        if (response.statusCode == 200) {
          final data = jsonDecode(value);
          print('User registered successfully');
          Get.snackbar("Success", "User registered successfully",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white);
          GetStorage().write('user_data', data);
          // storage.write('user_data', data);
          storage.write('token', data['token']); // Store token
          print('Data after registration : $data');
        } else {
          print('Server returned an error: ${response.statusCode}');
          Get.snackbar(
              "Error", "Failed to register user: ${response.statusCode}",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
          throw Exception('Failed to register user');
        }
      });
    } catch (e) {
      print('Error during registration: $e');
      Get.snackbar("Error", "Error during registration: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      throw Exception('Failed to register user');
    }
  }

  static Future<void> loginUser(Map<String, dynamic> loginData) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.login}');

    final fcmToken = GetStorage().read('fcm_token');

    try {
      // print('Sending login request to $url with data: $loginData');

      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': loginData['email'],
              'password': loginData['password'],
              'fcm_token': fcmToken ?? 'dummy_fcm_token',
              'login_type': loginData['login_type'],
            }),
          )
          .timeout(const Duration(
              seconds: 30)); // Adding a timeout for network requests

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Get.snackbar("Success", "User logged in successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        print('User logged in successfully');
        // Store the user information in GetStorage for persistence
        final storage = GetStorage();
        storage.write('user_data', data);
        storage.write('token', data['token']); // Store token
        print('Data after Login : $data');
      } else {
        print('Server returned an error: ${response.statusCode}');
        Get.snackbar("Error", "Failed to log in: ${response.statusCode}",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        throw Exception('Failed to log in');
      }
    } catch (e) {
      print('Error during login: $e');
      Get.snackbar("Error", "Error during login: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      throw Exception('Failed to log in');
    }
  }

  // Method to change password
  static Future<void> changePassword(
      Map<String, dynamic> data, String token) async {
    const String url = '${ApiConstants.baseUrl}${ApiConstants.forgetPassword}';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', // Add the token in the header
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data), // Encode the request body to JSON
      );

      if (response.statusCode == 200) {
        // Password change successful
        Get.snackbar("Success", "Password changed successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        print('Password changed successfully');
      } else {
        // Handle failure
        Get.snackbar("Error", "Failed to change password: ${response.body}",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        throw Exception('Failed to change password: ${response.body}');
      }
    } catch (e) {
      Get.snackbar("Error", "Error changing password: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  // Fetch coupons
  static Future<List<Map<String, dynamic>>> fetchCoupons() async {
    const String url =
        '${ApiConstants.baseUrl}${ApiConstants.getCoupons}'; // Adjust endpoint as necessary

    final token = GetStorage()
        .read('token'); // Adjust if your token storage key is different
    print('Bearer Token : $token');
    final headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll(headers);

      // Send the request and await the response
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody'); // Log the response body
        final data = jsonDecode(responseBody);

        // Check if data is a Map and contains the 'coupons' key
        if (data is Map && data.containsKey('data')) {
          List<dynamic> coupons = data['data'];
          // Get.snackbar("Success", "Coupons fetched successfully",
          //     snackPosition: SnackPosition.BOTTOM,
          //     backgroundColor: Colors.green,
          //     colorText: Colors.white);
          return coupons
              .map((coupon) => coupon as Map<String, dynamic>)
              .toList();
        } else {
          Get.snackbar("Error", "Unexpected response format",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
          throw Exception('Unexpected response format');
        }
      } else {
        print('Error response: ${response.reasonPhrase}');
        throw Exception('Failed to fetch coupons: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching coupons: $e');
      Get.snackbar("Error", "Failed to fetch coupons: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      throw Exception('Failed to fetch coupons');
    }
  }

  //fetch Carousal
  static Future<List<Map<String, dynamic>>> fetchCarousal() async {
    const String url = '${ApiConstants.baseUrl}${ApiConstants.getCarousal}';

    final token = GetStorage()
        .read('token'); // Adjust if your token storage key is different
    print('Bearer Token : $token');
    final headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll(headers);

      // Send the request and await the response
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody'); // Log the response body
        final data = jsonDecode(responseBody);
        // print('carousal DATA : $data');

        // Check if data is a Map and contains the 'coupons' key
        if (data is Map && data.containsKey('data')) {
          List<dynamic> carousal = data['data'];
          // Get.snackbar("Success", "Coupons fetched successfully",
          //     snackPosition: SnackPosition.BOTTOM,
          //     backgroundColor: Colors.green,
          //     colorText: Colors.white);
          return carousal
              .map((carousal) => carousal as Map<String, dynamic>)
              .toList();
        } else {
          Get.snackbar("Error", "Unexpected response format",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
          throw Exception('Unexpected response format');
        }
      } else {
        print('Error response: ${response.reasonPhrase}');
        throw Exception('Failed to fetch coupons: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching coupons: $e');
      Get.snackbar("Error", "Failed to fetch coupons: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      throw Exception('Failed to fetch coupons');
    }
  }
}
