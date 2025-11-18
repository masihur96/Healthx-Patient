class DiagnosisModel {
  DiagnosisModel({
    required this.results,
  });

  final List<DiagnosisData> results;

  DiagnosisModel copyWith({
    List<DiagnosisData>? results,
  }) {
    return DiagnosisModel(
      results: results ?? this.results,
    );
  }

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisModel(
      results: json["results"] == null
          ? []
          : List<DiagnosisData>.from(
              json["results"]!.map((x) => DiagnosisData.fromJson(x))),
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

class DiagnosisData {
  DiagnosisData({
    required this.id,
    required this.name,
    required this.isFavourite,
    required this.score,
  });

  final String id;
  final String name;
  final bool isFavourite;
  final int score;

  DiagnosisData copyWith({
    String? id,
    String? name,
    bool? isFavourite,
    int? score,
  }) {
    return DiagnosisData(
      id: id ?? this.id,
      name: name ?? this.name,
      isFavourite: isFavourite ?? this.isFavourite,
      score: score ?? this.score,
    );
  }

  factory DiagnosisData.fromJson(Map<String, dynamic> json) {
    return DiagnosisData(
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
