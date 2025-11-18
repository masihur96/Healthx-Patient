// import 'package:anuj_prokashon/configs/network/data_provider.dart';
// import 'package:anuj_prokashon/core/constants/apis.dart';
// import 'package:anuj_prokashon/core/utils/storage_service.dart';
// import 'package:anuj_prokashon/features/auth/data/models/auth_model.dart';
// import 'package:anuj_prokashon/features/profile/data/models/country_model.dart';
// import 'package:anuj_prokashon/features/profile/data/models/division_model.dart';
// import 'package:anuj_prokashon/features/profile/data/models/profile_response_model.dart';
// import 'package:dio/dio.dart';
// import 'package:image_picker/image_picker.dart';
//
// class UserProfileService {
//   final DataProvider _dataProvider = DataProvider();
//
//   Future<UserProfileResponse?> getUserProfileDetails() async {
//     // Fetching book data from the API
//
//     AuthModel? user = await StorageService.getAuthData();
//
//     if (user == null) {
//       return null;
//     }
//     final Map<String, dynamic> header = {"Authorization": "Bearer ${user.jwt}"};
//     try {
//       final response = await _dataProvider.performRequest(
//         "GET",
//         APIPath.myProfile,
//         header: header,
//       );
//
//       if (response != null && response.statusCode == 200) {
//         final data = response.data;
//         if (data is Map<String, dynamic>) {
//           return UserProfileResponse.fromJson(data);
//         } else {
//           print("Unexpected data format: ${data.runtimeType}");
//           return null;
//         }
//       } else {
//         print("Request failed with status: ${response?.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("Error fetching home data: $e");
//       return null;
//     }
//   }
//
//   Future<UserProfileResponse?> updateUserProfileDetails({
//     required UserProfile userProfile,
//   }) async {
//     // Fetching book data from the API
//
//     AuthModel? user = await StorageService.getAuthData();
//
//     if (user == null) {
//       return null;
//     }
//     final Map<String, dynamic> header = {"Authorization": "Bearer ${user.jwt}"};
//
//     final Map<String, dynamic> body = userProfile.toJson();
//     body.removeWhere((key, value) => value == null || value == "");
//
//     try {
//       final response = await _dataProvider.performRequest(
//         "PATCH",
//         APIPath.myProfile,
//         header: header,
//         data: body,
//       );
//
//       print("RRRRR: ${response!.statusCode}");
//
//       if (response != null && response.statusCode == 200) {
//         final data = response.data;
//         if (data is Map<String, dynamic>) {
//           return UserProfileResponse.fromJson(data);
//         } else {
//           print("Unexpected data format: ${data.runtimeType}");
//           return null;
//         }
//       } else {
//         print("Request failed with status: ${response?.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("Error fetching home data: $e");
//       return null;
//     }
//   }
//
//   Future<bool> updateUserAvatar({
//     required XFile avatar,
//   }) async {
//     bool isUpdated = false;
//     // Fetching book data from the API
//
//     AuthModel? user = await StorageService.getAuthData();
//
//     if (user == null) {
//       return false;
//     }
//     final Map<String, dynamic> header = {"Authorization": "Bearer ${user.jwt}"};
//     final FormData formData = FormData.fromMap({
//       'avatar': await MultipartFile.fromFile(
//         avatar.path,
//         filename: avatar.path.split('/').last,
//       ),
//     });
//
//     try {
//       final response = await _dataProvider.performRequest(
//         "PATCH",
//         APIPath.avatarProfile,
//         header: header,
//         data: formData,
//       );
//
//       if (response != null && response.statusCode == 200) {
//         isUpdated = true;
//       } else {
//         isUpdated = false;
//         print("Request failed with status: ${response?.statusCode}");
//       }
//     } catch (e) {
//       isUpdated = false;
//       print("Error fetching home data: $e");
//     }
//     return isUpdated;
//   }
//
//   Future<CountryResponse?> getCountries() async {
//     print("CountryResponse:: ${APIPath.countries}");
//     try {
//       final response = await _dataProvider.performRequest(
//         "GET",
//         APIPath.countries,
//       );
//
//       if (response != null && response.statusCode == 200) {
//         final data = response.data;
//         if (data is Map<String, dynamic>) {
//           return CountryResponse.fromJson(data);
//         } else {
//           print("Unexpected data format: ${data.runtimeType}");
//           return null;
//         }
//       } else {
//         print("Request failed with status: ${response?.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("Error fetching order data: $e");
//       return null;
//     }
//   }
//
//   Future<DivisionResponse?> getDivisions({required String alpha3}) async {
//     print("CountryResponse:: ${APIPath.divisions}$alpha3");
//
//     try {
//       final response = await _dataProvider.performRequest(
//         "GET",
//         "${APIPath.divisions}$alpha3",
//       );
//
//       if (response != null && response.statusCode == 200) {
//         final data = response.data;
//         if (data is Map<String, dynamic>) {
//           return DivisionResponse.fromJson(data);
//         } else {
//           print("Unexpected data format: ${data.runtimeType}");
//           return null;
//         }
//       } else {
//         print("Request failed with status: ${response?.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("Error fetching order data: $e");
//       return null;
//     }
//   }
// }
