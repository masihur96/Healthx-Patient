import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthx_patient/configs/custom_size.dart';
import 'package:healthx_patient/configs/custom_theme.dart';
import 'package:healthx_patient/configs/route_generator.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import 'package:healthx_patient/features/home_tab/drawer_screen.dart';

class DoctorScreen extends StatefulWidget {
  final bool isForm;
  const DoctorScreen({super.key, required this.isForm});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  String _selectedSpecialty = 'All';
  String _selectedAvailability = 'Today';
  String _selectedType = 'Online';

  final List<String> _specialties = <String>[
    'All',
    'Cardiologist',
    'Dentist',
    'Dermatologist',
    'Neurologist',
  ];

  final List<Map<String, dynamic>> _doctors = <Map<String, dynamic>>[
    {
      'name': 'Dr. Masihur Rahman',
      'avatar': 'assets/images/onboard.jpg',
      'specialty': 'Cardiologist',
      'rating': 4.8,
      'experience': '10+ Years',
      'hospital': 'City Heart Clinic',
      'reviews': 128,
      'fee': 30.0,
    },
    {
      'name': 'Dr. Ayesha Karim',
      'avatar': 'assets/images/onboarding_preview1.png',
      'specialty': 'Dentist',
      'rating': 4.7,
      'experience': '8 Years',
      'hospital': 'Smile Care Dental',
      'reviews': 96,
      'fee': 25.0,
    },
    {
      'name': 'Dr. Rafiul Hasan',
      'avatar': 'assets/images/onboard.jpg',
      'specialty': 'Dermatologist',
      'rating': 4.9,
      'experience': '12 Years',
      'hospital': 'Skin & Care Center',
      'reviews': 210,
      'fee': 28.0,
    },
    {
      'name': 'Dr. Ayesha Karim',
      'avatar': 'assets/images/onboarding_preview1.png',
      'specialty': 'Dentist',
      'rating': 4.7,
      'experience': '8 Years',
      'hospital': 'Smile Care Dental',
      'reviews': 96,
      'fee': 25.0,
    },
  ];

  List<Map<String, dynamic>> get _filteredDoctors {
    final q = _searchCtrl.text.trim().toLowerCase();
    return _doctors.where((d) {
      final matchQuery = q.isEmpty ||
          d['name'].toString().toLowerCase().contains(q) ||
          d['specialty'].toString().toLowerCase().contains(q);
      final matchSpec =
          _selectedSpecialty == 'All' || d['specialty'] == _selectedSpecialty;
      return matchQuery && matchSpec;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Row(
                children: [
                  widget.isForm
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios_outlined))
                      : SizedBox(),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Find a Doctor',
                    style: TextStyle(
                        fontSize: screenSize(context, .05),
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: _openFiltersSheet,
                    icon: const Icon(Icons.tune_rounded),
                  ),
                  widget.isForm
                      ? SizedBox()
                      : Builder(
                          builder: (ctx) => GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Icon(
                                Icons.menu,
                                size: screenSize(context, .08),
                              ),
                            ),
                            onTap: () {
                              z.toggle?.call();
                              HapticFeedback.selectionClick();
                            },
                          ),
                        ),
                  const SizedBox(width: 8),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: _SearchBar(
                  controller: _searchCtrl,
                  onChanged: (_) => setState(() {}),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  itemBuilder: (context, index) {
                    final d = _filteredDoctors[index];
                    return _DoctorCard(
                      data: d,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          RouteGenerator.doctorDetailRoute,
                          arguments: d,
                        );
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemCount: _filteredDoctors.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openFiltersSheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.white,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Search & Filters',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedSpecialty,
                items: _specialties
                    .map((e) =>
                        DropdownMenuItem<String>(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => _selectedSpecialty = v ?? 'All'),
                decoration: const InputDecoration(
                  labelText: 'Specialty',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedAvailability,
                items: const [
                  DropdownMenuItem(value: 'Today', child: Text('Today')),
                  DropdownMenuItem(value: 'Tomorrow', child: Text('Tomorrow')),
                  DropdownMenuItem(
                      value: 'This Week', child: Text('This Week')),
                ],
                onChanged: (v) =>
                    setState(() => _selectedAvailability = v ?? 'Today'),
                decoration: const InputDecoration(
                  labelText: 'Availability',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedType,
                items: const [
                  DropdownMenuItem(value: 'Online', child: Text('Online')),
                  DropdownMenuItem(
                      value: 'In-person', child: Text('In-person')),
                ],
                onChanged: (v) => setState(() => _selectedType = v ?? 'Online'),
                decoration: const InputDecoration(
                  labelText: 'Consultation Type',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Apply Filters',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
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
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;
  const _DoctorCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: boxStyle(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(12), // your desired radius
                  child: Image.asset(
                    data['avatar'],
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['name'],
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(data['specialty'],
                          style: TextStyle(color: Colors.grey.shade600)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text('${data['rating']}'),
                          const SizedBox(width: 12),
                          const Icon(Icons.badge_rounded, size: 18),
                          const SizedBox(width: 4),
                          Text(data['experience']),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 30,
                                child: ElevatedButton(
                                  onPressed: onTap,
                                  child: const Text(
                                    'Consult Now',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
