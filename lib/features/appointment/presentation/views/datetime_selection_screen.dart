import 'package:flutter/material.dart';
import 'package:healthx_patient/configs/custom_theme.dart';
import 'package:healthx_patient/configs/route_generator.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import 'package:provider/provider.dart';

import '../../data/models/appointment_model.dart';
import '../viewmodels/appointment_viewmodel.dart';

class DateTimeSelectionScreen extends StatefulWidget {
  final Map<String, dynamic>? arguments;

  const DateTimeSelectionScreen({super.key, this.arguments});

  @override
  State<DateTimeSelectionScreen> createState() =>
      _DateTimeSelectionScreenState();
}

class _DateTimeSelectionScreenState extends State<DateTimeSelectionScreen> {
  late AppointmentViewModel _viewModel;
  bool _isReschedule = false;
  Appointment? _existingAppointment;

  final List<String> _timeSlots = const [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '04:30 PM',
    '05:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    _viewModel = AppointmentViewModel();

    if (widget.arguments != null) {
      _isReschedule = widget.arguments!['isReschedule'] ?? false;
      _existingAppointment = widget.arguments!['appointment'];

      if (_existingAppointment != null && !_isReschedule) {
        // If not reschedule, provider should be selected from previous screen
        // We'll use the viewmodel's selectedProvider
      }
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              _isReschedule ? 'Reschedule Appointment' : 'Select Date & Time'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_outlined)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Provider Info
              if (_viewModel.selectedProvider != null ||
                  _existingAppointment != null)
                Material(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: boxStyle(),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            _existingAppointment?.providerPhoto ??
                                _viewModel.selectedProvider?.photo ??
                                '',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: AppColors.grey,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.person, size: 30),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _existingAppointment?.providerName ??
                                    _viewModel.selectedProvider?.name ??
                                    '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _existingAppointment?.specialty ??
                                    _viewModel.selectedProvider?.specialty ??
                                    '',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              // Date Selection
              const Text(
                'Select Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Consumer<AppointmentViewModel>(
                builder: (context, viewModel, child) {
                  return _DateSelector(
                    selectedDate: viewModel.selectedDate,
                    onDateSelected: viewModel.selectDate,
                  );
                },
              ),
              const SizedBox(height: 20),
              // Time Selection
              const Text(
                'Select Time',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Consumer<AppointmentViewModel>(
                builder: (context, viewModel, child) {
                  return _TimeSelector(
                    timeSlots: _timeSlots,
                    selectedTime: viewModel.selectedTime,
                    onTimeSelected: viewModel.selectTime,
                  );
                },
              ),
              const SizedBox(height: 20),
              // Consultation Type
              const Text(
                'Consultation Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Consumer<AppointmentViewModel>(
                builder: (context, viewModel, child) {
                  return Material(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: boxStyle(),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          RadioListTile<ConsultationType>(
                            value: ConsultationType.online,
                            groupValue: viewModel.selectedConsultationType,
                            onChanged: (v) =>
                                viewModel.selectConsultationType(v!),
                            title: const Text('Online Video Consultation'),
                            subtitle: const Text('Connect via video call'),
                          ),
                          RadioListTile<ConsultationType>(
                            value: ConsultationType.inPerson,
                            groupValue: viewModel.selectedConsultationType,
                            onChanged: (v) =>
                                viewModel.selectConsultationType(v!),
                            title: const Text('In-Person Visit'),
                            subtitle: const Text('Visit the clinic'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              // Continue Button
              Consumer<AppointmentViewModel>(
                builder: (context, viewModel, child) {
                  final canContinue = viewModel.selectedDate != null &&
                      viewModel.selectedTime != null;

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: canContinue
                          ? () {
                              if (_isReschedule &&
                                  _existingAppointment != null) {
                                // Handle reschedule
                                Navigator.of(context).pushNamed(
                                  RouteGenerator.appointmentConfirmationRoute,
                                  arguments: {
                                    'isReschedule': true,
                                    'appointment': _existingAppointment,
                                  },
                                );
                              } else {
                                // New appointment
                                Navigator.of(context).pushNamed(
                                  RouteGenerator.appointmentConfirmationRoute,
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateSelector extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const _DateSelector({
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final dates =
        List.generate(14, (i) => DateTime.now().add(Duration(days: i)));

    return Material(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: boxStyle(),
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final date = dates[index];
              final isSelected = selectedDate != null &&
                  date.day == selectedDate!.day &&
                  date.month == selectedDate!.month &&
                  date.year == selectedDate!.year;

              return InkWell(
                onTap: () => onDateSelected(date),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 70,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.buttonColor
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _getDayName(date.weekday),
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              isSelected ? Colors.white : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                      Text(
                        _getMonthName(date.month),
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              isSelected ? Colors.white : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}

class _TimeSelector extends StatelessWidget {
  final List<String> timeSlots;
  final String? selectedTime;
  final ValueChanged<String> onTimeSelected;

  const _TimeSelector({
    required this.timeSlots,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: boxStyle(),
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: timeSlots.map((time) {
            final isSelected = time == selectedTime;
            return InkWell(
              onTap: () => onTimeSelected(time),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color:
                      isSelected ? AppColors.buttonColor : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.buttonColor
                        : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
