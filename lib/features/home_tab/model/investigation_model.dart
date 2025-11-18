class InvestigationModel {
  InvestigationModel({
    required this.results,
  });

  final List<InvestigationData> results;

  InvestigationModel copyWith({
    List<InvestigationData>? results,
  }) {
    return InvestigationModel(
      results: results ?? this.results,
    );
  }

  factory InvestigationModel.fromJson(Map<String, dynamic> json) {
    return InvestigationModel(
      results: json["results"] == null
          ? []
          : List<InvestigationData>.from(
              json["results"]!.map((x) => InvestigationData.fromJson(x))),
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

class InvestigationData {
  InvestigationData({
    required this.id,
    required this.name,
    required this.isFavourite,
    required this.score,
  });

  final String id;
  final String name;
  final bool isFavourite;
  final int score;

  InvestigationData copyWith({
    String? id,
    String? name,
    bool? isFavourite,
    int? score,
  }) {
    return InvestigationData(
      id: id ?? this.id,
      name: name ?? this.name,
      isFavourite: isFavourite ?? this.isFavourite,
      score: score ?? this.score,
    );
  }

  factory InvestigationData.fromJson(Map<String, dynamic> json) {
    return InvestigationData(
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
