// import 'package:flutter/foundation.dart';
// import 'package:healthx_patient/configs/network/data_provider.dart';
// import 'package:healthx_patient/core/constants/apis.dart';
// import 'package:healthx_patient/features/home_tab/model/drug_list_model.dart';
// import 'package:healthx_patient/shared/pref_key.dart';
//
// class DrugRepository {
//   final DataProvider _dataProvider = DataProvider();
//   PREFSKey prefs = PREFSKey();
//
//   Future<DrugListModel?> getAllDrugs(int page, brandNameContains) async {
//     DrugListModel? drugListModel;
//
//     String? pref_header = await prefs.getAccessToken();
//
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//
//     dynamic query = {
//       "page": page,
//       "page_size": 20,
//       "brand_name__icontains": brandNameContains
//     };
//
//     print(header);
//     print(query);
//
//     var response = await _dataProvider.performRequest("GET", APIPath.fetchDrugs,
//         header: header, query: query);
//
//     if (response!.statusCode == 200) {
//       try {
//         dynamic data = response.data;
//         drugListModel = DrugListModel.fromJson(data);
//       } catch (e, stackTrace) {
//         if (kDebugMode) {
//           print(e);
//         }
//       }
//     }
//
//     print("RESPONSE: ${response.statusCode}");
//
//     return drugListModel;
//   }
//
//   Future<bool> addDrug({
//     required String brandName,
//     required String form,
//     required String strength,
//     required String company_name,
//     required String generic_name,
//     required String instruction,
//     required String sort_key,
//   }) async {
//     bool isSuccess = false;
//     String? pref_header = await prefs.getAccessToken();
//
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//     dynamic data = {
//       "brand_name": brandName,
//       "form": form,
//       "strength": strength,
//       "company_name": company_name,
//       "generic_name": generic_name,
//       "instruction": instruction,
//       "sort_key": sort_key,
//     };
//
//     var response = await _dataProvider
//         .performRequest("POST", APIPath.fetchDrugs, header: header, data: data);
//
//     if (response != null) {
//       print(response.data);
//       if (response.statusCode == 201) {
//         isSuccess = true;
//       } else {
//         isSuccess = false;
//       }
//     } else {
//       isSuccess = false;
//     }
//     print("RESPONSE: ${response!.statusCode}");
//     return isSuccess;
//   }
//
//   Future<bool> updateDrug({
//     required int drugId,
//     required String brandName,
//     required String form,
//     required String strength,
//     required String company_name,
//     required String generic_name,
//     required String instruction,
//     required String sort_key,
//   }) async {
//     bool _isSuccess = false;
//     dynamic data = {
//       "brand_name": brandName,
//       "form": form,
//       "strength": strength,
//       "company_name": company_name,
//       "generic_name": generic_name,
//       "instruction": instruction,
//       "sort_key": sort_key,
//     };
//
//     print(data);
//     String? pref_header = await prefs.getAccessToken();
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//     print(header);
//     print(APIPath.fetchDrugs);
//     var response = await _dataProvider.performRequest(
//         "PATCH", APIPath.fetchDrugs + "$drugId/",
//         data: data, header: header);
//
//     if (response!.statusCode == 200) {
//       _isSuccess = true;
//     } else {
//       _isSuccess = false;
//     }
//     return _isSuccess;
//   }
//
//   Future<bool> deleteDrug({
//     required int drugId,
//   }) async {
//     bool _isSuccess = false;
//     String? pref_header = await prefs.getAccessToken();
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//     print(header);
//     dynamic data = {
//       "id": drugId,
//     };
//     print(APIPath.fetchDrugs);
//     var response = await _dataProvider.performRequest(
//         "DELETE", APIPath.fetchDrugs + "$drugId/",
//         header: header, query: data);
//
//     if (response!.statusCode == 204) {
//       _isSuccess = true;
//     } else {
//       _isSuccess = false;
//     }
//     return _isSuccess;
//   }
// }
