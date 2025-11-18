import 'package:healthx_patient/core/utils/result.dart';

import '../../data/services/auth_service.dart';

class RegisterUseCase {
  final AuthService service;
  RegisterUseCase(this.service);

  Future<Result<bool>> call(String fullName, String phone, String email,
      String bmdcNumber, String password) async {
    return await service.registerUser(
        fullName, phone, email, bmdcNumber, password);
  }
}

// class VerifyUseCase {
//   final AuthService service;
//   VerifyUseCase(this.service);
//
//   Future<bool> call(String email, String code) async {
//     return await service.verifyEmail(email, code);
//   }
// }
//
// class ResendUseCase {
//   final AuthService service;
//   ResendUseCase(this.service);
//
//   Future<bool> call(String email) async {
//     return await service.resendEmail(email);
//   }
// }
