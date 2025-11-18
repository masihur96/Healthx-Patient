import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healthx_patient/core/utils/storage_service.dart';
import 'package:healthx_patient/features/auth/data/models/auth_model.dart';
import 'package:healthx_patient/features/auth/data/models/auth_token_model.dart';
import 'package:healthx_patient/features/auth/data/services/auth_service.dart';
import 'package:healthx_patient/features/auth/domain/usecases/login_usecase.dart';

import '../../../../core/utils/result.dart';

class AuthViewModel extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  // final ProfileUseCase profileUseCase;
  // // final CreateTokenUseCase createTokenUseCase;
  // // final SetPasswordUseCase setPasswordUseCase;
  // final RegisterUseCase registerUseCase;
  // // final ResendUseCase resendUseCase;
  // // final VerifyUseCase verifyUseCase;
  final AuthService authService;

  AuthTokenModel? authTokenModel;
  UserModel? profileModel;
  String? error;
  bool isLoading = false;
  bool isLoggedIn = false;

  bool? isRegistered = false;

  AuthViewModel(
      this.loginUseCase,
      // this.profileUseCase,
      // // this.createTokenUseCase,
      // // this.setPasswordUseCase,
      // this.registerUseCase,
      // // this.verifyUseCase,
      // // this.resendUseCase,
      this.authService) {
    _initializeAuthState();
  }

  // Initialize auth state from SharedPreferences
  Future<void> _initializeAuthState() async {
    isLoggedIn = await StorageService.isLoggedIn();
    if (isLoggedIn) {
      // authTokenModel = await StorageService.getAuthData();
    }
    notifyListeners();
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      isLoading = true;
      error = null; // Clear previous errors
      notifyListeners();

      Result<AuthTokenModel> result = await loginUseCase(email, password);

      if (result.isSuccess) {
        authTokenModel = result.data;
        // Save to SharedPreferences
        if (authTokenModel != null) {
          // await StorageService.saveAuthData(authTokenModel!);
          // fetchProfile(accessToken: authTokenModel!.access);
        }

        isLoggedIn = true;
        return true;
      } else {
        error = result.error;
        return false;
      }
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Future<bool> fetchProfile({required String accessToken}) async {
  //   print("Access Token:: $accessToken");
  //   try {
  //     isLoading = true;
  //     error = null; // Clear previous errors
  //     notifyListeners();
  //
  //     Result<UserModel> result = await profileUseCase(accessToken);
  //
  //     if (result.isSuccess) {
  //       profileModel = result.data;
  //       // Save to SharedPreferences
  //       isLoggedIn = true;
  //       return true;
  //     } else {
  //       error = result.error;
  //       return false;
  //     }
  //   } catch (e) {
  //     error = e.toString();
  //     return false;
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<bool> createPasswordToken({required String email}) async {
  //   try {
  //     isLoading = true;
  //     error = null; // Clear previous errors
  //     notifyListeners();
  //
  //     bool isSuccess = await createTokenUseCase(email);
  //
  //     if (isSuccess) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     error = e.toString();
  //     return false;
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<bool> setPasswordWithToken(
  //     {required String token, required String newPassword}) async {
  //   try {
  //     isLoading = true;
  //     error = null; // Clear previous errors
  //     notifyListeners();
  //
  //     bool isSuccess = await setPasswordUseCase(token, newPassword);
  //
  //     if (isSuccess) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     error = e.toString();
  //     return false;
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }
  //
  // Future<bool> register(
  //     {required String fullName,
  //     required String phone,
  //     required String email,
  //     required String bmdcNumber,
  //     required String password}) async {
  //   try {
  //     isLoading = true;
  //     error = null; // Clear previous errors
  //     notifyListeners();
  //
  //     Result<bool> result =
  //         await registerUseCase(fullName, phone, email, bmdcNumber, password);
  //
  //     if (result.isSuccess) {
  //       return true;
  //     } else {
  //       error = result.error;
  //       return false;
  //     }
  //   } catch (e) {
  //     error = e.toString();
  //     return false;
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }
  //
  // Future<bool> verifyEmail({
  //   required String email,
  //   required String code,
  // }) async {
  //   try {
  //     isLoading = true;
  //     notifyListeners();
  //
  //     bool isSuccess = await verifyUseCase(email, code);
  //
  //     if (isSuccess) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     error = e.toString();
  //     return false;
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }
  //
  // Future<bool> resendCode({required String email}) async {
  //   try {
  //     isLoading = true;
  //     notifyListeners();
  //     print("resendCode email: $email");
  //     bool isSuccess = await resendUseCase(email);
  //
  //     if (isSuccess) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     error = e.toString();
  //     return false;
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }
  // Future<int?> googleSignIn() async {
  //   // final GoogleSignIn _googleSignIn = GoogleSignIn();
  //   // // await _googleSignIn.disconnect();
  //   try {
  //     isLoading = true;
  //     error = null; // Clear previous errors
  //     notifyListeners();
  //
  //     Result<AuthModel> result = await authService.registerWithGoogle();
  //
  //     if (result.isSuccess) {
  //       user = result.data;
  //       isLoggedIn = true;
  //
  //       return result.statusCode;
  //     } else {
  //       error = result.error;
  //       return result.statusCode;
  //     }
  //   } catch (e) {
  //     error = e.toString();
  //     return 500;
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> googleSignOut() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      await _googleSignIn.signOut();

      print("User signed out from Google account");
    } catch (error) {
      print("Error signing out: $error");
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      isLoading = true;
      error = null; // Clear previous errors
      notifyListeners();

      Result<bool> result = await authService.forgotPassword(email);

      if (result.isSuccess) {
        return true;
      } else {
        error = result.error;
        return false;
      }
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
    required String code,
    required String userType,
  }) async {
    try {
      isLoading = true;
      error = null; // Clear previous errors
      notifyListeners();

      Result<bool> result = await authService.resetPassword(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        code: code,
        userType: userType,
      );

      if (result.isSuccess) {
        return true;
      } else {
        error = result.error;
        return false;
      }
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> logout() async {
  //   user = null;
  //   error = null;
  //   isLoggedIn = false;
  //   googleSignOut();
  //   // Clear from SharedPreferences
  //   await StorageService.clearAuthData();
  //   notifyListeners();
  // }

  // Check if user is logged in
  bool get isUserLoggedIn => isLoggedIn;
}
