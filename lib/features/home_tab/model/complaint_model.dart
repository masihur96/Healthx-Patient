class ComplaintModel {
  ComplaintModel({
    required this.results,
  });

  final List<ComplaintData> results;

  ComplaintModel copyWith({
    List<ComplaintData>? results,
  }) {
    return ComplaintModel(
      results: results ?? this.results,
    );
  }

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      results: json["results"] == null
          ? []
          : List<ComplaintData>.from(
              json["results"]!.map((x) => ComplaintData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "results": results.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$results, ";
  }
}

class ComplaintData {
  ComplaintData({
    required this.id,
    required this.name,
    required this.isFavourite,
    required this.score,
  });

  final String id;
  final String name;
  final bool isFavourite;
  final int score;

  ComplaintData copyWith({
    String? id,
    String? name,
    bool? isFavourite,
    int? score,
  }) {
    return ComplaintData(
      id: id ?? this.id,
      name: name ?? this.name,
      isFavourite: isFavourite ?? this.isFavourite,
      score: score ?? this.score,
    );
  }

  factory ComplaintData.fromJson(Map<String, dynamic> json) {
    return ComplaintData(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      isFavourite: json["is_favourite"] ?? false,
      score: json["score"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_favourite": isFavourite,
        "score": score,
      };

  @override
  String toString() {
    return "$id, $name, $isFavourite, $score, ";
  }
}
