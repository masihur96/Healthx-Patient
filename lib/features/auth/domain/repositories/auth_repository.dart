// import 'dart:developer';
//
// import 'package:readify/configs/network/data_provider.dart';
// import 'package:readify/core/constants/apis.dart';
//
//
// class AuthRepository {
//   final DataProvider _dataProvider = DataProvider();
//
//
//   Future<void> logIn({
//     required String email,
//     required String password,
//   }) async {
//
//     dynamic data = {
//       "email": email.toLowerCase(),
//       "password": password,
//     };
//
//     var response =
//         await _dataProvider.performRequest("POST", APIPath.Login, data: data);
//       if (response != null) {
//         if (response.statusCode == 200) {
//           try {
//             var data = response.data["data"];
//
//           } catch (err, stackTrace) {
//             print(err);
//             print(stackTrace);
//
//           }
//         } else if (response.statusCode == 201) {
//           try {
//             var data = response.data["data"];
//
//           } catch (exception, stackTrace) {
//
//             log(exception.toString());
//           }
//         }
//       }
//   }
//
// }
