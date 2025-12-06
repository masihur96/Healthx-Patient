import 'package:flutter/material.dart';
import 'package:healthx_patient/shared/providers/language_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MedicineOrderScreen extends StatefulWidget {
  const MedicineOrderScreen({super.key});

  @override
  State<MedicineOrderScreen> createState() => _MedicineOrderScreenState();
}

class _MedicineOrderScreenState extends State<MedicineOrderScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Set<int> _expandedOrders = {};
  bool _isSearchVisible = false;

  // ---------------------- DUMMY DATA ----------------------
  final List<Map<String, dynamic>> _orders = [
    {
      "id": 1,
      "transactionId": "TXN123456",
      "totalAmount": 820,
      "paymentStatus": "Paid",
      "orderStatus": "DELIVERED",
      "createdAt": DateTime.now().subtract(const Duration(days: 1)).toString(),
      "items": [
        {
          "name": "Napa Extra 500mg",
          "price": 120,
          "qty": 2,
          "image":
              "https://www.beximcopharma.com/images/products/NAPA%20EXT%20TAB%20(FULL).png"
        },
        {
          "name": "Seclo 20mg",
          "price": 200,
          "qty": 3,
          "image": "https://www.squarepharma.com.bd/products/images/SECLo.jpg"
        },
      ]
    },
    {
      "id": 2,
      "transactionId": "TXN456789",
      "totalAmount": 450,
      "paymentStatus": "Pending",
      "orderStatus": "PROCESSING",
      "createdAt": DateTime.now().subtract(const Duration(days: 3)).toString(),
      "items": [
        {"name": "Losectil 20mg", "price": 150, "qty": 2, "image": ""}
      ]
    },
  ];

  // ---------------------- SEARCH ----------------------
  List<Map<String, dynamic>> get _filteredOrders {
    if (_searchController.text.trim().isEmpty) return _orders;

    final query = _searchController.text.trim().toLowerCase();

    return _orders.where((order) {
      final tn = order["transactionId"].toString().toLowerCase();
      final status = order["orderStatus"].toString().toLowerCase();
      final medicineNames = order["items"]
          .map((e) => e["name"].toString().toLowerCase())
          .join(" ");

      return tn.contains(query) ||
          status.contains(query) ||
          medicineNames.contains(query);
    }).toList();
  }

  void _toggleOrderExpand(int id) {
    setState(() {
      if (_expandedOrders.contains(id)) {
        _expandedOrders.remove(id);
      } else {
        _expandedOrders.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: _buildAppBar(languageProvider),
      body: Column(
        children: [
          if (_isSearchVisible) _buildSearchBar(languageProvider),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => setState(() {}),
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = _filteredOrders[index];
                  return _buildOrderCard(order, languageProvider);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // UI Components
  // ---------------------------------------------------------------------------

  AppBar _buildAppBar(LanguageProvider lp) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        lp.isBangla ? "ওষুধের অর্ডারসমূহ" : "Medicine Orders",
        style: const TextStyle(color: Colors.black, fontSize: 18),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            _isSearchVisible ? Icons.close : Icons.search,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              _isSearchVisible = !_isSearchVisible;
              if (!_isSearchVisible) _searchController.clear();
            });
          },
        )
      ],
    );
  }

  Widget _buildSearchBar(LanguageProvider lp) {
    return Container(
      padding: const EdgeInsets.all(14),
      color: Colors.white,
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: lp.isBangla
              ? "অর্ডার, ওষুধের নাম বা স্ট্যাটাস অনুসন্ধান করুন..."
              : "Search orders, medicine names, or status...",
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, LanguageProvider lp) {
    final isExpanded = _expandedOrders.contains(order["id"]);
    final items = List<Map<String, dynamic>>.from(order["items"]);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        children: [
          _buildOrderHeader(order),
          _buildOrderDetails(order),
          _buildMedicineSection(items, lp, isExpanded, order["id"]),
        ],
      ),
    );
  }

  Widget _buildOrderHeader(Map<String, dynamic> order) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFFF1F3F5),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Total Amount + Transaction ID
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '৳${order["totalAmount"]}',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                "Order #${order["transactionId"]}",
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),

          // Status Chip
          _statusChip(order["orderStatus"]),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    Color bg, text;
    IconData icon;

    switch (status) {
      case "DELIVERED":
        bg = Colors.green.shade50;
        text = Colors.green.shade700;
        icon = Icons.check_circle;
        break;
      case "PROCESSING":
        bg = Colors.blue.shade50;
        text = Colors.blue.shade700;
        icon = Icons.autorenew;
        break;
      default:
        bg = Colors.grey.shade300;
        text = Colors.grey.shade700;
        icon = Icons.info_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Icon(icon, size: 16, color: text),
          const SizedBox(width: 4),
          Text(status, style: TextStyle(color: text)),
        ],
      ),
    );
  }

  Widget _buildOrderDetails(Map<String, dynamic> order) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(children: [
            const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              DateFormat('MMM dd, yyyy')
                  .format(DateTime.parse(order["createdAt"])),
              style: TextStyle(color: Colors.grey[700]),
            ),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            const Icon(Icons.payments, size: 16, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              "Payment: ${order["paymentStatus"]}",
              style: TextStyle(color: Colors.grey[700]),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildMedicineSection(
    List<Map<String, dynamic>> items,
    LanguageProvider lp,
    bool isExpanded,
    int orderId,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Row(
            children: [
              const Icon(Icons.medication_liquid, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                lp.isBangla ? "ওষুধসমূহ" : "Medicines",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text("${items.length} items"),
            ],
          ),
        ),

        // Items (expanded or first only)
        if (isExpanded)
          ...items.map((e) => _medicineItem(e))
        else
          _medicineItem(items.first),

        if (items.length > 1)
          TextButton(
            onPressed: () => setState(() => _toggleOrderExpand(orderId)),
            child: Text(isExpanded ? "Show Less" : "Show More"),
          )
      ],
    );
  }

  Widget _medicineItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF8F9FA),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          _medicineImage(item["image"]),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["name"],
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text("৳${item["price"]} • Qty: ${item["qty"]}",
                    style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _medicineImage(String? url) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: url == null || url.isEmpty
            ? const Icon(Icons.medication, size: 30, color: Colors.grey)
            : Image.network(url,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => const Icon(Icons.medication)),
      ),
    );
  }
}
