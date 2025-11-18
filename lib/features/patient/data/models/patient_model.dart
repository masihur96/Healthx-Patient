class PatientListResponse {
  final Links links;
  final int total;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final List<PatientItem> results;

  PatientListResponse({
    required this.links,
    required this.total,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory PatientListResponse.fromJson(Map<String, dynamic> json) {
    return PatientListResponse(
      links: Links.fromJson(json['links'] ?? {}),
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      currentPage: json['current_page'] ?? 1,
      pageSize: json['page_size'] ?? 20,
      results: (json['results'] as List<dynamic>? ?? [])
          .map((item) => PatientItem.fromJson(item))
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

class PatientItem {
  final String? dateOfBirth;
  final String? lastVisitedDate;
  final String? lastVisitedDoctor;
  final bool patientRegistered;
  final dynamic meta;
  final String? bloodGroup;
  final String? occupation;
  final String? email;
  final String firstname;
  final String? lastname;
  final String phoneNumber;
  final String id;
  final String gender;
  final String? image;

  PatientItem({
    this.dateOfBirth,
    this.lastVisitedDate,
    this.lastVisitedDoctor,
    required this.patientRegistered,
    this.meta,
    this.bloodGroup,
    this.occupation,
    this.email,
    required this.firstname,
    this.lastname,
    required this.phoneNumber,
    required this.id,
    required this.gender,
    this.image,
  });

  factory PatientItem.fromJson(Map<String, dynamic> json) {
    return PatientItem(
      dateOfBirth: json['date_of_birth'],
      lastVisitedDate: json['last_visited_date'],
      lastVisitedDoctor: json['last_visited_doctor'],
      patientRegistered: json['patient_registered'] ?? false,
      meta: json['meta'],
      bloodGroup: json['blood_group'],
      occupation: json['occupation'],
      email: json['email'],
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'],
      phoneNumber: json['phone_number'] ?? '',
      id: json['id'] ?? '',
      gender: json['gender'] ?? '',
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date_of_birth': dateOfBirth,
        'last_visited_date': lastVisitedDate,
        'last_visited_doctor': lastVisitedDoctor,
        'patient_registered': patientRegistered,
        'meta': meta,
        'blood_group': bloodGroup,
        'occupation': occupation,
        'email': email,
        'firstname': firstname,
        'lastname': lastname,
        'phone_number': phoneNumber,
        'id': id,
        'gender': gender,
        'image': image,
      };
}
