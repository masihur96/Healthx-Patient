class AdviceModel {
  AdviceModel({
    required this.results,
  });

  final List<AdviceData> results;

  AdviceModel copyWith({
    List<AdviceData>? results,
  }) {
    return AdviceModel(
      results: results ?? this.results,
    );
  }

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      results: json["results"] == null
          ? []
          : List<AdviceData>.from(
              json["results"]!.map((x) => AdviceData.fromJson(x))),
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

class AdviceData {
  AdviceData({
    required this.id,
    required this.name,
    required this.isFavourite,
    required this.score,
  });

  final String id;
  final String name;
  final bool isFavourite;
  final int score;

  AdviceData copyWith({
    String? id,
    String? name,
    bool? isFavourite,
    int? score,
  }) {
    return AdviceData(
      id: id ?? this.id,
      name: name ?? this.name,
      isFavourite: isFavourite ?? this.isFavourite,
      score: score ?? this.score,
    );
  }

  factory AdviceData.fromJson(Map<String, dynamic> json) {
    return AdviceData(
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
