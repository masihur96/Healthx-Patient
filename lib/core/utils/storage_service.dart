import 'dart:convert';

import 'package:healthx_patient/features/auth/data/models/auth_model.dart';
import 'package:healthx_patient/features/profile/data/models/profile_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _authKey = 'auth_data';
  static const String _userProfileKey = 'user_profile_data';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _bookmarksKey = 'bookmarks';

  // Save authentication data
  static Future<void> saveAuthData(AuthModel authModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authKey, jsonEncode(authModel.toJson()));
    await prefs.setBool(_isLoggedInKey, true);
  }

  //
  // Save authentication data
  static Future<void> saveUserProfileData(
      UserProfileResponse userProfile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userProfileKey, jsonEncode(userProfile.toJson()));
  }

  static Future<UserProfileResponse?> getUserProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = prefs.getString(_userProfileKey);
    if (userDataJson != null) {
      try {
        final userProfileMap = jsonDecode(userDataJson) as Map<String, dynamic>;
        return UserProfileResponse.fromJson(userProfileMap);
      } catch (e) {
        print('Error parsing auth data: $e');
        return null;
      }
    }
    return null;
  }

  // Get authentication data
  static Future<AuthModel?> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authJson = prefs.getString(_authKey);
    if (authJson != null) {
      try {
        final authMap = jsonDecode(authJson) as Map<String, dynamic>;
        return AuthModel.fromJson(authMap);
      } catch (e) {
        print('Error parsing auth data: $e');
        return null;
      }
    }
    return null;
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Clear authentication data (logout)
  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authKey);
    await prefs.remove(_userProfileKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  // Get user data
  static Future<UserModel?> getUserData() async {
    final authData = await getAuthData();
    return authData?.user;
  }

  // // Get JWT token
  // static Future<String?> getJwtToken() async {
  //   final authData = await getAuthData();
  //   return authData?.jwt;
  // }

  // Bookmark methods
  static Future<void> saveBookmarks(
      String bookId, List<Map<String, dynamic>> bookmarks) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${_bookmarksKey}_$bookId';
    await prefs.setString(key, jsonEncode(bookmarks));
  }

  static Future<List<Map<String, dynamic>>> getBookmarks(String bookId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${_bookmarksKey}_$bookId';
    final bookmarksJson = prefs.getString(key);
    if (bookmarksJson != null) {
      try {
        final List<dynamic> bookmarksList = jsonDecode(bookmarksJson);
        return bookmarksList.cast<Map<String, dynamic>>();
      } catch (e) {
        print('Error parsing bookmarks: $e');
        return [];
      }
    }
    return [];
  }

  static Future<void> addBookmark(
      String bookId, Map<String, dynamic> bookmark) async {
    final bookmarks = await getBookmarks(bookId);
    bookmarks.add(bookmark);
    await saveBookmarks(bookId, bookmarks);
  }

  static Future<void> updateBookmark(
      String bookId, int index, Map<String, dynamic> bookmark) async {
    final bookmarks = await getBookmarks(bookId);
    if (index >= 0 && index < bookmarks.length) {
      bookmarks[index] = bookmark;
      await saveBookmarks(bookId, bookmarks);
    }
  }

  static Future<void> deleteBookmark(String bookId, int index) async {
    final bookmarks = await getBookmarks(bookId);
    if (index >= 0 && index < bookmarks.length) {
      bookmarks.removeAt(index);
      await saveBookmarks(bookId, bookmarks);
    }
  }

  static Future<void> clearBookmarks(String bookId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${_bookmarksKey}_$bookId';
    await prefs.remove(key);
  }
}
