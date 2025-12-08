import 'package:flutter/material.dart';
import 'package:healthx_patient/configs/custom_size.dart';
import 'package:healthx_patient/configs/route_generator.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import 'package:provider/provider.dart';

import '../../data/models/appointment_model.dart';
import '../viewmodels/appointment_viewmodel.dart';
import '../widgets/appointment_card_widget.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late AppointmentViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _viewModel = AppointmentViewModel();
    _loadAppointments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _loadAppointments() async {
    await _viewModel.fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pushNamed(
              RouteGenerator.providerSelectionRoute,
            );
          },
          icon: const Icon(Icons.add, size: 18, color: Colors.white),
          label: const Text(
            'New Appointment',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_outlined),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Text(
                            'Appointments',
                            style: TextStyle(
                              fontSize: screenSize(context, .05),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,

                  // Text Colors
                  labelColor: AppColors.buttonColor, // Selected text color
                  unselectedLabelColor:
                      Colors.grey.shade600, // Unselected text color

                  // Text Styles
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),

                  // Indicator Style
                  indicatorColor: AppColors.buttonColor,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.tab,

                  tabs: const [
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Past'),
                    Tab(text: 'Cancelled'),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              // TabBarView
              Expanded(
                child: Consumer<AppointmentViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.state == AppointmentViewState.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (viewModel.state == AppointmentViewState.error) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline,
                                size: 48, color: Colors.red),
                            const SizedBox(height: 16),
                            Text(viewModel.errorMessage ?? 'An error occurred'),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _loadAppointments,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    return TabBarView(
                      controller: _tabController,
                      children: [
                        _AppointmentList(
                          appointments: viewModel.upcomingAppointments,
                          emptyMessage: 'No upcoming appointments',
                          onRefresh: _loadAppointments,
                        ),
                        _AppointmentList(
                          appointments: viewModel.pastAppointments,
                          emptyMessage: 'No past appointments',
                          onRefresh: _loadAppointments,
                        ),
                        _AppointmentList(
                          appointments: viewModel.cancelledAppointments,
                          emptyMessage: 'No cancelled appointments',
                          onRefresh: _loadAppointments,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppointmentList extends StatelessWidget {
  final List<Appointment> appointments;
  final String emptyMessage;
  final Future<void> Function() onRefresh;

  const _AppointmentList({
    required this.appointments,
    required this.emptyMessage,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: appointments.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return AppointmentCardWidget(
            appointment: appointment,
            onTap: () {
              Navigator.of(context).pushNamed(
                RouteGenerator.appointmentManagementRoute,
                arguments: appointment,
              );
            },
            onReschedule: () async {
              // final viewModel = context.read<AppointmentViewModel>();
              // viewModel.selectProvider(null); // Will need to fetch provider
              // viewModel.selectDate(appointment.date);
              // viewModel.selectTime(appointment.time);
              //
              // final result = await Navigator.of(context).pushNamed(
              //   RouteGenerator.datetimeSelectionRoute,
              //   arguments: {
              //     'appointment': appointment,
              //     'isReschedule': true,
              //   },
              // );
              //
              // if (result == true && context.mounted) {
              //   onRefresh();
              // }
            },
            onCancel: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Cancel Appointment'),
                  content: const Text(
                    'Are you sure you want to cancel this appointment?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text(
                        'Yes, Cancel',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );

              if (confirmed == true && context.mounted) {
                final viewModel = context.read<AppointmentViewModel>();
                final success =
                    await viewModel.cancelAppointment(appointment.id);

                if (success && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Appointment cancelled successfully'),
                    ),
                  );
                  onRefresh();
                }
              }
            },
          );
        },
      ),
    );
  }
}
