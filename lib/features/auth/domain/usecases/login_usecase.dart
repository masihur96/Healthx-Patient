import 'package:healthx_patient/features/auth/data/models/auth_token_model.dart';

import '../../../../core/utils/result.dart';
import '../../data/services/auth_service.dart';

class LoginUseCase {
  final AuthService service;
  LoginUseCase(this.service);

  Future<Result<AuthTokenModel>> call(String email, String password) async {
    return await service.logIn(email: email, password: password);
  }
}

// class ProfileUseCase {
//   final AuthService service;
//   ProfileUseCase(this.service);
//
//   // Future<Result<User>> call(String accessToken) async {
//   //   return await service.getProfile(accessToken: accessToken);
//   // }
// }

// class CreateTokenUseCase {
//   final AuthService service;
//   CreateTokenUseCase(this.service);
//
//   Future<bool> call(String email) async {
//     return await service.createPasswordEmail(email);
//   }
// }

// class SetPasswordUseCase {
//   final AuthService service;
//   SetPasswordUseCase(this.service);
//
//   Future<bool> call(String token, String password) async {
//     return await service.setPasswordEmail(token, password);
//   }
// }
