// import 'package:medicare_doctor/configs/network/data_provider.dart';
// import 'package:medicare_doctor/core/constants/apis.dart';
// import 'package:medicare_doctor/core/utils/storage_service.dart';
// import 'package:medicare_doctor/features/auth/data/models/auth_token_model.dart';
// import 'package:medicare_doctor/features/medicine/data/models/medication_model.dart';
//
// class MedicineService {
//   final DataProvider _dataProvider = DataProvider();
//
//   Future<MedicineListResponse?> getMedicineData(
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
//           "GET", APIPath.fetchDrugs,
//           query: queryData, header: header);
//       if (response != null && response.statusCode == 200) {
//         final data = response.data;
//
//         if (data is Map<String, dynamic>) {
//           return MedicineListResponse.fromJson(data);
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
//   Future<MedicineListResponse?> searchMedicines({required String query}) async {
//     final Map<String, dynamic> queryData = {
//       "brand_name__icontains": query,
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
//           "GET", APIPath.fetchDrugs,
//           query: queryData, header: header);
//
//       if (response != null && response.statusCode == 200) {
//         final data = response.data;
//
//         if (data is Map<String, dynamic>) {
//           return MedicineListResponse.fromJson(data);
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
// }
