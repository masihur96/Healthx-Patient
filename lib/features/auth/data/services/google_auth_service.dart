// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
// import 'package:medicare_doctor/core/constants/apis.dart';
// import 'package:medicare_doctor/core/constants/secrate_file.dart';
//
// class GoogleAuthService {
//   static const String _authEndpoint =
//       "https://accounts.google.com/o/oauth2/v2/auth";
//   static const String _redirectUri =
//       "${APIPath.baseUrl}/api/v1/user/doctor/register/google";
//
//   final Dio _dio = Dio();
//   final FlutterSecureStorage _storage = const FlutterSecureStorage();
//
//   /// Full Google Sign-In flow for Doctor registration
//   Future<Map<String, dynamic>?> loginWithGoogle() async {
//     try {
//       // Step 1️⃣ - Build Google Auth URL
//       final queryParams = {
//         'response_type': 'code',
//         'client_id': SecretFile.googleAuthClientId,
//         'redirect_uri': _redirectUri,
//         'scope': 'openid email profile',
//         'access_type': 'offline',
//         'prompt': 'consent',
//       };
//
//       final authUrl = Uri.parse(_authEndpoint)
//           .replace(queryParameters: queryParams)
//           .toString();
//
//       print("🌐 Opening Google Auth URL: $authUrl");
//
//       // Step 2️⃣ - Launch Google login page
//       final result = await FlutterWebAuth2.authenticate(
//         url: authUrl,
//         callbackUrlScheme: "http", // must match redirect URI scheme
//       );
//
//       // Step 3️⃣ - Extract authorization code
//       final code = Uri.parse(result).queryParameters['code'];
//       if (code == null) throw Exception("Authorization code not found.");
//       print("✅ Authorization Code: $code");
//
//       // Step 4️⃣ - Send code to backend for verification and user registration
//       final response = await _dio.get(
//         "${APIPath.baseUrl}/api/v1/user/doctor/register/google",
//         queryParameters: {'code': code},
//       );
//
//       if (response.statusCode == 200) {
//         final data = response.data;
//         print("✅ Backend Login Success: ${jsonEncode(data)}");
//
//         // Step 5️⃣ - Store tokens securely
//         await _storeTokens(
//           accessToken: data['access'],
//           refreshToken: data['refresh'],
//         );
//
//         // Step 6️⃣ - Return user data for app use
//         return data['user'];
//       } else {
//         print("❌ Unexpected Response: ${response.statusCode}");
//         return null;
//       }
//     } catch (error, stackTrace) {
//       print("❌ Google Login Error: $error");
//       print(stackTrace);
//       return null;
//     }
//   }
//
//   /// Save tokens in secure storage
//   Future<void> _storeTokens({
//     required String accessToken,
//     required String refreshToken,
//   }) async {
//     await _storage.write(key: "access_token", value: accessToken);
//     await _storage.write(key: "refresh_token", value: refreshToken);
//     print("🔒 Tokens stored securely");
//   }
//
//   /// Retrieve stored access token
//   Future<String?> getAccessToken() async {
//     return await _storage.read(key: "access_token");
//   }
//
//   /// Clear tokens on logout
//   Future<void> logout() async {
//     await _storage.deleteAll();
//     print("🚪 User logged out, tokens cleared");
//   }
// }
