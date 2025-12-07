import 'package:flutter/material.dart';
import 'package:healthx_patient/configs/route_generator.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import 'package:provider/provider.dart';

import '../../data/models/appointment_model.dart';
import '../viewmodels/appointment_viewmodel.dart';
import '../widgets/provider_card_widget.dart';

class ProviderSelectionScreen extends StatefulWidget {
  const ProviderSelectionScreen({super.key});

  @override
  State<ProviderSelectionScreen> createState() =>
      _ProviderSelectionScreenState();
}

class _ProviderSelectionScreenState extends State<ProviderSelectionScreen> {
  late AppointmentViewModel _viewModel;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = AppointmentViewModel();
    _loadProviders();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _loadProviders() async {
    await _viewModel.fetchProviders();
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.white,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Search & Filters',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<AppointmentType>(
                    value: _viewModel.selectedProviderType,
                    items: const [
                      DropdownMenuItem(value: null, child: Text('All Types')),
                      DropdownMenuItem(
                        value: AppointmentType.doctor,
                        child: Text('Doctor'),
                      ),
                      DropdownMenuItem(
                        value: AppointmentType.lab,
                        child: Text('Lab'),
                      ),
                      DropdownMenuItem(
                        value: AppointmentType.specialist,
                        child: Text('Specialist'),
                      ),
                    ],
                    onChanged: (v) {
                      setModalState(() {
                        _viewModel.updateFilter(providerType: v);
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Provider Type',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _viewModel.selectedSpecialty,
                    items: [
                      const DropdownMenuItem(
                          value: null, child: Text('All Specialties')),
                      ..._viewModel.availableSpecialties.map(
                        (s) => DropdownMenuItem(value: s, child: Text(s)),
                      ),
                    ],
                    onChanged: (v) {
                      setModalState(() {
                        _viewModel.updateFilter(specialty: v);
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Specialty',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _viewModel.selectedLocation,
                    items: [
                      const DropdownMenuItem(
                          value: null, child: Text('All Locations')),
                      ..._viewModel.availableLocations.map(
                        (l) => DropdownMenuItem(value: l, child: Text(l)),
                      ),
                    ],
                    onChanged: (v) {
                      setModalState(() {
                        _viewModel.updateFilter(location: v);
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CheckboxListTile(
                    value: _viewModel.onlineOnly,
                    onChanged: (v) {
                      setModalState(() {
                        _viewModel.updateFilter(onlineOnly: v);
                      });
                    },
                    title: const Text('Online Consultation Only'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setModalState(() {
                              _viewModel.clearFilters();
                            });
                          },
                          child: const Text('Clear'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Provider'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_outlined)),
          actions: [
            IconButton(
              onPressed: _showFilterSheet,
              icon: const Icon(Icons.tune_rounded),
            ),
          ],
        ),
        body: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: (query) {
                  _viewModel.searchProviders(query);
                },
                decoration: InputDecoration(
                  hintText: 'Search by name or specialty',
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.buttonColor),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            // Provider list
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
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(viewModel.errorMessage ?? 'An error occurred'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadProviders,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  final providers = viewModel.filteredProviders;

                  if (providers.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_search,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No providers found',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: providers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final provider = providers[index];
                      return ProviderCardWidget(
                        provider: provider,
                        onBookNow: () {
                          viewModel.selectProvider(provider);
                          Navigator.of(context).pushNamed(
                            RouteGenerator.datetimeSelectionRoute,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
