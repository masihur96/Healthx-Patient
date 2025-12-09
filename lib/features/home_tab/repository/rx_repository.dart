// import 'package:flutter/foundation.dart';
// import 'package:medicare_doctor/configs/network/data_provider.dart';
// import 'package:medicare_doctor/core/constants/apis.dart';
// import 'package:medicare_doctor/features/home_tab/model/advice_model.dart';
// import 'package:medicare_doctor/features/home_tab/model/complaint_model.dart';
// import 'package:medicare_doctor/features/home_tab/model/diagonosis_model.dart';
// import 'package:medicare_doctor/features/home_tab/model/investigation_model.dart';
// import 'package:medicare_doctor/features/home_tab/model/health_plan_model.dart';
// import 'package:medicare_doctor/shared/pref_key.dart';
//
// class RXRepository {
//   final DataProvider _dataProvider = DataProvider();
//   PREFSKey prefs = PREFSKey();
//   Future<ComplaintModel?> getComplain({
//     required String search,
//     required bool isFavourite, // required String ordering,
//   }) async {
//     ComplaintModel? complaintModel;
//     dynamic query = {
//       "name__icontains": search,
//       "is_favourite": isFavourite,
//     };
//     String? pref_header = await prefs.getAccessToken();
//
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//     print(header);
//     print(query);
//     var response = await _dataProvider.performRequest(
//         "GET", APIPath.fetchComplain,
//         header: header, query: query);
//     if (response!.statusCode == 200) {
//       try {
//         dynamic data = response.data;
//         complaintModel = ComplaintModel.fromJson(data);
//       } catch (e, stackTrace) {
//         if (kDebugMode) {
//           print(e);
//         }
//       }
//     } else if (response.statusCode == 401) {
//       RefreshToken().then(
//           (value) => getComplain(search: search, isFavourite: isFavourite));
//     }
//
//     print("RESPONSE: ${response.statusCode}");
//
//     return complaintModel;
//   }
//
//   Future<void> RefreshToken() async {
//     String? ref = await prefs.getRefreshToken();
//
//     dynamic data = {
//       "refresh": ref,
//     };
//     print("query: $data");
//     var response = await _dataProvider
//         .performRequest("POST", APIPath.refreshToken, data: data);
//
//     print("Ref Code: ${response!.statusCode}");
//
//     if (response != null && response.statusCode == 200) {
//       prefs.setAccessToken(response.data["access"]);
//       // prefs.setRefreshToken(response.data["refresh"]);
//     }
//   }
//
//   Future<MedicationModel?> getAllMedication({
//     required String search,
//     required bool isFavourite, // required String ordering,
//   }) async {
//     MedicationModel? medicationModel;
//
//     dynamic query = {
//       "name__icontains": search,
//       "is_favourite": isFavourite,
//     };
//
//     String? pref_header = await prefs.getAccessToken();
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//
//     print(header);
//
//     var response = await _dataProvider.performRequest(
//         "GET", APIPath.fetchMedication,
//         header: header, query: query);
//
//     if (response!.statusCode == 200) {
//       try {
//         dynamic data = response.data;
//         medicationModel = MedicationModel.fromJson(data);
//       } catch (e, stackTrace) {
//         if (kDebugMode) {
//           print(e);
//         }
//       }
//     } else if (response.statusCode == 401) {
//       RefreshToken().then((value) =>
//           getAllMedication(search: search, isFavourite: isFavourite));
//     }
//     print("RESPONSE: ${response.statusCode}");
//     return medicationModel;
//   }
//
//   Future<AdviceModel?> getAllAdvice({
//     required String search,
//     required bool isFavourite, // required String ordering,
//   }) async {
//     AdviceModel? adviceModel;
//
//     dynamic query = {
//       "name__icontains": search,
//       "is_favourite": isFavourite,
//     };
//
//     String? pref_header = await prefs.getAccessToken();
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//
//     print(header);
//
//     var response = await _dataProvider.performRequest(
//         "GET", APIPath.fetchAdvice,
//         header: header, query: query);
//
//     if (response!.statusCode == 200) {
//       try {
//         dynamic data = response.data;
//         adviceModel = AdviceModel.fromJson(data);
//       } catch (e, stackTrace) {
//         if (kDebugMode) {
//           print(e);
//         }
//       }
//     } else if (response.statusCode == 401) {
//       RefreshToken().then(
//           (value) => getAllAdvice(search: search, isFavourite: isFavourite));
//     }
//
//     print("RESPONSE: ${response.statusCode}");
//
//     return adviceModel;
//   }
//
//   Future<DiagnosisModel?> getAllDiagnosis({
//     required String search,
//     required bool isFavourite, // required String ordering,
//   }) async {
//     DiagnosisModel? diagnosisModel;
//
//     dynamic query = {
//       "name__icontains": search,
//       "is_favourite": isFavourite,
//     };
//     String? pref_header = await prefs.getAccessToken();
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//
//     print(header);
//
//     var response = await _dataProvider.performRequest(
//         "GET", APIPath.fetchDiagnosis,
//         header: header, query: query);
//
//     if (response!.statusCode == 200) {
//       try {
//         dynamic data = response.data;
//         diagnosisModel = DiagnosisModel.fromJson(data);
//       } catch (e, stackTrace) {
//         if (kDebugMode) {
//           print(e);
//         }
//       }
//     } else if (response.statusCode == 401) {
//       RefreshToken().then(
//           (value) => getAllDiagnosis(search: search, isFavourite: isFavourite));
//     }
//
//     print("RESPONSE: ${response.statusCode}");
//
//     return diagnosisModel;
//   }
//
//   Future<InvestigationModel?> getAllInvestigation({
//     required String search,
//     required bool isFavourite, // required String ordering,
//   }) async {
//     InvestigationModel? investigationModel;
//
//     dynamic query = {
//       "name__icontains": search,
//       "is_favourite": isFavourite,
//     };
//     String? pref_header = await prefs.getAccessToken();
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//
//     print(header);
//
//     var response = await _dataProvider.performRequest(
//         "GET", APIPath.fetchInvestigation,
//         header: header, query: query);
//
//     if (response!.statusCode == 200) {
//       try {
//         dynamic data = response.data;
//         investigationModel = InvestigationModel.fromJson(data);
//       } catch (e, stackTrace) {
//         if (kDebugMode) {
//           print(e);
//         }
//       }
//     } else if (response.statusCode == 401) {
//       RefreshToken().then((value) =>
//           getAllInvestigation(search: search, isFavourite: isFavourite));
//     }
//     print("RESPONSE: ${response.statusCode}");
//     return investigationModel;
//   }
//
//   Future<bool> addComplain({
//     required String name,
//   }) async {
//     bool _isSuccess = false;
//     dynamic data = {
//       "name": name,
//     };
//
//     String? pref_header = await prefs.getAccessToken();
//
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//
//     var response = await _dataProvider.performRequest(
//         "POST", APIPath.fetchComplain,
//         data: data, header: header);
//
//     print("header: $header");
//     print("Data: $data");
//
//     if (response!.statusCode == 201) {
//       _isSuccess = true;
//     } else {
//       _isSuccess = false;
//     }
//
//     return _isSuccess;
//   }
//
//   Future<bool> addMedication({
//     required String name,
//   }) async {
//     bool _isSuccess = false;
//     dynamic data = {
//       "name": name,
//     };
//     String? pref_header = await prefs.getAccessToken();
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//
//     print("header: $header");
//     print("Data: $data");
//
//     var response = await _dataProvider.performRequest(
//         "POST", APIPath.fetchMedication,
//         data: data, header: header);
//
//     print("Code: ${response!.statusCode}");
//
//     if (response.statusCode == 201) {
//       _isSuccess = true;
//     } else {
//       _isSuccess = false;
//     }
//
//     return _isSuccess;
//   }
//
//   Future<bool> addAdvice({
//     required String name,
//   }) async {
//     bool _isSuccess = false;
//     dynamic data = {
//       "name": name,
//     };
//
//     String? pref_header = await prefs.getAccessToken();
//
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//
//     var response = await _dataProvider.performRequest(
//         "POST", APIPath.fetchAdvice,
//         data: data, header: header);
//
//     print("header: $header");
//     print("Data: $data");
//
//     print("Code: ${response!.statusCode}");
//
//     if (response.statusCode == 201) {
//       _isSuccess = true;
//     } else {
//       _isSuccess = false;
//     }
//
//     return _isSuccess;
//   }
//
//   Future<bool> addDiagnosis({
//     required String name,
//   }) async {
//     bool _isSuccess = false;
//     dynamic data = {
//       "name": name,
//     };
//
//     String? pref_header = await prefs.getAccessToken();
//
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//
//     var response = await _dataProvider.performRequest(
//         "POST", APIPath.fetchDiagnosis,
//         data: data, header: header);
//
//     print("header: $header");
//     print("Data: $data");
//
//     print("Code: ${response!.statusCode}");
//
//     if (response.statusCode == 201) {
//       _isSuccess = true;
//     } else {
//       _isSuccess = false;
//     }
//
//     return _isSuccess;
//   }
//
//   Future<bool> addInvestigation({
//     required String name,
//   }) async {
//     bool _isSuccess = false;
//     dynamic data = {
//       "name": name,
//     };
//
//     String? pref_header = await prefs.getAccessToken();
//
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//
//     var response = await _dataProvider.performRequest(
//         "POST", APIPath.fetchInvestigation,
//         data: data, header: header);
//
//     print("header: $header");
//     print("Data: $data");
//
//     print("Code: ${response!.statusCode}");
//
//     if (response.statusCode == 201) {
//       _isSuccess = true;
//     } else {
//       _isSuccess = false;
//     }
//
//     return _isSuccess;
//   }
//
//   Future<bool> updateComplain({
//     required String complementUUID,
//     required bool isFavorite,
//   }) async {
//     bool _isSuccess = false;
//     dynamic data = {
//       "is_favourite": isFavorite,
//     };
//
//     print(data);
//     String? pref_header = await prefs.getAccessToken();
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//     print(header);
//     var response = await _dataProvider.performRequest(
//         "PATCH", APIPath.fetchComplain + "$complementUUID/",
//         data: data, header: header);
//
//     print("Update Complement: ${response!.statusCode}");
//
//     if (response.statusCode == 200) {
//       _isSuccess = true;
//     } else {
//       _isSuccess = false;
//     }
//     return _isSuccess;
//   }
//
//   Future<bool> updateMedication({
//     required String medicationUUID,
//     required bool isFavorite,
//   }) async {
//     bool _isSuccess = false;
//     dynamic data = {
//       "is_favourite": isFavorite,
//     };
//
//     print(data);
//     String? pref_header = await prefs.getAccessToken();
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//     print(header);
//     var response = await _dataProvider.performRequest(
//         "PATCH", APIPath.fetchMedication + "$medicationUUID/",
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
//   Future<bool> updateAdvice({
//     required String adviceUUID,
//     required bool isFavorite,
//   }) async {
//     bool _isSuccess = false;
//     dynamic data = {
//       "is_favourite": isFavorite,
//     };
//
//     print(data);
//     String? pref_header = await prefs.getAccessToken();
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//     print(header);
//     var response = await _dataProvider.performRequest(
//         "PATCH", APIPath.fetchAdvice + "$adviceUUID/",
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
//   Future<bool> updateDiagnosis({
//     required String diagnosisUUID,
//     required bool isFavorite,
//   }) async {
//     bool _isSuccess = false;
//     dynamic data = {
//       "is_favourite": isFavorite,
//     };
//
//     print(data);
//     String? pref_header = await prefs.getAccessToken();
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//     print(header);
//     var response = await _dataProvider.performRequest(
//         "PATCH", APIPath.fetchDiagnosis + "$diagnosisUUID/",
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
//   Future<bool> updateInvestigation({
//     required String investigationUUID,
//     required bool isFavorite,
//   }) async {
//     bool _isSuccess = false;
//     dynamic data = {
//       "is_favourite": isFavorite,
//     };
//
//     print(data);
//     String? pref_header = await prefs.getAccessToken();
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//     print(header);
//     var response = await _dataProvider.performRequest(
//         "PATCH", APIPath.fetchInvestigation + "$investigationUUID/",
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
//   Future<bool> updateDoctorAvailabilityStatus({
//     required String doctorId,
//     required bool isEnable,
//   }) async {
//     bool _isSuccess = false;
//     dynamic data = {
//       "availibility_status": isEnable,
//     };
//
//     print(data);
//     String? pref_header = await prefs.getAccessToken();
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//     print(header);
//     print(APIPath.fetchProfile + "$doctorId/");
//     var response = await _dataProvider.performRequest(
//         "PATCH", APIPath.fetchProfile + "$doctorId/",
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
//   Future<bool> updateChamberAvailabilityStatus({
//     required String doctorId,
//     required String chamberId,
//   }) async {
//     bool _isSuccess = false;
//     dynamic data = {
//       "active_chamber_id": chamberId,
//     };
//
//     print(data);
//     String? pref_header = await prefs.getAccessToken();
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//     print(header);
//     print(APIPath.fetchProfile + "$doctorId/");
//     var response = await _dataProvider.performRequest(
//         "PATCH", APIPath.fetchProfile + "$doctorId/",
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
//   Future<bool> createPrescription({
//     required String name,
//     required String doctorId,
//     required String patientId,
//     required String prescriptionType,
//     required List<ComplaintData> complaintList,
//     required String historyProp1,
//     required List<InvestigationData> investigationList,
//     required List<DiagnosisData> diagnosisList,
//     required List<MedicationData> medicationList,
//     required List<AdviceData> adviceList,
//     required String followUpDate,
//   }) async {
//     bool _isSuccess = false;
//     String? pref_header = await prefs.getAccessToken();
//     dynamic header = {"Authorization": "Bearer $pref_header"};
//     dynamic data = {
//       "name": name,
//       "complaint": {
//         "textEditor": {"text": ""},
//         "items": complaintList
//       },
//       "investigation": {
//         "textEditor": {"text": ""},
//         "items": investigationList
//       },
//       "diagnosis": {
//         "textEditor": {"text": ""},
//         "items": diagnosisList
//       },
//       "medication": {
//         "textEditor": {"text": ""},
//         "items": [
//           {
//             "id": 67982,
//             "brand_name": "3-Geocef",
//             "power": "125mg",
//             "form": "Susp.",
//             "strength": "125mg",
//             "company_name": "Hallmark",
//             "generic_name": "Cefixime",
//             "instruction": null,
//             "food_relation": null,
//             "is_favourite": false,
//             "note": null,
//             "duration": null,
//             "sort_key": null,
//             "doctor": "9bee3acc-5368-47f4-8322-8d0567e1f37a",
//             "value": "",
//             "date": "",
//             "notes": "",
//             "isNew": false,
//             "isBlank": false
//           }
//         ]
//       },
//       "history": {
//         "drugs": [],
//         "family": [],
//         "investigation": [],
//         "medical": [
//           {
//             "id": "189eca58-6f27-407a-8ba9-d297e6937d86",
//             "name": "this is a test",
//             "durations": [
//               {"type": "since", "value": "", "unit": "days"}
//             ],
//             "value": "yes"
//           }
//         ],
//         "personal": [],
//         "surgery": []
//       },
//       "advice": {
//         "textEditor": {"text": ""},
//         "items": [
//           {
//             "id": "2d600566-093c-4d9f-8dd9-a0ef94bf7589",
//             "name": "AdviceDipto",
//             "is_favourite": true,
//             "score": 0,
//             "value": "",
//             "date": "",
//             "notes": "",
//             "isNew": false,
//             "isBlank": false
//           }
//         ]
//       },
//       "follow_up": {
//         "textEditor": {"text": ""},
//         "items": {"follow_up": followUpDate}
//       },
//       "prescription_type": prescriptionType,
//       "patient": patientId
//     };
//
//     var response = await _dataProvider.performRequest(
//         "POST", APIPath.createPrescription,
//         data: data, header: header);
//
//     if (response != null) {
//       if (response.statusCode == 201) {
//         _isSuccess = true;
//       } else {
//         _isSuccess = false;
//       }
//     } else {
//       _isSuccess = false;
//     }
//
//     return _isSuccess;
//   }
// }
