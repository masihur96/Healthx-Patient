class MedicationModel {
  MedicationModel({
    required this.results,
  });

  final List<MedicationData> results;

  MedicationModel copyWith({
    List<MedicationData>? results,
  }) {
    return MedicationModel(
      results: results ?? this.results,
    );
  }

  factory MedicationModel.fromJson(Map<String, dynamic> json) {
    return MedicationModel(
      results: json["results"] == null
          ? []
          : List<MedicationData>.from(
              json["results"]!.map((x) => MedicationData.fromJson(x))),
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

class MedicationData {
  MedicationData({
    required this.id,
    required this.name,
    required this.isFavourite,
    required this.score,
  });

  final String id;
  final String name;
  final bool isFavourite;
  final int score;

  MedicationData copyWith({
    String? id,
    String? name,
    bool? isFavourite,
    int? score,
  }) {
    return MedicationData(
      id: id ?? this.id,
      name: name ?? this.name,
      isFavourite: isFavourite ?? this.isFavourite,
      score: score ?? this.score,
    );
  }

  factory MedicationData.fromJson(Map<String, dynamic> json) {
    return MedicationData(
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
