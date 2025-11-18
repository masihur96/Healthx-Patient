// import 'package:anuj_prokashon/features/e-book/data/model/ebook_response_model.dart';
// import 'package:anuj_prokashon/features/profile/data/models/order_response_model.dart';
// import 'package:anuj_prokashon/features/profile/data/models/wishlist_response_model.dart';
// import 'package:anuj_prokashon/features/profile/data/service/my_order_service.dart';
// import 'package:flutter/material.dart';
//
// class MyOrderViewModel extends ChangeNotifier {
//   final MyOrderService _myOrderService = MyOrderService();
//
//   OrderResponse? _orderResponseData;
//   MyEbookResponse? _myEbookResponseData;
//   WishlistResponse? _wishlistResponseData;
//   bool _isLoading = false;
//   bool _isLoadingMore = false;
//   String? _error;
//
//   // Pagination state
//   int _currentPage = 1;
//   int _pageSize = 10;
//   bool _hasMoreData = true;
//   List<Order> _allOrders = [];
//
//   // Search functionality
//   String _searchQuery = '';
//   bool _isSearching = false;
//
//   OrderResponse? get orderResponseData => _orderResponseData;
//   MyEbookResponse? get myEbookResponseData => _myEbookResponseData;
//   WishlistResponse? get wishlistResponseData => _wishlistResponseData;
//   List<Order> get allOrders => _allOrders;
//   bool get isLoading => _isLoading;
//   bool get isLoadingMore => _isLoadingMore;
//   String? get error => _error;
//   bool get hasMoreData => _hasMoreData;
//   int get currentPage => _currentPage;
//   String get searchQuery => _searchQuery;
//   bool get isSearching => _isSearching;
//
//   Future<void> fetchMyOrder({bool refresh = false, String? searchQuery}) async {
//     if (refresh) {
//       _currentPage = 1;
//       _allOrders.clear();
//       _hasMoreData = true;
//     }
//
//     // Update search query
//     if (searchQuery != null) {
//       _searchQuery = searchQuery;
//       _isSearching = searchQuery.isNotEmpty;
//     }
//
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//
//     try {
//       final data = await _myOrderService.getMyOrder(
//         page: _currentPage,
//         pageSize: _pageSize,
//         searchQuery: _isSearching ? _searchQuery : null,
//       );
//
//       if (data != null) {
//         if (refresh || _currentPage == 1) {
//           _orderResponseData = data;
//           _allOrders = List.from(data.data);
//         } else {
//           // Append new orders to existing list
//           _allOrders.addAll(data.data);
//           _orderResponseData = OrderResponse(
//             data: _allOrders,
//             meta: data.meta,
//           );
//         }
//
//         // Check if there are more pages
//         _hasMoreData = _currentPage < data.meta.pagination.pageCount;
//         _currentPage++;
//       } else {
//         _error = "Failed to fetch data";
//       }
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> loadMoreOrders() async {
//     if (_isLoadingMore || !_hasMoreData) return;
//
//     _isLoadingMore = true;
//     notifyListeners();
//
//     try {
//       final data = await _myOrderService.getMyOrder(
//         page: _currentPage,
//         pageSize: _pageSize,
//         searchQuery: _isSearching ? _searchQuery : null,
//       );
//
//       if (data != null && data.data.isNotEmpty) {
//         _allOrders.addAll(data.data);
//         _orderResponseData = OrderResponse(
//           data: _allOrders,
//           meta: data.meta,
//         );
//
//         _hasMoreData = _currentPage < data.meta.pagination.pageCount;
//         _currentPage++;
//       } else {
//         _hasMoreData = false;
//       }
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoadingMore = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> fetchMyEbook() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//
//     try {
//       final data = await _myOrderService.getMyEbook();
//       print("User Profile:: ${data.toString()}");
//       if (data != null) {
//         _myEbookResponseData = data;
//       } else {
//         _error = "Failed to fetch data";
//       }
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> fetchMyWishList() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//
//     try {
//       final data = await _myOrderService.getMyWishlist();
//       print("Wishlist Data:: ${data.toString()}");
//       if (data != null) {
//         _wishlistResponseData = data;
//       } else {
//         _error = "Failed to fetch data";
//       }
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<bool> deleteWishList({required String documentID}) async {
//     notifyListeners();
//     try {
//       final isSubmit =
//           await _myOrderService.deleteWishlist(documentId: documentID);
//
//       if (isSubmit) {
//         return true;
//       } else {
//         return false;
//         _error = "Failed to fetch home data";
//       }
//     } catch (e) {
//       return false;
//     } finally {
//       notifyListeners();
//     }
//   }
//
//   Future<bool> submitWishList({required String documentID}) async {
//     notifyListeners();
//     try {
//       final isSubmit =
//           await _myOrderService.addWishlist(documentId: documentID);
//
//       if (isSubmit) {
//         return true;
//       } else {
//         return false;
//         _error = "Failed to fetch home data";
//       }
//     } catch (e) {
//       return false;
//     } finally {
//       notifyListeners();
//     }
//   }
//
//   // Search functionality
//   Future<void> searchOrders(String query) async {
//     if (query.trim().isEmpty) {
//       clearSearch();
//       return;
//     }
//
//     _searchQuery = query.trim();
//     _isSearching = true;
//
//     // Reset pagination for new search
//     _currentPage = 1;
//     _allOrders.clear();
//     _hasMoreData = true;
//
//     await fetchMyOrder(refresh: true, searchQuery: _searchQuery);
//   }
//
//   void clearSearch() {
//     _searchQuery = '';
//     _isSearching = false;
//     _currentPage = 1;
//     _allOrders.clear();
//     _hasMoreData = true;
//     notifyListeners();
//   }
//
//   void clearError() {
//     _error = null;
//     notifyListeners();
//   }
// }
