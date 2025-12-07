import '../models/appointment_model.dart';

class AppointmentService {
  // Mock data for demonstration
  static List<Appointment> _appointments = [];
  static int _nextId = 1;

  // Initialize with sample data
  static void _initializeSampleData() {
    if (_appointments.isEmpty) {
      final now = DateTime.now();
      _appointments = [
        Appointment(
          id: '1',
          providerId: 'p1',
          providerName: 'Dr. Sarah Ahmed',
          providerPhoto: 'assets/images/onboarding_preview1.png',
          specialty: 'Cardiologist',
          date: now.add(const Duration(days: 2)),
          time: '10:00 AM',
          type: AppointmentType.doctor,
          consultationType: ConsultationType.online,
          status: AppointmentStatus.confirmed,
          location: 'City Heart Clinic',
          fee: 30.0,
          appointmentId: 'APT001',
          createdAt: now.subtract(const Duration(days: 1)),
        ),
        Appointment(
          id: '2',
          providerId: 'p2',
          providerName: 'Dr. Karim Hossain',
          providerPhoto: 'assets/images/onboard.jpg',
          specialty: 'Dermatologist',
          date: now.add(const Duration(days: 5)),
          time: '02:30 PM',
          type: AppointmentType.doctor,
          consultationType: ConsultationType.inPerson,
          status: AppointmentStatus.pending,
          location: 'Skin Care Center',
          fee: 25.0,
          appointmentId: 'APT002',
          createdAt: now.subtract(const Duration(hours: 12)),
        ),
        Appointment(
          id: '3',
          providerId: 'p3',
          providerName: 'City Lab Services',
          providerPhoto: 'assets/images/onboarding_preview1.png',
          specialty: 'Blood Test',
          date: now.subtract(const Duration(days: 5)),
          time: '09:00 AM',
          type: AppointmentType.lab,
          consultationType: ConsultationType.inPerson,
          status: AppointmentStatus.completed,
          location: 'City Lab - Main Branch',
          fee: 15.0,
          appointmentId: 'APT003',
          createdAt: now.subtract(const Duration(days: 7)),
        ),
        Appointment(
          id: '4',
          providerId: 'p4',
          providerName: 'Dr. Fatima Rahman',
          providerPhoto: 'assets/images/onboarding_preview1.png',
          specialty: 'Neurologist',
          date: now.subtract(const Duration(days: 15)),
          time: '11:30 AM',
          type: AppointmentType.specialist,
          consultationType: ConsultationType.online,
          status: AppointmentStatus.cancelled,
          location: null,
          fee: 40.0,
          appointmentId: 'APT004',
          createdAt: now.subtract(const Duration(days: 20)),
        ),
      ];
      _nextId = 5;
    }
  }

  // Get all appointments
  Future<List<Appointment>> getAppointments() async {
    _initializeSampleData();
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    return List.from(_appointments);
  }

  // Get appointments by status
  Future<List<Appointment>> getAppointmentsByStatus(
      AppointmentStatus status) async {
    _initializeSampleData();
    await Future.delayed(const Duration(milliseconds: 300));
    return _appointments.where((apt) => apt.status == status).toList();
  }

  // Get upcoming appointments
  Future<List<Appointment>> getUpcomingAppointments() async {
    _initializeSampleData();
    await Future.delayed(const Duration(milliseconds: 300));
    final now = DateTime.now();
    return _appointments
        .where((apt) =>
            (apt.status == AppointmentStatus.confirmed ||
                apt.status == AppointmentStatus.pending) &&
            apt.date.isAfter(now.subtract(const Duration(days: 1))))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  // Get past appointments
  Future<List<Appointment>> getPastAppointments() async {
    _initializeSampleData();
    await Future.delayed(const Duration(milliseconds: 300));
    final now = DateTime.now();
    return _appointments
        .where((apt) =>
            apt.status == AppointmentStatus.completed ||
            (apt.date.isBefore(now.subtract(const Duration(days: 1))) &&
                apt.status != AppointmentStatus.cancelled))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  // Get cancelled appointments
  Future<List<Appointment>> getCancelledAppointments() async {
    _initializeSampleData();
    await Future.delayed(const Duration(milliseconds: 300));
    return _appointments
        .where((apt) => apt.status == AppointmentStatus.cancelled)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  // Create new appointment
  Future<Appointment> createAppointment({
    required String providerId,
    required String providerName,
    required String providerPhoto,
    required String specialty,
    required DateTime date,
    required String time,
    required AppointmentType type,
    required ConsultationType consultationType,
    String? location,
    required double fee,
  }) async {
    _initializeSampleData();
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate network delay

    final newAppointment = Appointment(
      id: _nextId.toString(),
      providerId: providerId,
      providerName: providerName,
      providerPhoto: providerPhoto,
      specialty: specialty,
      date: date,
      time: time,
      type: type,
      consultationType: consultationType,
      status: AppointmentStatus.confirmed,
      location: location,
      fee: fee,
      appointmentId: 'APT${_nextId.toString().padLeft(3, '0')}',
      createdAt: DateTime.now(),
    );

    _appointments.add(newAppointment);
    _nextId++;

    return newAppointment;
  }

  // Reschedule appointment
  Future<Appointment> rescheduleAppointment({
    required String appointmentId,
    required DateTime newDate,
    required String newTime,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final index = _appointments.indexWhere((apt) => apt.id == appointmentId);
    if (index == -1) {
      throw Exception('Appointment not found');
    }

    final updatedAppointment = _appointments[index].copyWith(
      date: newDate,
      time: newTime,
      status: AppointmentStatus.confirmed,
    );

    _appointments[index] = updatedAppointment;
    return updatedAppointment;
  }

  // Cancel appointment
  Future<bool> cancelAppointment(String appointmentId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final index = _appointments.indexWhere((apt) => apt.id == appointmentId);
    if (index == -1) {
      return false;
    }

    _appointments[index] = _appointments[index].copyWith(
      status: AppointmentStatus.cancelled,
    );

    return true;
  }

  // Get appointment by ID
  Future<Appointment?> getAppointmentById(String id) async {
    _initializeSampleData();
    await Future.delayed(const Duration(milliseconds: 200));

    try {
      return _appointments.firstWhere((apt) => apt.id == id);
    } catch (e) {
      return null;
    }
  }
}
