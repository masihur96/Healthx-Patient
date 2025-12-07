enum AppointmentStatus {
  pending,
  confirmed,
  completed,
  cancelled;

  String get displayName {
    switch (this) {
      case AppointmentStatus.pending:
        return 'Pending';
      case AppointmentStatus.confirmed:
        return 'Confirmed';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
    }
  }
}

enum AppointmentType {
  doctor,
  lab,
  specialist;

  String get displayName {
    switch (this) {
      case AppointmentType.doctor:
        return 'Doctor';
      case AppointmentType.lab:
        return 'Lab';
      case AppointmentType.specialist:
        return 'Specialist';
    }
  }
}

enum ConsultationType {
  online,
  inPerson;

  String get displayName {
    switch (this) {
      case ConsultationType.online:
        return 'Online';
      case ConsultationType.inPerson:
        return 'In-person';
    }
  }
}

class Appointment {
  final String id;
  final String providerId;
  final String providerName;
  final String providerPhoto;
  final String specialty;
  final DateTime date;
  final String time;
  final AppointmentType type;
  final ConsultationType consultationType;
  final AppointmentStatus status;
  final String? location;
  final double fee;
  final String appointmentId;
  final DateTime createdAt;

  Appointment({
    required this.id,
    required this.providerId,
    required this.providerName,
    required this.providerPhoto,
    required this.specialty,
    required this.date,
    required this.time,
    required this.type,
    required this.consultationType,
    required this.status,
    this.location,
    required this.fee,
    required this.appointmentId,
    required this.createdAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] ?? '',
      providerId: json['provider_id'] ?? '',
      providerName: json['provider_name'] ?? '',
      providerPhoto: json['provider_photo'] ?? '',
      specialty: json['specialty'] ?? '',
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : DateTime.now(),
      time: json['time'] ?? '',
      type: AppointmentType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => AppointmentType.doctor,
      ),
      consultationType: ConsultationType.values.firstWhere(
        (e) => e.name == json['consultation_type'],
        orElse: () => ConsultationType.online,
      ),
      status: AppointmentStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => AppointmentStatus.pending,
      ),
      location: json['location'],
      fee: (json['fee'] ?? 0).toDouble(),
      appointmentId: json['appointment_id'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider_id': providerId,
      'provider_name': providerName,
      'provider_photo': providerPhoto,
      'specialty': specialty,
      'date': date.toIso8601String(),
      'time': time,
      'type': type.name,
      'consultation_type': consultationType.name,
      'status': status.name,
      'location': location,
      'fee': fee,
      'appointment_id': appointmentId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Appointment copyWith({
    String? id,
    String? providerId,
    String? providerName,
    String? providerPhoto,
    String? specialty,
    DateTime? date,
    String? time,
    AppointmentType? type,
    ConsultationType? consultationType,
    AppointmentStatus? status,
    String? location,
    double? fee,
    String? appointmentId,
    DateTime? createdAt,
  }) {
    return Appointment(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      providerName: providerName ?? this.providerName,
      providerPhoto: providerPhoto ?? this.providerPhoto,
      specialty: specialty ?? this.specialty,
      date: date ?? this.date,
      time: time ?? this.time,
      type: type ?? this.type,
      consultationType: consultationType ?? this.consultationType,
      status: status ?? this.status,
      location: location ?? this.location,
      fee: fee ?? this.fee,
      appointmentId: appointmentId ?? this.appointmentId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
