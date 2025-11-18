// import 'package:medicare_doctor/configs/network/data_provider.dart';
// import 'package:medicare_doctor/core/constants/apis.dart';
// import 'package:medicare_doctor/core/utils/storage_service.dart';
// import 'package:medicare_doctor/features/auth/data/models/auth_token_model.dart';
// import 'package:medicare_doctor/features/patient/data/models/patient_model.dart';
//
// class PatientService {
//   final DataProvider _dataProvider = DataProvider();
//
//   Future<PatientListResponse?> getPatientListData(
//       {int page = 1, int pageSize = 10}) async {
//     final AuthTokenModel? authTokenModel = await StorageService.getAuthData();
//
//     if (authTokenModel == null) return null;
//
//     dynamic header = {"Authorization": "Bearer ${authTokenModel.access}"};
//
//     final Map<String, dynamic> queryData = {
//       "page": page,
//       "page_size": pageSize,
//     };
//
//     print("medicine Query:: $queryData");
//     try {
//       final response = await _dataProvider.performRequest(
//           "GET", APIPath.fetchPatient,
//           query: queryData, header: header);
//       if (response != null && response.statusCode == 200) {
//         final data = response.data;
//
//         if (data is Map<String, dynamic>) {
//           return PatientListResponse.fromJson(data);
//         } else {
//           print("Unexpected data format: ${data.runtimeType}");
//           return null;
//         }
//       } else {
//         print("Request failed with status: ${response?.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("Error fetching medicine data: $e");
//       return null;
//     }
//   }
//
//   Future<PatientListResponse?> searchPatient({required String query}) async {
//     final Map<String, dynamic> queryData = {
//       "search": query,
//     };
//     final AuthTokenModel? authTokenModel = await StorageService.getAuthData();
//
//     if (authTokenModel == null) return null;
//
//     dynamic header = {"Authorization": "Bearer ${authTokenModel.access}"};
//     print("Search query: $queryData");
//
//     try {
//       final response = await _dataProvider.performRequest(
//           "GET", APIPath.fetchPatient,
//           query: queryData, header: header);
//
//       if (response != null && response.statusCode == 200) {
//         final data = response.data;
//
//         if (data is Map<String, dynamic>) {
//           return PatientListResponse.fromJson(data);
//         } else {
//           print("Unexpected data format: ${data.runtimeType}");
//           return null;
//         }
//       } else {
//         print("Request failed with status: ${response?.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("Error searching books: $e");
//       return null;
//     }
//   }
//
//   Future<bool> registerPatient(
//       {required String fullName,
//       required String phone,
//       required String email,
//       required String gender,
//       required String age,
//       required String dob}) async {
//     final AuthTokenModel? authTokenModel = await StorageService.getAuthData();
//
//     if (authTokenModel == null) return false;
//
//     dynamic header = {"Authorization": "Bearer ${authTokenModel.access}"};
//     dynamic data = {
//       "email": email.toLowerCase(),
//       "firstname": fullName.trim().split(' ').isNotEmpty
//           ? fullName.trim().split(' ').first
//           : '',
//       "lastname": fullName.trim().split(' ').length > 1
//           ? fullName.trim().split(' ').sublist(1).join(' ')
//           : '',
//       "phone_number": phone,
//       "date_of_birth": dob,
//       "patient_registered": true,
//       "gender": gender,
//     };
//
//     print("Register Patient Data:: $data");
//     print("Register Patient API:: ${APIPath.fetchPatient}");
//
//     try {
//       var response = await _dataProvider.performRequest(
//         "POST",
//         APIPath.fetchPatient,
//         data: data,
//         header: header,
//       );
//       print("Register Patient response:: $response");
//
//       if (response != null) {
//         print("Register Patient response:: ${response.statusCode}");
//         if (response.statusCode == 201) {
//           // Registration successful and returns user data
//           return true;
//         } else {
//           // Handle error response
//           return false;
//         }
//       } else {
//         return false;
//       }
//     } catch (e) {
//       return false;
//     }
//   }
// }
