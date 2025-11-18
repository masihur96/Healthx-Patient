class DrugListModel {
  DrugListModel({
    required this.links,
    required this.total,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  final Links? links;
  final int total;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final List<DrugsData> results;

  DrugListModel copyWith({
    Links? links,
    int? total,
    int? totalPages,
    int? currentPage,
    int? pageSize,
    List<DrugsData>? results,
  }) {
    return DrugListModel(
      links: links ?? this.links,
      total: total ?? this.total,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      results: results ?? this.results,
    );
  }

  factory DrugListModel.fromJson(Map<String, dynamic> json) {
    return DrugListModel(
      links: json["links"] == null ? null : Links.fromJson(json["links"]),
      total: json["total"] ?? 0,
      totalPages: json["total_pages"] ?? 0,
      currentPage: json["current_page"] ?? 0,
      pageSize: json["page_size"] ?? 0,
      results: json["results"] == null
          ? []
          : List<DrugsData>.from(
              json["results"]!.map((x) => DrugsData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "links": links?.toJson(),
        "total": total,
        "total_pages": totalPages,
        "current_page": currentPage,
        "page_size": pageSize,
        "results": results.map((x) => x?.toJson()).toList(),
      };

  @override
  String toString() {
    return "$links, $total, $totalPages, $currentPage, $pageSize, $results, ";
  }
}

class Links {
  Links({
    required this.next,
    required this.previous,
  });

  final String next;
  final dynamic previous;

  Links copyWith({
    String? next,
    dynamic? previous,
  }) {
    return Links(
      next: next ?? this.next,
      previous: previous ?? this.previous,
    );
  }

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      next: json["next"] ?? "",
      previous: json["previous"],
    );
  }

  Map<String, dynamic> toJson() => {
        "next": next,
        "previous": previous,
      };

  @override
  String toString() {
    return "$next, $previous, ";
  }
}

class DrugsData {
  DrugsData({
    required this.id,
    required this.brandName,
    required this.power,
    required this.form,
    required this.strength,
    required this.companyName,
    required this.genericName,
    required this.instruction,
    required this.foodRelation,
    required this.isFavourite,
    required this.note,
    required this.duration,
    required this.sortKey,
    required this.doctor,
  });

  final int id;
  final String brandName;
  final String power;
  final String form;
  final String strength;
  final String companyName;
  final String genericName;
  final dynamic instruction;
  final dynamic foodRelation;
  final bool isFavourite;
  final dynamic note;
  final dynamic duration;
  final String sortKey;
  final dynamic doctor;

  DrugsData copyWith({
    int? id,
    String? brandName,
    String? power,
    String? form,
    String? strength,
    String? companyName,
    String? genericName,
    dynamic? instruction,
    dynamic? foodRelation,
    bool? isFavourite,
    dynamic? note,
    dynamic? duration,
    String? sortKey,
    dynamic? doctor,
  }) {
    return DrugsData(
      id: id ?? this.id,
      brandName: brandName ?? this.brandName,
      power: power ?? this.power,
      form: form ?? this.form,
      strength: strength ?? this.strength,
      companyName: companyName ?? this.companyName,
      genericName: genericName ?? this.genericName,
      instruction: instruction ?? this.instruction,
      foodRelation: foodRelation ?? this.foodRelation,
      isFavourite: isFavourite ?? this.isFavourite,
      note: note ?? this.note,
      duration: duration ?? this.duration,
      sortKey: sortKey ?? this.sortKey,
      doctor: doctor ?? this.doctor,
    );
  }

  factory DrugsData.fromJson(Map<String, dynamic> json) {
    return DrugsData(
      id: json["id"] ?? 0,
      brandName: json["brand_name"] ?? "",
      power: json["power"] ?? "",
      form: json["form"] ?? "",
      strength: json["strength"] ?? "",
      companyName: json["company_name"] ?? "",
      genericName: json["generic_name"] ?? "",
      instruction: json["instruction"],
      foodRelation: json["food_relation"],
      isFavourite: json["is_favourite"] ?? false,
      note: json["note"],
      duration: json["duration"],
      sortKey: json["sort_key"] ?? "",
      doctor: json["doctor"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand_name": brandName,
        "power": power,
        "form": form,
        "strength": strength,
        "company_name": companyName,
        "generic_name": genericName,
        "instruction": instruction,
        "food_relation": foodRelation,
        "is_favourite": isFavourite,
        "note": note,
        "duration": duration,
        "sort_key": sortKey,
        "doctor": doctor,
      };

  @override
  String toString() {
    return "$id, $brandName, $power, $form, $strength, $companyName, $genericName, $instruction, $foodRelation, $isFavourite, $note, $duration, $sortKey, $doctor, ";
  }
}
