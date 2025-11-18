class DivisionResponse {
  final List<Division> data;
  final Meta meta;

  DivisionResponse({
    required this.data,
    required this.meta,
  });

  factory DivisionResponse.fromJson(Map<String, dynamic> json) =>
      DivisionResponse(
        data: (json['data'] as List? ?? [])
            .map((e) => Division.fromJson(e))
            .toList(),
        meta: Meta.fromJson(json['meta'] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        'data': data.map((e) => e.toJson()).toList(),
        'meta': meta.toJson(),
      };
}

class Division {
  final String id;
  final String name;
  final String nameBN;

  Division({
    required this.id,
    required this.name,
    required this.nameBN,
  });

  factory Division.fromJson(Map<String, dynamic> json) => Division(
        id: json['id']?.toString() ?? '',
        name: json['name'] ?? '',
        nameBN: json['nameBN'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'nameBN': nameBN,
      };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta();

  Map<String, dynamic> toJson() => {};
}
