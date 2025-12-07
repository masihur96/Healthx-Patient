import 'package:flutter/material.dart';
import 'package:healthx_patient/configs/custom_theme.dart';
import 'package:healthx_patient/configs/route_generator.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import 'package:provider/provider.dart';

import '../../data/models/appointment_model.dart';
import '../viewmodels/appointment_viewmodel.dart';
import '../widgets/appointment_summary_widget.dart';

class AppointmentConfirmationScreen extends StatefulWidget {
  final Map<String, dynamic>? arguments;

  const AppointmentConfirmationScreen({super.key, this.arguments});

  @override
  State<AppointmentConfirmationScreen> createState() =>
      _AppointmentConfirmationScreenState();
}

class _AppointmentConfirmationScreenState
    extends State<AppointmentConfirmationScreen> {
  late AppointmentViewModel _viewModel;
  String _paymentMethod = 'Wallet';
  bool _isReschedule = false;
  Appointment? _existingAppointment;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _viewModel = AppointmentViewModel();

    if (widget.arguments != null) {
      _isReschedule = widget.arguments!['isReschedule'] ?? false;
      _existingAppointment = widget.arguments!['appointment'];
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _confirmAppointment() async {
    setState(() => _isProcessing = true);

    if (_isReschedule && _existingAppointment != null) {
      // Reschedule existing appointment
      final success = await _viewModel.rescheduleAppointment(
        _existingAppointment!.id,
        _viewModel.selectedDate!,
        _viewModel.selectedTime!,
      );

      setState(() => _isProcessing = false);

      if (success && mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteGenerator.appointmentSuccessRoute,
          (route) => route.settings.name == RouteGenerator.appointmentHomeRoute,
          arguments: {
            'isReschedule': true,
            'appointmentId': _existingAppointment!.appointmentId,
          },
        );
      }
    } else {
      // Create new appointment
      final appointment = await _viewModel.createAppointment();

      setState(() => _isProcessing = false);

      if (appointment != null && mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteGenerator.appointmentSuccessRoute,
          (route) => route.settings.name == RouteGenerator.appointmentHomeRoute,
          arguments: {
            'appointment': appointment,
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              _isReschedule ? 'Confirm Reschedule' : 'Confirm Appointment'),
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
              // Appointment Summary (Mock data for now)
              Consumer<AppointmentViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.selectedProvider == null &&
                      _existingAppointment == null) {
                    return const Center(child: Text('No appointment data'));
                  }

                  // Create temporary appointment for display
                  final tempAppointment = Appointment(
                    id: _existingAppointment?.id ?? 'temp',
                    providerId: _existingAppointment?.providerId ??
                        viewModel.selectedProvider?.id ??
                        '',
                    providerName: _existingAppointment?.providerName ??
                        viewModel.selectedProvider?.name ??
                        '',
                    providerPhoto: _existingAppointment?.providerPhoto ??
                        viewModel.selectedProvider?.photo ??
                        '',
                    specialty: _existingAppointment?.specialty ??
                        viewModel.selectedProvider?.specialty ??
                        '',
                    date: viewModel.selectedDate ?? DateTime.now(),
                    time: viewModel.selectedTime ?? '',
                    type: _existingAppointment?.type ??
                        viewModel.selectedProvider?.type ??
                        AppointmentType.doctor,
                    consultationType: viewModel.selectedConsultationType,
                    status: AppointmentStatus.pending,
                    location: viewModel.selectedConsultationType ==
                            ConsultationType.inPerson
                        ? (_existingAppointment?.location ??
                            viewModel.selectedProvider?.hospital)
                        : null,
                    fee: _existingAppointment?.fee ??
                        viewModel.selectedProvider?.fee ??
                        0,
                    appointmentId: _existingAppointment?.appointmentId ?? 'TBD',
                    createdAt: DateTime.now(),
                  );

                  return AppointmentSummaryWidget(appointment: tempAppointment);
                },
              ),
              const SizedBox(height: 20),
              // Payment Method
              Consumer<AppointmentViewModel>(
                builder: (context, viewModel, child) {
                  final fee = _existingAppointment?.fee ??
                      viewModel.selectedProvider?.fee ??
                      0;

                  if (fee <= 0) {
                    return const SizedBox.shrink();
                  }

                  return Material(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: boxStyle(),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Payment Method',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          RadioListTile<String>(
                            value: 'Wallet',
                            groupValue: _paymentMethod,
                            onChanged: (v) =>
                                setState(() => _paymentMethod = v!),
                            title: const Text('Wallet'),
                          ),
                          RadioListTile<String>(
                            value: 'Card',
                            groupValue: _paymentMethod,
                            onChanged: (v) =>
                                setState(() => _paymentMethod = v!),
                            title: const Text('Credit/Debit Card'),
                          ),
                          RadioListTile<String>(
                            value: 'Cash',
                            groupValue: _paymentMethod,
                            onChanged: (v) =>
                                setState(() => _paymentMethod = v!),
                            title: const Text('Cash on Arrival'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              // Confirm Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isProcessing ? null : _confirmAppointment,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isProcessing
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          _isReschedule
                              ? 'Confirm Reschedule'
                              : 'Confirm Appointment',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
