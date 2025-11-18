class ChamberModel {
  ChamberModel({
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
  final List<ChamberData> results;

  ChamberModel copyWith({
    Links? links,
    int? total,
    int? totalPages,
    int? currentPage,
    int? pageSize,
    List<ChamberData>? results,
  }) {
    return ChamberModel(
      links: links ?? this.links,
      total: total ?? this.total,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      results: results ?? this.results,
    );
  }

  factory ChamberModel.fromJson(Map<String, dynamic> json) {
    return ChamberModel(
      links: json["links"] == null ? null : Links.fromJson(json["links"]),
      total: json["total"] ?? 0,
      totalPages: json["total_pages"] ?? 0,
      currentPage: json["current_page"] ?? 0,
      pageSize: json["page_size"] ?? 0,
      results: json["results"] == null
          ? []
          : List<ChamberData>.from(
              json["results"]!.map((x) => ChamberData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "links": links?.toJson(),
        "total": total,
        "total_pages": totalPages,
        "current_page": currentPage,
        "page_size": pageSize,
        "results": results.map((x) => x.toJson()).toList(),
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

  final dynamic next;
  final dynamic previous;

  Links copyWith({
    dynamic next,
    dynamic previous,
  }) {
    return Links(
      next: next ?? this.next,
      previous: previous ?? this.previous,
    );
  }

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      next: json["next"],
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

class ChamberData {
  ChamberData({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.timePerPatitent,
    required this.appointmentType,
    required this.waitingList,
    required this.waitingListSize,
    required this.appointmentMethod,
    required this.extension,
    required this.instruction,
    required this.doctor,
  });

  final String id;
  final String name;
  final String phoneNumber;
  final int timePerPatitent;
  final String appointmentType;
  final bool waitingList;
  final int waitingListSize;
  final String appointmentMethod;
  final dynamic extension;
  final String instruction;
  final String doctor;

  ChamberData copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    int? timePerPatitent,
    String? appointmentType,
    bool? waitingList,
    int? waitingListSize,
    String? appointmentMethod,
    dynamic extension,
    String? instruction,
    String? doctor,
  }) {
    return ChamberData(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      timePerPatitent: timePerPatitent ?? this.timePerPatitent,
      appointmentType: appointmentType ?? this.appointmentType,
      waitingList: waitingList ?? this.waitingList,
      waitingListSize: waitingListSize ?? this.waitingListSize,
      appointmentMethod: appointmentMethod ?? this.appointmentMethod,
      extension: extension ?? this.extension,
      instruction: instruction ?? this.instruction,
      doctor: doctor ?? this.doctor,
    );
  }

  factory ChamberData.fromJson(Map<String, dynamic> json) {
    return ChamberData(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      phoneNumber: json["phone_number"] ?? "",
      timePerPatitent: json["time_per_patitent"] ?? 0,
      appointmentType: json["appointment_type"] ?? "",
      waitingList: json["waiting_list"] ?? false,
      waitingListSize: json["waiting_list_size"] ?? 0,
      appointmentMethod: json["appointment_method"] ?? "",
      extension: json["extension"],
      instruction: json["instruction"] ?? "",
      doctor: json["doctor"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_number": phoneNumber,
        "time_per_patitent": timePerPatitent,
        "appointment_type": appointmentType,
        "waiting_list": waitingList,
        "waiting_list_size": waitingListSize,
        "appointment_method": appointmentMethod,
        "extension": extension,
        "instruction": instruction,
        "doctor": doctor,
      };

  @override
  String toString() {
    return "$id, $name, $phoneNumber, $timePerPatitent, $appointmentType, $waitingList, $waitingListSize, $appointmentMethod, $extension, $instruction, $doctor, ";
  }
}
