import 'package:healthx_patient/core/constants/apis.dart';
import 'package:healthx_patient/features/auth/data/models/auth_error_model.dart';
import 'package:healthx_patient/features/auth/data/models/auth_model.dart';
import 'package:healthx_patient/features/auth/data/models/auth_token_model.dart';

import '../../../../configs/network/data_provider.dart';
import '../../../../core/utils/result.dart';

class AuthService {
  final DataProvider _dataProvider = DataProvider();

  Future<Result<bool>> registerUser(String fullName, String phone, String email,
      String bmdcNumber, String password) async {
    dynamic data = {
      "email": email.toLowerCase(),
      "firstname": fullName.trim().split(' ').isNotEmpty
          ? fullName.trim().split(' ').first
          : '',
      "lastname": fullName.trim().split(' ').length > 1
          ? fullName.trim().split(' ').sublist(1).join(' ')
          : '',
      "phone_number": phone,
      "password": password,
      "bmdc_number": bmdcNumber,
      "doctor_type": "medical",
    };

    print("Register Doctor Data:: $data");
    print("Register Doctor API:: ${APIPath.register}");

    try {
      var response = await _dataProvider
          .performRequest("POST", APIPath.register, data: data);
      print("Register Doctor response:: $response");

      if (response != null) {
        print("Register Doctor response:: ${response.statusCode}");
        if (response.statusCode == 201) {
          // Registration successful and returns user data
          return const Success(true);
        } else {
          // Handle error response - parse field-specific errors
          if (response.data != null && response.data is Map) {
            // Build a user-friendly error message from field errors
            List<String> errorMessages = [];
            response.data.forEach((key, value) {
              if (value is List && value.isNotEmpty) {
                String fieldName = key.toString().replaceAll('_', ' ');
                String capitalizedFieldName = fieldName.isEmpty
                    ? fieldName
                    : fieldName[0].toUpperCase() + fieldName.substring(1);
                errorMessages.add('$capitalizedFieldName: ${value.first}');
              }
            });

            if (errorMessages.isNotEmpty) {
              return Error(errorMessages.join('\n'));
            }
          }
          return const Error("Registration failed. Please try again.");
        }
      } else {
        return const Error("Network error occurred");
      }
    } catch (e) {
      return Error("An unexpected error occurred: ${e.toString()}");
    }
  }

  // Future<bool> verifyEmail(String email, String code) async {
  //   dynamic data = {
  //     "email": email.toLowerCase(),
  //     "token": code,
  //   };
  //
  //   print("verify email Data:: $data");
  //   print("verify email API:: ${APIPath.verifyAccount}");
  //
  //   try {
  //     var response = await _dataProvider
  //         .performRequest("POST", APIPath.verifyAccount, data: data);
  //     print("verify email response:: $response");
  //
  //     if (response != null) {
  //       print("verify email response:: ${response.statusCode}");
  //       if (response.statusCode == 200) {
  //         // Registration successful and returns user data
  //         return true;
  //       } else {
  //         // Handle error response
  //         return false;
  //       }
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future<bool> createPasswordEmail(String email) async {
  //   dynamic data = {
  //     "email": email.toLowerCase(),
  //   };
  //
  //   print("initiatePasswordReset Data:: $data");
  //   print("initiatePasswordReset API:: ${APIPath.verifyAccount}");
  //
  //   try {
  //     var response = await _dataProvider
  //         .performRequest("POST", APIPath.initiatePasswordReset, data: data);
  //     print("initiatePasswordReset response:: $response");
  //
  //     if (response != null) {
  //       print("initiatePasswordReset response:: ${response.statusCode}");
  //       if (response.statusCode == 200) {
  //         // Registration successful and returns user data
  //         return true;
  //       } else {
  //         // Handle error response
  //         return false;
  //       }
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }
  //
  // Future<bool> setPasswordEmail(String token, String password) async {
  //   dynamic data = {
  //     "token": token,
  //     "new_password": password,
  //   };
  //
  //   print("initiatePasswordReset Data:: $data");
  //   print("initiatePasswordReset API:: ${APIPath.verifyAccount}");
  //
  //   try {
  //     var response = await _dataProvider
  //         .performRequest("POST", APIPath.createNewPassword, data: data);
  //     print("initiatePasswordReset response:: $response");
  //
  //     if (response != null) {
  //       print("initiatePasswordReset response:: ${response.statusCode}");
  //       if (response.statusCode == 200) {
  //         // Registration successful and returns user data
  //         return true;
  //       } else {
  //         // Handle error response
  //         return false;
  //       }
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }
  //
  // Future<bool> resendEmail(String email) async {
  //   print("resendEmail email: $email");
  //   dynamic data = {
  //     "email": email.toLowerCase(),
  //   };
  //
  //   print("Resend email Data:: $data");
  //   print("Resend email API:: ${APIPath.verifyAccount}");
  //
  //   try {
  //     var response = await _dataProvider
  //         .performRequest("POST", APIPath.resendVerification, data: data);
  //     print("Resend email response:: $response");
  //
  //     if (response != null) {
  //       print("Resend email response:: ${response.statusCode}");
  //       if (response.statusCode == 200) {
  //         // Registration successful and returns user data
  //         return true;
  //       } else {
  //         // Handle error response
  //         return false;
  //       }
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }
  //
  // Future<Result<AuthModel>> registerWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //     if (googleUser == null) {
  //       print("googleUser");
  //       return const Error("Registration failed", statusCode: 500);
  //     }
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //
  //     dynamic query = {
  //       "access_token": googleAuth.accessToken,
  //     };
  //
  //     print("googleAuth.accessToken::${googleAuth.accessToken}");
  //
  //     try {
  //       var response = await _dataProvider
  //           .performRequest("GET", APIPath.registerWithGoogle, query: query);
  //
  //       if (response != null) {
  //         if (response.statusCode == 200) {
  //           // Registration successful and returns user data
  //           try {
  //             dynamic responseData = response.data;
  //             AuthModel authModel = AuthModel.fromJson(responseData);
  //
  //             await StorageService.saveAuthData(authModel);
  //
  //             return Success(authModel, statusCode: 200);
  //           } catch (e) {
  //             return Error(
  //                 "Failed to parse registration response: ${e.toString()}",
  //                 statusCode: 400);
  //           }
  //         } else {
  //           // Handle error response
  //           if (response.data != null && response.data['error'] != null) {
  //             AuthErrorModel errorModel =
  //                 AuthErrorModel.fromJson(response.data['error']);
  //             return Error(errorModel.message, statusCode: 400);
  //           } else {
  //             return const Error("Registration failed", statusCode: 400);
  //           }
  //         }
  //       } else {
  //         return const Error("Network error occurred");
  //       }
  //     } catch (e) {
  //       return Error("An unexpected error occurred: ${e.toString()}");
  //     }
  //     // final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken,idToken: googleAuth.idToken);
  //     //
  //     // return await FirebaseAuth.instance.signInWithCredential(credential);
  //   } catch (e) {
  //     return Error("Registration failed with ${e.toString()}");
  //   }
  // }

  Future<Result<AuthTokenModel>> logIn({
    required String email,
    required String password,
  }) async {
    dynamic data = {
      "username": email.toLowerCase(),
      "password": password,
    };

    try {
      var response =
          await _dataProvider.performRequest("POST", APIPath.login, data: data);

      if (response != null) {
        if (response.statusCode == 200) {
          try {
            dynamic responseData = response.data;
            AuthTokenModel authModel = AuthTokenModel.fromJson(responseData);
            return Success(authModel);
          } catch (e) {
            return Error("Failed to parse login response: ${e.toString()}");
          }
        } else {
          // Handle login error response
          if (response.data != null && response.data['error'] != null) {
            AuthErrorModel errorModel =
                AuthErrorModel.fromJson(response.data['error']);
            return Error(errorModel.message);
          } else {
            return const Error("Login failed");
          }
        }
      } else {
        return const Error("Network error occurred");
      }
    } catch (e) {
      return Error("An unexpected error occurred: ${e.toString()}");
    }
  }

  Future<Result<AuthModel>> getProfile({
    required String accessToken,
  }) async {
    dynamic header = {"Authorization": "Bearer $accessToken"};

    try {
      var response = await _dataProvider
          .performRequest("GET", APIPath.myProfile, header: header);
      if (response != null) {
        if (response.statusCode == 200) {
          try {
            dynamic responseData = response.data;
            AuthModel profileModel = AuthModel.fromJson(responseData);
            return Success(profileModel);
          } catch (e) {
            return Error("Failed to parse login response: ${e.toString()}");
          }
        } else {
          // Handle login error response
          if (response.data != null && response.data['error'] != null) {
            AuthErrorModel errorModel =
                AuthErrorModel.fromJson(response.data['error']);
            return Error(errorModel.message);
          } else {
            return const Error("Profile failed");
          }
        }
      } else {
        return const Error("Network error occurred");
      }
    } catch (e) {
      return Error("An unexpected error occurred: ${e.toString()}");
    }
  }

  Future<Result<bool>> forgotPassword(String email) async {
    dynamic data = {
      "email": email.toLowerCase(),
    };

    try {
      var response = await _dataProvider
          .performRequest("POST", APIPath.changePassword, data: data);

      if (response != null) {
        if (response.statusCode == 200) {
          return const Success(true);
        } else {
          // Handle error response
          if (response.data != null && response.data['error'] != null) {
            AuthErrorModel errorModel =
                AuthErrorModel.fromJson(response.data['error']);
            return Error(errorModel.message);
          } else {
            return const Error("Password reset request failed");
          }
        }
      } else {
        return const Error("Network error occurred");
      }
    } catch (e) {
      return Error("An unexpected error occurred: ${e.toString()}");
    }
  }

  Future<Result<bool>> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
    required String code,
    required String userType,
  }) async {
    dynamic data = {
      "password": password,
      "confirmPassword": confirmPassword,
      "code": code,
      "userType": userType,
      "email": email.toLowerCase(),
    };

    try {
      var response = await _dataProvider
          .performRequest("POST", APIPath.resetPassword, data: data);

      if (response != null) {
        if (response.statusCode == 200) {
          return const Success(true);
        } else {
          // Handle error response
          if (response.data != null && response.data['error'] != null) {
            AuthErrorModel errorModel =
                AuthErrorModel.fromJson(response.data['error']);
            return Error(errorModel.message);
          } else {
            return const Error("Password reset failed");
          }
        }
      } else {
        return const Error("Network error occurred");
      }
    } catch (e) {
      return Error("An unexpected error occurred: ${e.toString()}");
    }
  }

  // Future<bool> changePassword({
  //   required String currentPassword,
  //   required String newPassword,
  //   required String confirmPassword,
  // }) async {
  //   AuthTokenModel? authTokenModel = await StorageService.getAuthData();
  //
  //   if (authTokenModel == null) {
  //     return false;
  //   }
  //   final Map<String, dynamic> header = {
  //     "Authorization": "Bearer ${authTokenModel.access}"
  //   };
  //
  //   dynamic data = {
  //     "currentPassword": currentPassword,
  //     "newPassword": newPassword,
  //     "confirmNewPassword": confirmPassword,
  //   };
  //
  //   try {
  //     var response = await _dataProvider.performRequest(
  //         "POST", APIPath.changePassword,
  //         data: data, header: header);
  //
  //     if (response != null) {
  //       if (response.statusCode == 200) {
  //         return true;
  //       } else {
  //         // Handle error response
  //         if (response.data != null && response.data['error'] != null) {
  //           AuthErrorModel errorModel =
  //               AuthErrorModel.fromJson(response.data['error']);
  //           return false;
  //         } else {
  //           return false;
  //         }
  //       }
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
