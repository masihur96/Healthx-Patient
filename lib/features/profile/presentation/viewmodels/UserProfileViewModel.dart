// import 'package:anuj_prokashon/core/utils/storage_service.dart';
// import 'package:anuj_prokashon/features/profile/data/models/country_model.dart';
// import 'package:anuj_prokashon/features/profile/data/models/division_model.dart';
// import 'package:anuj_prokashon/features/profile/data/models/profile_response_model.dart';
// import 'package:anuj_prokashon/features/profile/data/service/user_profile_service.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class UserProfileViewModel extends ChangeNotifier {
//   final UserProfileService _userProfileService = UserProfileService();
//
//   UserProfileResponse? _userProfileData;
//   CountryResponse? _countryResponseData;
//   DivisionResponse? _divisionResponseData;
//   bool _isLoading = false;
//   String? _error;
//   UserProfileResponse? get userProfileData => _userProfileData;
//   CountryResponse? get countryResponseData => _countryResponseData;
//   DivisionResponse? get divisionResponseData => _divisionResponseData;
//
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//
//   Future<void> fetchAndSaveUserProfile() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//
//     try {
//       final data = await _userProfileService.getUserProfileDetails();
//
//       if (data != null) {
//         _userProfileData = data;
//
//         await StorageService.saveUserProfileData(_userProfileData!);
//       } else {
//         _error = "Failed to fetch home data";
//       }
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> fetchCountries() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//
//     try {
//       final data = await _userProfileService.getCountries();
//       print("User Profile:: ${data.toString()}");
//       if (data != null) {
//         _countryResponseData = data;
//       } else {
//         _error = "Failed to fetch home data";
//       }
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> fetchDivisions({required String alpha3}) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//
//     try {
//       final data = await _userProfileService.getDivisions(alpha3: alpha3);
//       print("User Profile:: ${data.toString()}");
//       if (data != null) {
//         _divisionResponseData = data;
//       } else {
//         _error = "Failed to fetch home data";
//       }
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<bool> updateUserProfileAndSave(UserProfile userProfile) async {
//     _isLoading = true;
//     _error = null;
//
//     bool isSuccess = false;
//     notifyListeners();
//
//     try {
//       final data = await _userProfileService.updateUserProfileDetails(
//           userProfile: userProfile);
//       print("User Profile:: ${data.toString()}");
//       if (data != null) {
//         isSuccess = true;
//         fetchAndSaveUserProfile();
//       } else {
//         isSuccess = false;
//         _error = "Failed to fetch home data";
//       }
//     } catch (e) {
//       isSuccess = false;
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//     return isSuccess;
//   }
//
//   Future<bool> updateAvatar(XFile file) async {
//     _isLoading = true;
//     _error = null;
//
//     bool isSuccess = false;
//     notifyListeners();
//
//     try {
//       final data = await _userProfileService.updateUserAvatar(avatar: file);
//       print("User Profile:: ${data.toString()}");
//       if (data != null) {
//         isSuccess = true;
//         fetchAndSaveUserProfile();
//       } else {
//         isSuccess = false;
//         _error = "Failed to fetch home data";
//       }
//     } catch (e) {
//       isSuccess = false;
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//     return isSuccess;
//   }
//
//   void clearError() {
//     _error = null;
//     notifyListeners();
//   }
// }
