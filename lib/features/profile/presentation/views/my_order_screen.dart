import 'package:flutter/material.dart';
import 'package:healthx_patient/core/utils/storage_service.dart';
import 'package:healthx_patient/features/profile/data/models/order_response_model.dart';
import 'package:healthx_patient/features/profile/data/models/profile_response_model.dart';
import 'package:healthx_patient/shared/providers/language_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  final TextEditingController _reviewController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  UserProfile? userProfile;
  bool _isFetched = false;
  int _selectedRating = 0;
  // Track which orders are expanded
  final Set<int> _expandedOrders = <int>{};
  bool _isSearchVisible = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Load more when user is 200 pixels from bottom
      // context.read<MyOrderViewModel>().loadMoreOrders();
    }
  }

  Future<void> _loadUser() async {
    final userProfileResponse = await StorageService.getUserProfileData();
    if (userProfileResponse != null) {
      setState(() {
        userProfile = userProfileResponse.data;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isFetched) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // context.read<MyOrderViewModel>().fetchMyOrder(refresh: true);
      });
      _isFetched = true;
    }
  }
  //
  // void _submitReview(OrderBook book, MyOrderViewModel bookVM) async {
  //   if (_reviewController.text.isEmpty) {
  //     AppSnackBar.show(
  //       context,
  //       message: "Please type your Review.",
  //     );
  //
  //     return;
  //   }
  //
  //   final isSuccess = await bookVM.submitBookReviews(
  //     bookId: book.documentId,
  //     content: _reviewController.text,
  //     rating: _selectedRating,
  //   );
  //
  //   if (isSuccess) {
  //
  //     AppSnackBar.show(
  //       context,
  //       message: "Thanks for rating $_selectedRating stars!",
  //     );
  //
  //   }
  //
  //   Navigator.pop(context);
  // }

  void _toggleOrderExpansion(int orderId) {
    setState(() {
      if (_expandedOrders.contains(orderId)) {
        _expandedOrders.remove(orderId);
      } else {
        _expandedOrders.add(orderId);
      }
    });
  }

  Future<void> _onRefresh() async {
    // final orderVM = context.read<MyOrderViewModel>();
    // if (orderVM.isSearching) {
    //   await orderVM.searchOrders(orderVM.searchQuery);
    // } else {
    //   await orderVM.fetchMyOrder(refresh: true);
    // }
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (!_isSearchVisible) {
        _searchController.clear();
        //    context.read<MyOrderViewModel>().clearSearch();

        _onRefresh();
      }
    });
  }

  void _onSearchChanged(String query) async {
    if (query.trim().isEmpty) {
      //     context.read<MyOrderViewModel>().clearSearch();
      return;
    }

    // Debounce search to avoid too many API calls
    await Future.delayed(const Duration(milliseconds: 500));
    if (_searchController.text.trim() == query.trim()) {
      //  await context.read<MyOrderViewModel>().searchOrders(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: const Icon(Icons.arrow_back_ios),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          languageProvider.isBangla ? "আমার অর্ডারসমূহ" : "My Orders",
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isSearchVisible ? Icons.close : Icons.search_outlined,
              color: Colors.black87,
            ),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          if (_isSearchVisible)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: languageProvider.isBangla
                      ? "অর্ডার, বইয়ের নাম বা স্ট্যাটাস অনুসন্ধান করুন..."
                      : "Search orders, book names, or status...",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _searchController.clear();
                            //  context.read<MyOrderViewModel>().clearSearch();
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),

          // Orders list
          // Expanded(
          //   child: Consumer<MyOrderViewModel>(
          //     builder: (context, orderVM, _) {
          //       if (orderVM.isLoading && orderVM.allOrders.isEmpty) {
          //         return OrdersShimmerScreen();
          //       }
          //
          //       if (orderVM.error != null && orderVM.allOrders.isEmpty) {
          //         return _buildErrorState(orderVM);
          //       }
          //
          //       final orders = orderVM.allOrders;
          //       if (orders.isEmpty) {
          //         return _buildEmptyState(
          //             languageProvider, orderVM.isSearching);
          //       }
          //
          //       return RefreshIndicator(
          //         onRefresh: _onRefresh,
          //         child: ListView.builder(
          //           controller: _scrollController,
          //           padding: const EdgeInsets.all(16),
          //           itemCount: orders.length + (orderVM.hasMoreData ? 1 : 0),
          //           itemBuilder: (context, index) {
          //             if (index == orders.length) {
          //               // Show loading indicator at the bottom
          //               return _buildLoadMoreIndicator(orderVM);
          //             }
          //
          //             final order = orders[index];
          //             return _buildOrderCard(order, languageProvider, theme);
          //           },
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  // Widget _buildLoadMoreIndicator(MyOrderViewModel orderVM) {
  //   if (orderVM.isLoadingMore) {
  //     return const Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Center(
  //         child: CircularProgressIndicator(),
  //       ),
  //     );
  //   }
  //
  //   if (!orderVM.hasMoreData) {
  //     return const Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Center(
  //         child: Text(
  //           'No more orders to load',
  //           style: TextStyle(
  //             color: Colors.grey,
  //             fontSize: 14,
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //
  //   return const SizedBox.shrink();
  // }

  Widget _buildOrderCard(
      Order order, LanguageProvider languageProvider, ThemeData theme) {
    final isExpanded = _expandedOrders.contains(order.id);
    final hasMultipleBooks = order.orderItems.length > 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderHeader(order, theme),
          _buildOrderDetails(order, languageProvider),
          _buildOrderItems(
              order, languageProvider, isExpanded, hasMultipleBooks),
        ],
      ),
    );
  }

  Widget _buildOrderHeader(Order order, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '৳${order.totalAmount.toStringAsFixed(0)} ${order.currency}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Order #${order.transactionId}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          _buildStatusChip(order.orderStatus),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (status.toUpperCase()) {
      case 'DELIVERED':
        backgroundColor = const Color(0xFFE8F5E8);
        textColor = const Color(0xFF2E7D32);
        icon = Icons.check_circle;
        break;
      case 'PENDING':
        backgroundColor = const Color(0xFFFFF3E0);
        textColor = const Color(0xFFF57C00);
        icon = Icons.schedule;
        break;
      case 'PROCESSING':
        backgroundColor = const Color(0xFFE3F2FD);
        textColor = const Color(0xFF1976D2);
        icon = Icons.autorenew;
        break;
      case 'CANCELLED':
        backgroundColor = const Color(0xFFFFEBEE);
        textColor = const Color(0xFFD32F2F);
        icon = Icons.cancel;
        break;
      default:
        backgroundColor = const Color(0xFFF5F5F5);
        textColor = const Color(0xFF757575);
        icon = Icons.help;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails(Order order, LanguageProvider languageProvider) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                'Order Date: ${DateFormat('MMM dd, yyyy • hh:mm a').format(DateTime.parse(order.createdAt))}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.payment, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                'Payment: ${order.paymentStatus}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItems(Order order, LanguageProvider languageProvider,
      bool isExpanded, bool hasMultipleBooks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Row(
            children: [
              Icon(Icons.menu_book, size: 18, color: Colors.grey[700]),
              const SizedBox(width: 8),
              Text(
                languageProvider.isBangla ? 'বইসমূহ' : 'Books',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${order.orderItems.length} ${languageProvider.isBangla ? 'টি' : 'items'}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Show books based on expansion state
        if (isExpanded || !hasMultipleBooks)
          ...order.orderItems
              .map((item) => _buildBookItem(item, languageProvider))
        else
          _buildBookItem(order.orderItems.first, languageProvider),

        // Show expand/collapse button if there are multiple books
        if (hasMultipleBooks)
          _buildExpandButton(order, languageProvider, isExpanded),
      ],
    );
  }

  Widget _buildExpandButton(
      Order order, LanguageProvider languageProvider, bool isExpanded) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: GestureDetector(
        onTap: () => _toggleOrderExpansion(order.id),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isExpanded
                    ? (languageProvider.isBangla ? 'কম দেখান' : 'Show Less')
                    : (languageProvider.isBangla
                        ? 'আরও ${order.orderItems.length - 1}টি বই দেখান'
                        : 'Show ${order.orderItems.length - 1} More Books'),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(width: 8),
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey[600],
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookItem(OrderItem item, LanguageProvider languageProvider) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Row(
        children: [
          _buildBookImage(item.book),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.book.nameBN,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '৳${item.price.toStringAsFixed(0)} ${item.currency}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Qty: ${item.quantity}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Total: ৳${(item.price * item.quantity).toStringAsFixed(0)} ${item.currency}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookImage(OrderBook book) {
    return Container(
      width: 60,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          book.image?.url ?? '',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: const Color(0xFFF0F0F0),
            child: const Icon(
              Icons.book,
              color: Color(0xFF9E9E9E),
              size: 30,
            ),
          ),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: const Color(0xFFF0F0F0),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9E9E9E)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(LanguageProvider languageProvider, bool isSearching) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Icon(
                isSearching ? Icons.search_off : Icons.shopping_bag_outlined,
                size: 60,
                color: const Color(0xFF9E9E9E),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isSearching
                  ? (languageProvider.isBangla
                      ? "কোনো ফলাফল পাওয়া যায়নি"
                      : "No Results Found")
                  : (languageProvider.isBangla
                      ? "কোনো অর্ডার পাওয়া যায়নি"
                      : "No Orders Found"),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isSearching
                  ? (languageProvider.isBangla
                      ? "আপনার অনুসন্ধানের সাথে মিলে যায় এমন কোনো অর্ডার পাওয়া যায়নি"
                      : "No orders match your search criteria")
                  : (languageProvider.isBangla
                      ? "আপনার অর্ডার ইতিহাস এখানে দেখানো হবে"
                      : "Your order history will appear here"),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            if (isSearching) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _searchController.clear();
                  // context.read<MyOrderViewModel>().clearSearch();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  languageProvider.isBangla
                      ? "সব অর্ডার দেখান"
                      : "Show All Orders",
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // void _showReviewDialog(OrderBook book, MyOrderViewModel orderVM) {
  //   _reviewController.clear();
  //   _selectedRating = 0;
  //
  //   showDialog(
  //     barrierDismissible: true,
  //     context: context,
  //     builder: (_) {
  //       return BounchingDialog(
  //         width: screenSize(context, 0.6),
  //         height: screenSize(context, .8),
  //         child: StatefulBuilder(
  //           builder: (context, setState) {
  //             return Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 20),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const SizedBox(height: 12),
  //                   Row(
  //                     children: List.generate(5, (index) {
  //                       return IconButton(
  //                         icon: Icon(
  //                           index < _selectedRating ? Icons.star : Icons.star_border,
  //                           color: Colors.amber,
  //                           size: 32,
  //                         ),
  //                         onPressed: () {
  //                           setState(() {
  //                             _selectedRating = index + 1;
  //                           });
  //                         },
  //                       );
  //                     }),
  //                   ),
  //                   const SizedBox(height: 8),
  //                   Text(
  //                     "Let everyone know your opinion about this book",
  //                     style: Theme.of(context)
  //                         .textTheme
  //                         .bodyMedium
  //                         ?.copyWith(color: Colors.grey[600]),
  //                   ),
  //                   const SizedBox(height: 10),
  //                   if (_selectedRating > 0)
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.end,
  //                       children: [
  //                         TextFormField(
  //                           controller: _reviewController,
  //                           decoration: InputDecoration(
  //                             labelText: "Review",
  //                             prefixIcon: const Icon(Icons.text_fields_outlined),
  //                             border: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(12),
  //                             ),
  //                           ),
  //                         ),
  //                         const SizedBox(height: 7),
  //                         ElevatedButton(
  //                           onPressed: () => _submitReview(book, orderVM),
  //                           child: const Text("Submit Review"),
  //                         ),
  //                       ],
  //                     ),
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget _buildErrorState(MyOrderViewModel orderVM) {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(userProfile == null
  //             ? "Please log in to continue."
  //             : "Error: ${orderVM.error}"),
  //         const SizedBox(height: 16),
  //         ElevatedButton(
  //           onPressed: () {
  //             if (userProfile != null) {
  //               orderVM.fetchMyOrder(refresh: true);
  //             } else {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (_) => const LoggedOutScreen()),
  //               );
  //             }
  //           },
  //           child: Text(userProfile == null ? "Login" : "Retry"),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
