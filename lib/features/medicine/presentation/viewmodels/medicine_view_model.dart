// import 'package:flutter/material.dart';
// import 'package:medicare_doctor/features/medicine/data/models/health_plan_model.dart';
// import 'package:medicare_doctor/features/medicine/data/services/medicine_service.dart';
//
// class MedicineViewModel extends ChangeNotifier {
//   final MedicineService _medicineService = MedicineService();
//
//   List<DrugItem> _drugs = [];
//   List<DrugItem> _searchDrug = [];
//   bool _isLoading = false;
//   bool _isLoadingMore = false;
//   String? _error;
//   int _currentPage = 1;
//   int _pageSize = 20;
//   bool _hasMoreData = true;
//   bool _hasInitialData = false;
//
//   List<DrugItem> get drugs => _drugs;
//   List<DrugItem> get searchDrug => _searchDrug;
//   bool get isLoading => _isLoading;
//   bool get isLoadingMore => _isLoadingMore;
//   String? get error => _error;
//   bool get hasMoreData => _hasMoreData;
//   bool get hasInitialData => _hasInitialData;
//
//   Future<void> fetchMedicineData({bool forceRefresh = false}) async {
//     if (!forceRefresh && _hasInitialData) {
//       return;
//     }
//
//     _isLoading = true;
//     _error = null;
//     _currentPage = 1;
//     _hasMoreData = true;
//     _drugs.clear();
//     notifyListeners();
//
//     try {
//       final data = await _medicineService.getMedicineData(
//           page: _currentPage, pageSize: _pageSize);
//       if (data != null) {
//         _drugs = data.results;
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
//   Future<void> searchMedicine({required String query}) async {
//     _isLoading = true;
//     _error = null;
//
//     notifyListeners();
//
//     try {
//       final data = await _medicineService.searchMedicines(query: query);
//
//       if (data != null) {
//         _searchDrug = data.results;
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
//       final data = await _medicineService.getMedicineData(
//           page: _currentPage, pageSize: _pageSize);
//       if (data != null) {
//         _drugs.addAll(data.results);
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
//   void clearError() {
//     _error = null;
//     notifyListeners();
//   }
//
//   void clearSearchResults() {
//     _searchDrug = [];
//     _error = null;
//     notifyListeners();
//   }
// }
