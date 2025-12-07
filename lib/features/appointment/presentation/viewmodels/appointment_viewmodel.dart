import 'package:flutter/foundation.dart';
import '../../data/models/appointment_model.dart';
import '../../data/models/provider_model.dart';
import '../../data/services/appointment_service.dart';
import '../../data/services/provider_service.dart';

enum AppointmentViewState { idle, loading, success, error }

class AppointmentViewModel extends ChangeNotifier {
  final AppointmentService _appointmentService = AppointmentService();
  final ProviderService _providerService = ProviderService();

  // State
  AppointmentViewState _state = AppointmentViewState.idle;
  String? _errorMessage;

  // Appointments
  List<Appointment> _allAppointments = [];
  List<Appointment> _upcomingAppointments = [];
  List<Appointment> _pastAppointments = [];
  List<Appointment> _cancelledAppointments = [];

  // Providers
  List<Provider> _allProviders = [];
  List<Provider> _filteredProviders = [];

  // Filters
  AppointmentType? _selectedProviderType;
  String? _selectedSpecialty;
  String? _selectedLocation;
  bool _onlineOnly = false;
  String _searchQuery = '';

  // Booking state
  Provider? _selectedProvider;
  DateTime? _selectedDate;
  String? _selectedTime;
  ConsultationType _selectedConsultationType = ConsultationType.online;

  // Getters
  AppointmentViewState get state => _state;
  String? get errorMessage => _errorMessage;

  List<Appointment> get allAppointments => _allAppointments;
  List<Appointment> get upcomingAppointments => _upcomingAppointments;
  List<Appointment> get pastAppointments => _pastAppointments;
  List<Appointment> get cancelledAppointments => _cancelledAppointments;

  List<Provider> get allProviders => _allProviders;
  List<Provider> get filteredProviders => _filteredProviders;

  AppointmentType? get selectedProviderType => _selectedProviderType;
  String? get selectedSpecialty => _selectedSpecialty;
  String? get selectedLocation => _selectedLocation;
  bool get onlineOnly => _onlineOnly;
  String get searchQuery => _searchQuery;

  Provider? get selectedProvider => _selectedProvider;
  DateTime? get selectedDate => _selectedDate;
  String? get selectedTime => _selectedTime;
  ConsultationType get selectedConsultationType => _selectedConsultationType;

  List<String> get availableSpecialties => _providerService.getSpecialties();
  List<String> get availableLocations => _providerService.getLocations();

  // Fetch all appointments
  Future<void> fetchAppointments() async {
    _setState(AppointmentViewState.loading);
    try {
      _allAppointments = await _appointmentService.getAppointments();
      _upcomingAppointments = await _appointmentService.getUpcomingAppointments();
      _pastAppointments = await _appointmentService.getPastAppointments();
      _cancelledAppointments = await _appointmentService.getCancelledAppointments();
      _setState(AppointmentViewState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(AppointmentViewState.error);
    }
  }

  // Fetch providers
  Future<void> fetchProviders() async {
    _setState(AppointmentViewState.loading);
    try {
      _allProviders = await _providerService.getProviders();
      _filteredProviders = List.from(_allProviders);
      _setState(AppointmentViewState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(AppointmentViewState.error);
    }
  }

  // Search providers
  Future<void> searchProviders(String query) async {
    _searchQuery = query;
    _setState(AppointmentViewState.loading);
    try {
      final results = await _providerService.searchProviders(query);
      _filteredProviders = results;
      _applyFilters();
      _setState(AppointmentViewState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(AppointmentViewState.error);
    }
  }

  // Apply filters
  void _applyFilters() {
    var filtered = List<Provider>.from(_filteredProviders);

    if (_selectedProviderType != null) {
      filtered = filtered.where((p) => p.type == _selectedProviderType).toList();
    }

    if (_selectedSpecialty != null && _selectedSpecialty!.isNotEmpty) {
      filtered = filtered.where((p) => p.specialty == _selectedSpecialty).toList();
    }

    if (_selectedLocation != null && _selectedLocation!.isNotEmpty) {
      filtered = filtered.where((p) => p.location == _selectedLocation).toList();
    }

    if (_onlineOnly) {
      filtered = filtered.where((p) => p.isOnlineAvailable).toList();
    }

    _filteredProviders = filtered;
  }

  // Update filter
  void updateFilter({
    AppointmentType? providerType,
    String? specialty,
    String? location,
    bool? onlineOnly,
  }) {
    _selectedProviderType = providerType;
    _selectedSpecialty = specialty;
    _selectedLocation = location;
    _onlineOnly = onlineOnly ?? false;
    
    _filteredProviders = List.from(_allProviders);
    _applyFilters();
    
    notifyListeners();
  }

  // Clear filters
  void clearFilters() {
    _selectedProviderType = null;
    _selectedSpecialty = null;
    _selectedLocation = null;
    _onlineOnly = false;
    _searchQuery = '';
    _filteredProviders = List.from(_allProviders);
    notifyListeners();
  }

  // Select provider
  void selectProvider(Provider provider) {
    _selectedProvider = provider;
    _selectedDate = null;
    _selectedTime = null;
    notifyListeners();
  }

  // Select date
  void selectDate(DateTime date) {
    _selectedDate = date;
    _selectedTime = null; // Reset time when date changes
    notifyListeners();
  }

  // Select time
  void selectTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  // Select consultation type
  void selectConsultationType(ConsultationType type) {
    _selectedConsultationType = type;
    notifyListeners();
  }

  // Create appointment
  Future<Appointment?> createAppointment() async {
    if (_selectedProvider == null || _selectedDate == null || _selectedTime == null) {
      _errorMessage = 'Please select all required fields';
      return null;
    }

    _setState(AppointmentViewState.loading);
    try {
      final appointment = await _appointmentService.createAppointment(
        providerId: _selectedProvider!.id,
        providerName: _selectedProvider!.name,
        providerPhoto: _selectedProvider!.photo,
        specialty: _selectedProvider!.specialty,
        date: _selectedDate!,
        time: _selectedTime!,
        type: _selectedProvider!.type,
        consultationType: _selectedConsultationType,
        location: _selectedConsultationType == ConsultationType.inPerson
            ? _selectedProvider!.hospital
            : null,
        fee: _selectedProvider!.fee,
      );

      // Refresh appointments
      await fetchAppointments();

      _setState(AppointmentViewState.success);
      return appointment;
    } catch (e) {
      _errorMessage = e.toString();
      _setState(AppointmentViewState.error);
      return null;
    }
  }

  // Reschedule appointment
  Future<bool> rescheduleAppointment(
    String appointmentId,
    DateTime newDate,
    String newTime,
  ) async {
    _setState(AppointmentViewState.loading);
    try {
      await _appointmentService.rescheduleAppointment(
        appointmentId: appointmentId,
        newDate: newDate,
        newTime: newTime,
      );

      // Refresh appointments
      await fetchAppointments();

      _setState(AppointmentViewState.success);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _setState(AppointmentViewState.error);
      return false;
    }
  }

  // Cancel appointment
  Future<bool> cancelAppointment(String appointmentId) async {
    _setState(AppointmentViewState.loading);
    try {
      final success = await _appointmentService.cancelAppointment(appointmentId);

      if (success) {
        // Refresh appointments
        await fetchAppointments();
      }

      _setState(AppointmentViewState.success);
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      _setState(AppointmentViewState.error);
      return false;
    }
  }

  // Reset booking state
  void resetBookingState() {
    _selectedProvider = null;
    _selectedDate = null;
    _selectedTime = null;
    _selectedConsultationType = ConsultationType.online;
    notifyListeners();
  }

  // Private helper to set state
  void _setState(AppointmentViewState newState) {
    _state = newState;
    notifyListeners();
  }
}
