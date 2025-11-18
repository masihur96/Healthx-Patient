// import 'package:flutter/material.dart';
// import 'package:medicare_doctor/features/patient/data/models/patient_model.dart';
// import 'package:medicare_doctor/features/patient/data/services/patient_service.dart';
//
// class PatientViewModel extends ChangeNotifier {
//   final PatientService _patientService = PatientService();
//
//   List<PatientItem> _patients = [];
//   List<PatientItem> _searchPatient = [];
//   bool _isLoading = false;
//   bool _isLoadingMore = false;
//   String? _error;
//   int _currentPage = 1;
//   int _pageSize = 10;
//   bool _hasMoreData = true;
//   bool _hasInitialData = false;
//
//   List<PatientItem> get patients => _patients;
//   List<PatientItem> get searchPatient => _searchPatient;
//   bool get isLoading => _isLoading;
//   bool get isLoadingMore => _isLoadingMore;
//   String? get error => _error;
//   bool get hasMoreData => _hasMoreData;
//   bool get hasInitialData => _hasInitialData;
//
//   Future<void> fetchPatientListData({bool forceRefresh = false}) async {
//     if (!forceRefresh && _hasInitialData) {
//       return;
//     }
//
//     _isLoading = true;
//     _error = null;
//     _currentPage = 1;
//     _hasMoreData = true;
//     _patients.clear();
//     notifyListeners();
//
//     try {
//       final data = await _patientService.getPatientListData(
//           page: _currentPage, pageSize: _pageSize);
//       if (data != null) {
//         _patients = data.results;
//         _hasMoreData = _currentPage < data.totalPages;
//         _hasInitialData = true;
//       } else {
//         _error = "Failed to fetch medicine data";
//       }
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> searchPatientData({required String query}) async {
//     _isLoading = true;
//     _error = null;
//
//     notifyListeners();
//
//     try {
//       final data = await _patientService.searchPatient(query: query);
//
//       if (data != null) {
//         _searchPatient = data.results;
//         _error = null;
//       } else {
//         _error = "No medicine found";
//       }
//     } catch (e) {
//       print("Error searching medicine: $e");
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> loadMoreAuthors() async {
//     if (_isLoadingMore || !_hasMoreData) return;
//
//     _isLoadingMore = true;
//     notifyListeners();
//
//     try {
//       _currentPage++;
//       final data = await _patientService.getPatientListData(
//           page: _currentPage, pageSize: _pageSize);
//       if (data != null) {
//         _patients.addAll(data.results);
//         _hasMoreData = _currentPage < data.totalPages;
//       } else {
//         _currentPage--; // Revert page increment on failure
//         _error = "Failed to load more medicines";
//       }
//     } catch (e) {
//       _currentPage--; // Revert page increment on failure
//       _error = e.toString();
//     } finally {
//       _isLoadingMore = false;
//       notifyListeners();
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
//     try {
//       _isLoading = true;
//       notifyListeners();
//
//       final isSuccess = await _patientService.registerPatient(
//           fullName: fullName,
//           phone: phone,
//           email: email,
//           gender: gender,
//           age: age,
//           dob: dob);
//
//       if (isSuccess) {
//         fetchPatientListData(forceRefresh: true);
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       _error = e.toString();
//       return false;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   void clearError() {
//     _error = null;
//     notifyListeners();
//   }
//
//   void clearSearchResults() {
//     _searchPatient = [];
//     _error = null;
//     notifyListeners();
//   }
// }
