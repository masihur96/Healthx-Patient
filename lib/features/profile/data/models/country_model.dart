class CountryResponse {
  final List<Country> data;

  CountryResponse({required this.data});

  factory CountryResponse.fromJson(Map<String, dynamic> json) =>
      CountryResponse(
        data: (json['data'] as List? ?? [])
            .map((e) => Country.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': data.map((e) => e.toJson()).toList(),
      };
}

class Country {
  final String name;
  final String nameBN;
  final String alpha2Code;
  final String alpha3Code;
  final String dialCode;
  final String flag;
  final int minPhoneLength;
  final int maxPhoneLength;
  final List<String>? acceptedPrefixes;

  Country({
    required this.name,
    required this.nameBN,
    required this.alpha2Code,
    required this.alpha3Code,
    required this.dialCode,
    required this.flag,
    required this.minPhoneLength,
    required this.maxPhoneLength,
    this.acceptedPrefixes,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json['name'] ?? '',
        nameBN: json['nameBN'] ?? '',
        alpha2Code: json['alpha2'] ?? '',
        alpha3Code: json['alpha3'] ?? '',
        dialCode: json['countryCode'] ?? '',
        flag: json['flagIcon'] ?? '',
        minPhoneLength: json['minPhoneLength'] ?? 0,
        maxPhoneLength: json['maxPhoneLength'] ?? 0,
        acceptedPrefixes: json['acceptedPrefixes'] != null
            ? (json['acceptedPrefixes'] as List).cast<String>()
            : null,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'nameBN': nameBN,
        'alpha2': alpha2Code,
        'alpha3': alpha3Code,
        'countryCode': dialCode,
        'flagIcon': flag,
        'minPhoneLength': minPhoneLength,
        'maxPhoneLength': maxPhoneLength,
        if (acceptedPrefixes != null) 'acceptedPrefixes': acceptedPrefixes,
      };
}
