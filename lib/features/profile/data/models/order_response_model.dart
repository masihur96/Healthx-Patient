class OrderResponse {
  final List<Order> data;
  final Meta meta;

  OrderResponse({
    required this.data,
    required this.meta,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
    data: (json['data'] as List? ?? [])
        .map((e) => Order.fromJson(e))
        .toList(),
    meta: Meta.fromJson(json['meta'] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    'data': data.map((e) => e.toJson()).toList(),
    'meta': meta.toJson(),
  };
}

class Order {
  final int id;
  final String transactionId;
  final String paymentGateway;
  final double totalAmount;
  final String currency;
  final String orderStatus;
  final String paymentStatus;
  final String createdAt;
  final List<OrderItem> orderItems;

  Order({
    required this.id,
    required this.transactionId,
    required this.paymentGateway,
    required this.totalAmount,
    required this.currency,
    required this.orderStatus,
    required this.paymentStatus,
    required this.createdAt,
    required this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json['id'] ?? 0,
    transactionId: json['transactionId'] ?? '',
    paymentGateway: json['paymentGateway'] ?? '',
    totalAmount: (json['totalAmount'] ?? 0).toDouble(),
    currency: json['currency'] ?? '',
    orderStatus: json['orderStatus'] ?? '',
    paymentStatus: json['paymentStatus'] ?? '',
    createdAt: json['createdAt'] ?? '',
    orderItems: (json['orderItems'] as List? ?? [])
        .map((e) => OrderItem.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'transactionId': transactionId,
    'paymentGateway': paymentGateway,
    'totalAmount': totalAmount,
    'currency': currency,
    'orderStatus': orderStatus,
    'paymentStatus': paymentStatus,
    'createdAt': createdAt,
    'orderItems': orderItems.map((e) => e.toJson()).toList(),
  };
}

class OrderItem {
  final int id;
  final String type;
  final String currency;
  final int quantity;
  final double price;
  final OrderBook book;

  OrderItem({
    required this.id,
    required this.type,
    required this.currency,
    required this.quantity,
    required this.price,
    required this.book,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json['id'] ?? 0,
    type: json['type'] ?? '',
    currency: json['currency'] ?? '',
    quantity: json['quantity'] ?? 0,
    price: (json['price'] ?? 0).toDouble(), // ✅ safe
    book: OrderBook.fromJson(json['book'] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'currency': currency,
    'quantity': quantity,
    'price': price,
    'book': book.toJson(),
  };
}

class OrderBook {
  final int id;
  final String documentId;
  final String name;
  final String nameBN; // Added for Bengali name
  final String slug;
  final bool? isNew;
  final BookImage? image; // renamed from coverImage

  OrderBook({
    required this.id,
    required this.documentId,
    required this.name,
    required this.nameBN,
    required this.slug,
    this.isNew,
    this.image,
  });

  factory OrderBook.fromJson(Map<String, dynamic> json) => OrderBook(
    id: json['id'] ?? 0,
    documentId: json['documentId'] ?? '',
    name: json['name'] ?? '',
    nameBN: json['nameBN'] ?? '',
    slug: json['slug'] ?? '',
    isNew: json['isNew'],
    image: json['image'] != null ? BookImage.fromJson(json['image']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'documentId': documentId,
    'name': name,
    'nameBN': nameBN,
    'slug': slug,
    'isNew': isNew,
    'image': image?.toJson(),
  };
}

class BookImage {
  final String url;

  BookImage({required this.url});

  factory BookImage.fromJson(Map<String, dynamic> json) =>
      BookImage(url: json['url'] ?? '');

  Map<String, dynamic> toJson() => {'url': url};
}

class Meta {
  final Pagination pagination;

  Meta({required this.pagination});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    pagination: Pagination.fromJson(json['pagination'] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    'pagination': pagination.toJson(),
  };
}

class Pagination {
  final int page;
  final int pageSize;
  final int itemCount;
  final int pageCount;

  Pagination({
    required this.page,
    required this.pageSize,
    required this.itemCount,
    required this.pageCount,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    page: json['page'] ?? 1,
    pageSize: json['pageSize'] ?? 10,
    itemCount: json['itemCount'] ?? 0,
    pageCount: json['pageCount'] ?? 1,
  );

  Map<String, dynamic> toJson() => {
    'page': page,
    'pageSize': pageSize,
    'itemCount': itemCount,
    'pageCount': pageCount,
  };
}
