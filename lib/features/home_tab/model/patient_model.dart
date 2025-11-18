// class PatientModel {
//   PatientModel({
//     required this.links,
//     required this.total,
//     required this.totalPages,
//     required this.currentPage,
//     required this.pageSize,
//     required this.results,
//   });
//
//   final Links? links;
//   final int total;
//   final int totalPages;
//   final int currentPage;
//   final int pageSize;
//   final List<PatientData> results;
//
//   PatientModel copyWith({
//     Links? links,
//     int? total,
//     int? totalPages,
//     int? currentPage,
//     int? pageSize,
//     List<PatientData>? results,
//   }) {
//     return PatientModel(
//       links: links ?? this.links,
//       total: total ?? this.total,
//       totalPages: totalPages ?? this.totalPages,
//       currentPage: currentPage ?? this.currentPage,
//       pageSize: pageSize ?? this.pageSize,
//       results: results ?? this.results,
//     );
//   }
//
//   factory PatientModel.fromJson(Map<String, dynamic> json) {
//     return PatientModel(
//       links: json["links"] == null ? null : Links.fromJson(json["links"]),
//       total: json["total"] ?? 0,
//       totalPages: json["total_pages"] ?? 0,
//       currentPage: json["current_page"] ?? 0,
//       pageSize: json["page_size"] ?? 0,
//       results: json["results"] == null
//           ? []
//           : List<PatientData>.from(
//               json["results"]!.map((x) => PatientData.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "links": links?.toJson(),
//         "total": total,
//         "total_pages": totalPages,
//         "current_page": currentPage,
//         "page_size": pageSize,
//         "results": results.map((x) => x.toJson()).toList(),
//       };
//
//   @override
//   String toString() {
//     return "$links, $total, $totalPages, $currentPage, $pageSize, $results, ";
//   }
// }
//
// class Links {
//   Links({
//     required this.next,
//     required this.previous,
//   });
//
//   final dynamic next;
//   final dynamic previous;
//
//   Links copyWith({
//     dynamic next,
//     dynamic previous,
//   }) {
//     return Links(
//       next: next ?? this.next,
//       previous: previous ?? this.previous,
//     );
//   }
//
//   factory Links.fromJson(Map<String, dynamic> json) {
//     return Links(
//       next: json["next"],
//       previous: json["previous"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "next": next,
//         "previous": previous,
//       };
//
//   @override
//   String toString() {
//     return "$next, $previous, ";
//   }
// }
//
// class PatientData {
//   PatientData({
//     required this.dateOfBirth,
//     required this.lastVisitedDate,
//     required this.lastVisitedDoctor,
//     required this.patientRegistered,
//     required this.meta,
//     required this.email,
//     required this.firstname,
//     required this.lastname,
//     required this.occupation,
//     required this.bloodGroup,
//     required this.phoneNumber,
//     required this.id,
//     required this.gender,
//     required this.image,
//   });
//
//   final DateTime? dateOfBirth;
//   final dynamic lastVisitedDate;
//   final dynamic lastVisitedDoctor;
//   final bool patientRegistered;
//   final dynamic meta;
//   final String email;
//   final String firstname;
//   final String lastname;
//   final String phoneNumber;
//   final String occupation;
//   final String bloodGroup;
//   final String id;
//   final String gender;
//   final dynamic image;
//
//   PatientData copyWith({
//     DateTime? dateOfBirth,
//     dynamic lastVisitedDate,
//     dynamic lastVisitedDoctor,
//     bool? patientRegistered,
//     dynamic meta,
//     String? email,
//     String? firstname,
//     String? lastname,
//     String? phoneNumber,
//     String? occupation,
//     String? bloodGroup,
//     String? id,
//     String? gender,
//     dynamic image,
//   }) {
//     return PatientData(
//       dateOfBirth: dateOfBirth ?? this.dateOfBirth,
//       lastVisitedDate: lastVisitedDate ?? this.lastVisitedDate,
//       lastVisitedDoctor: lastVisitedDoctor ?? this.lastVisitedDoctor,
//       patientRegistered: patientRegistered ?? this.patientRegistered,
//       meta: meta ?? this.meta,
//       email: email ?? this.email,
//       firstname: firstname ?? this.firstname,
//       lastname: lastname ?? this.lastname,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       occupation: occupation ?? this.occupation,
//       bloodGroup: bloodGroup ?? this.bloodGroup,
//       id: id ?? this.id,
//       gender: gender ?? this.gender,
//       image: image ?? this.image,
//     );
//   }
//
//   factory PatientData.fromJson(Map<String, dynamic> json) {
//     return PatientData(
//       dateOfBirth: DateTime.tryParse(json["date_of_birth"] ?? ""),
//       lastVisitedDate: json["last_visited_date"],
//       lastVisitedDoctor: json["last_visited_doctor"],
//       patientRegistered: json["patient_registered"] ?? false,
//       meta: json["meta"],
//       email: json["email"] ?? "",
//       firstname: json["firstname"] ?? "",
//       lastname: json["lastname"] ?? "",
//       occupation: json["occupation"] ?? "",
//       bloodGroup: json["blood_group"] ?? "",
//       phoneNumber: json["phone_number"] ?? "",
//       id: json["id"] ?? "",
//       gender: json["gender"] ?? "",
//       image: json["image"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "date_of_birth":
//             "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
//         "last_visited_date": lastVisitedDate,
//         "last_visited_doctor": lastVisitedDoctor,
//         "patient_registered": patientRegistered,
//         "meta": meta,
//         "email": email,
//         "firstname": firstname,
//         "lastname": lastname,
//         "phone_number": phoneNumber,
//         "occupation": occupation,
//         "bloodGroup": bloodGroup,
//         "id": id,
//         "gender": gender,
//         "image": image,
//       };
//
//   @override
//   String toString() {
//     return "$dateOfBirth, $lastVisitedDate, $lastVisitedDoctor, $patientRegistered, $meta, $email, $firstname, $lastname, $phoneNumber, $id, $gender, $image, ";
//   }
// }
