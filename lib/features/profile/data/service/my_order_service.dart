// import 'package:anuj_prokashon/configs/network/data_provider.dart';
// import 'package:anuj_prokashon/core/constants/apis.dart';
// import 'package:anuj_prokashon/core/utils/storage_service.dart';
// import 'package:anuj_prokashon/features/auth/data/models/auth_model.dart';
// import 'package:anuj_prokashon/features/e-book/data/model/ebook_response_model.dart';
// import 'package:anuj_prokashon/features/profile/data/models/order_response_model.dart';
// import 'package:anuj_prokashon/features/profile/data/models/wishlist_response_model.dart';
//
// class MyOrderService {
//   final DataProvider _dataProvider = DataProvider();
//
//   Future<OrderResponse?> getMyOrder(
//       {int page = 1, int pageSize = 10, String? searchQuery}) async {
//     AuthModel? user = await StorageService.getAuthData();
//
//     if (user == null) {
//       return null;
//     }
//
//     final Map<String, dynamic> header = {"Authorization": "Bearer ${user.jwt}"};
//
//     final Map<String, dynamic> query = {
//       "page": page.toString(),
//       "pageSize": pageSize.toString(),
//     };
//
//     // Add search query if provided
//     if (searchQuery != null && searchQuery.isNotEmpty) {
//       query["search"] = searchQuery;
//     }
//
//     try {
//       final response = await _dataProvider.performRequest(
//         "GET",
//         APIPath.myOrders,
//         header: header,
//         query: query,
//       );
//
//       if (response != null && response.statusCode == 200) {
//         final data = response.data;
//         if (data is Map<String, dynamic>) {
//           return OrderResponse.fromJson(data);
//         } else {
//           print("Unexpected data format: ${data.runtimeType}");
//           return null;
//         }
//       } else {
//         print("Request failed with status: ${response?.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("Error fetching order data: $e");
//       return null;
//     }
//   }
//
//   Future<MyEbookResponse?> getMyEbook() async {
//     AuthModel? user = await StorageService.getAuthData();
//
//     if (user == null) {
//       return null;
//     }
//
//     final Map<String, dynamic> header = {"Authorization": "Bearer ${user.jwt}"};
//
//     final Map<String, dynamic> query = {"type": "EBOOK"};
//
//     try {
//       final response = await _dataProvider.performRequest(
//           "GET", APIPath.myOrderItems,
//           header: header, query: query);
//
//       if (response != null && response.statusCode == 200) {
//         final data = response.data;
//         if (data is Map<String, dynamic>) {
//           return MyEbookResponse.fromJson(data);
//         } else {
//           print("Unexpected data format: ${data.runtimeType}");
//           return null;
//         }
//       } else {
//         print("Request failed with status: ${response?.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("Error fetching home data: $e");
//       return null;
//     }
//   }
//
//   Future<WishlistResponse?> getMyWishlist() async {
//     // Fetching book data from the API
//
//     AuthModel? user = await StorageService.getAuthData();
//
//     if (user == null) {
//       return null;
//     }
//     final Map<String, dynamic> header = {"Authorization": "Bearer ${user.jwt}"};
//     print(header);
//     try {
//       final response = await _dataProvider.performRequest(
//         "GET",
//         APIPath.myWishlist,
//         header: header,
//       );
//
//       if (response != null && response.statusCode == 200) {
//         final data = response.data;
//         if (data is Map<String, dynamic>) {
//           return WishlistResponse.fromJson(data);
//         } else {
//           print("Unexpected data format: ${data.runtimeType}");
//           return null;
//         }
//       } else {
//         print("Request failed with status: ${response?.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("Error fetching home data: $e");
//       return null;
//     }
//   }
//
//   Future<bool> addWishlist({required String documentId}) async {
//     AuthModel? user = await StorageService.getAuthData();
//
//     if (user == null) {
//       return false;
//     }
//     final Map<String, dynamic> header = {"Authorization": "Bearer ${user.jwt}"};
//
//     final Map<String, dynamic> data = {"bookId": documentId};
//
//     print(header);
//     print(data);
//     try {
//       final response = await _dataProvider.performRequest(
//           "POST", APIPath.myWishlist,
//           data: data, header: header);
//       if (response != null && response.statusCode == 200) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print(e.toString());
//       return true;
//     }
//   }
//
//   Future<bool> deleteWishlist({required String documentId}) async {
//     AuthModel? user = await StorageService.getAuthData();
//
//     if (user == null) {
//       return false;
//     }
//     final Map<String, dynamic> header = {"Authorization": "Bearer ${user.jwt}"};
//
//     print("header:: $header");
//
//     try {
//       final response = await _dataProvider.performRequest(
//           "DELETE", "${APIPath.myWishlist}/$documentId",
//           header: header);
//
//       print("statusCode:: ${response!.statusCode}");
//
//       if (response != null && response.statusCode == 200) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print(e.toString());
//       return true;
//     }
//   }
// }
