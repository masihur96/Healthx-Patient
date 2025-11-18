class MedicineListResponse {
  final Links links;
  final int total;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final List<DrugItem> results;

  MedicineListResponse({
    required this.links,
    required this.total,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory MedicineListResponse.fromJson(Map<String, dynamic> json) {
    return MedicineListResponse(
      links: Links.fromJson(json['links'] ?? {}),
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      currentPage: json['current_page'] ?? 1,
      pageSize: json['page_size'] ?? 20,
      results: (json['results'] as List<dynamic>? ?? [])
          .map((item) => DrugItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'links': links.toJson(),
        'total': total,
        'total_pages': totalPages,
        'current_page': currentPage,
        'page_size': pageSize,
        'results': results.map((e) => e.toJson()).toList(),
      };
}

class Links {
  final String? next;
  final String? previous;

  Links({
    this.next,
    this.previous,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        next: json['next'],
        previous: json['previous'],
      );

  Map<String, dynamic> toJson() => {
        'next': next,
        'previous': previous,
      };
}

class DrugItem {
  final int id;
  final String brandName;
  final String power;
  final String form;
  final String strength;
  final String companyName;
  final String genericName;
  final String? instruction;
  final String? foodRelation;
  final bool isFavourite;
  final int score;
  final String? note;
  final String? duration;
  final String? sortKey;
  final String? doctor;

  DrugItem({
    required this.id,
    required this.brandName,
    required this.power,
    required this.form,
    required this.strength,
    required this.companyName,
    required this.genericName,
    this.instruction,
    this.foodRelation,
    required this.isFavourite,
    required this.score,
    this.note,
    this.duration,
    this.sortKey,
    this.doctor,
  });

  factory DrugItem.fromJson(Map<String, dynamic> json) {
    return DrugItem(
      id: json['id'] ?? 0,
      brandName: json['brand_name'] ?? '',
      power: json['power'] ?? '',
      form: json['form'] ?? '',
      strength: json['strength'] ?? '',
      companyName: json['company_name'] ?? '',
      genericName: json['generic_name'] ?? '',
      instruction: json['instruction'],
      foodRelation: json['food_relation'],
      isFavourite: json['is_favourite'] ?? false,
      score: json['score'] ?? 0,
      note: json['note'],
      duration: json['duration'],
      sortKey: json['sort_key'],
      doctor: json['doctor'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'brand_name': brandName,
        'power': power,
        'form': form,
        'strength': strength,
        'company_name': companyName,
        'generic_name': genericName,
        'instruction': instruction,
        'food_relation': foodRelation,
        'is_favourite': isFavourite,
        'score': score,
        'note': note,
        'duration': duration,
        'sort_key': sortKey,
        'doctor': doctor,
      };
}
