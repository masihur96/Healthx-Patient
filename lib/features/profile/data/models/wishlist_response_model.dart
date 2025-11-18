class WishlistResponse {
  final WishlistData data;
  final Meta meta;

  WishlistResponse({
    required this.data,
    required this.meta,
  });

  factory WishlistResponse.fromJson(Map<String, dynamic> json) =>
      WishlistResponse(
        data: WishlistData.fromJson(json['data'] ?? {}),
        meta: Meta.fromJson(json['meta'] ?? {}),
      );

  Map<String, dynamic> toJson() => {
    'data': data.toJson(),
    'meta': meta.toJson(),
  };
}

class WishlistData {
  final int id;
  final String documentId;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;
  final String? locale;
  final List<WishlistBook> books;

  WishlistData({
    required this.id,
    required this.documentId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    this.locale,
    required this.books,
  });

  factory WishlistData.fromJson(Map<String, dynamic> json) => WishlistData(
    id: json['id'] ?? 0,
    documentId: json['documentId'] ?? '',
    name: json['name'] ?? '',
    createdAt: json['createdAt'] ?? '',
    updatedAt: json['updatedAt'] ?? '',
    publishedAt: json['publishedAt'] ?? '',
    locale: json['locale'],
    books: (json['books'] as List? ?? [])
        .map((e) => WishlistBook.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'documentId': documentId,
    'name': name,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'publishedAt': publishedAt,
    'locale': locale,
    'books': books.map((e) => e.toJson()).toList(),
  };
}

class WishlistBook {
  final int id;
  final String documentId;
  final String name;
  final String slug;
  final String language;
  final bool isNew;
  final bool isFree;
  final String description;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;
  final String? locale;
  final String nameBN;
  final String type;
  final String bookId;
  final BookImage? image;
  final BookPrices bookPrices;
  final int totalReviews;
  final double avgRating;
  final Offer? offer;

  WishlistBook({
    required this.id,
    required this.documentId,
    required this.name,
    required this.slug,
    required this.language,
    required this.isNew,
    required this.isFree,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    this.locale,
    required this.nameBN,
    required this.type,
    required this.bookId,
    this.image,
    required this.bookPrices,
    required this.totalReviews,
    required this.avgRating,
    this.offer,
  });

  factory WishlistBook.fromJson(Map<String, dynamic> json) => WishlistBook(
    id: json['id'] ?? 0,
    documentId: json['documentId'] ?? '',
    name: json['name'] ?? '',
    slug: json['slug'] ?? '',
    language: json['language'] ?? '',
    isNew: json['isNew'] ?? false,
    isFree: json['isFree'] ?? false,
    description: json['description'] ?? '',
    createdAt: json['createdAt'] ?? '',
    updatedAt: json['updatedAt'] ?? '',
    publishedAt: json['publishedAt'] ?? '',
    locale: json['locale'],
    nameBN: json['nameBN'] ?? '',
    type: json['type'] ?? '',
    bookId: json['bookId'] ?? '',
    image: json['image'] != null ? BookImage.fromJson(json['image']) : null,
    bookPrices: BookPrices.fromJson(json['bookPrices'] ?? {}),
    totalReviews: json['totalReviews'] ?? 0,
    avgRating: (json['avgRating'] ?? 0).toDouble(),
    offer: json['offer'] != null ? Offer.fromJson(json['offer']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'documentId': documentId,
    'name': name,
    'slug': slug,
    'language': language,
    'isNew': isNew,
    'isFree': isFree,
    'description': description,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'publishedAt': publishedAt,
    'locale': locale,
    'nameBN': nameBN,
    'type': type,
    'bookId': bookId,
    'image': image?.toJson(),
    'bookPrices': bookPrices.toJson(),
    'totalReviews': totalReviews,
    'avgRating': avgRating,
    'offer': offer?.toJson(),
  };
}

class BookPrices {
  final int bookPriceBDT;
  final double bookPriceUSD;
  final int bookDiscount;
  final double bookDiscountedPriceBDT;

  BookPrices({
    required this.bookPriceBDT,
    required this.bookPriceUSD,
    required this.bookDiscount,
    required this.bookDiscountedPriceBDT,
  });

  factory BookPrices.fromJson(Map<String, dynamic> json) => BookPrices(
    bookPriceBDT: json['bookPriceBDT'] ?? 0,
    bookPriceUSD: (json['bookPriceUSD'] is num)
        ? (json['bookPriceUSD'] as num).toDouble()
        : 0.0,
    bookDiscount: json['bookDiscount'] ?? 0,
    bookDiscountedPriceBDT: (json['bookDiscountedPriceBDT'] is num)
        ? (json['bookDiscountedPriceBDT'] as num).toDouble()
        : 0.0,
  );

  Map<String, dynamic> toJson() => {
    'bookPriceBDT': bookPriceBDT,
    'bookPriceUSD': bookPriceUSD,
    'bookDiscount': bookDiscount,
    'bookDiscountedPriceBDT': bookDiscountedPriceBDT,
  };
}

class Offer {
  final int discountValue;
  final String type;
  final String startDate;
  final String endDate;

  Offer({
    required this.discountValue,
    required this.type,
    required this.startDate,
    required this.endDate,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    discountValue: json['discountValue'] ?? 0,
    type: json['type'] ?? '',
    startDate: json['startDate'] ?? '',
    endDate: json['endDate'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'discountValue': discountValue,
    'type': type,
    'startDate': startDate,
    'endDate': endDate,
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
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta();

  Map<String, dynamic> toJson() => {};
}
