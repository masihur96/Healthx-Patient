import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import 'package:healthx_patient/features/home_tab/data/search_dummy_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounceTimer;
  int _selectedIndex = 0; // 0 = Patient, 1 = Medicine

  List<PatientItem> _patientResults = [];
  List<DrugItem> _drugResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 450), () {
      final query = _controller.text.trim();
      if (query.length > 2) {
        setState(() {
          _isLoading = true;
        });

        // Simulate network delay
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            setState(() {
              if (_selectedIndex == 0) {
                _patientResults = SearchDummyData.searchPatients(query);
              } else {
                _drugResults = SearchDummyData.searchDrugs(query);
              }
              _isLoading = false;
            });
          }
        });
      } else {
        setState(() {
          _patientResults = [];
          _drugResults = [];
          _isLoading = false;
        });
      }
    });
  }

  void _clearSearch() {
    _controller.clear();
    setState(() {
      _patientResults = [];
      _drugResults = [];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          _buildToggle(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: _selectedIndex == 0
                    ? 'Type Patient name...'
                    : 'Type Medicine name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        onPressed: _clearSearch,
                        icon: const Icon(Icons.clear),
                      )
                    : null,
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                final v = value.trim();
                if (v.length > 2) {
                  setState(() {
                    _isLoading = true;
                  });

                  Future.delayed(const Duration(milliseconds: 300), () {
                    if (mounted) {
                      setState(() {
                        if (_selectedIndex == 0) {
                          _patientResults = SearchDummyData.searchPatients(v);
                        } else {
                          _drugResults = SearchDummyData.searchDrugs(v);
                        }
                        _isLoading = false;
                      });
                    }
                  });
                }
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: ChoiceChip(
              label: const Text('Patient'),
              selected: _selectedIndex == 0,
              onSelected: (v) {
                if (!v) return;
                setState(() {
                  _selectedIndex = 0;
                  _patientResults = [];
                  _drugResults = [];
                });
                _onChanged();
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ChoiceChip(
              label: const Text('Medicine'),
              selected: _selectedIndex == 1,
              onSelected: (v) {
                if (!v) return;
                setState(() {
                  _selectedIndex = 1;
                  _patientResults = [];
                  _drugResults = [];
                });
                _onChanged();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    final queryEmpty = _controller.text.trim().isEmpty;
    if (queryEmpty) {
      return const Center(
        child: Text('Start typing to search'),
      );
    }

    if (_selectedIndex == 0) {
      if (_patientResults.isEmpty) {
        return const Center(child: Text('No Patient found'));
      }
      return ListView.separated(
        itemCount: _patientResults.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (context, index) {
          final patient = _patientResults[index];
          return _buildPatientCard(patient);
        },
      );
    } else {
      if (_drugResults.isEmpty) {
        return const Center(child: Text('No Medicine found'));
      }
      return ListView.separated(
        itemCount: _drugResults.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (context, index) {
          final drug = _drugResults[index];
          return _buildDrugCard(drug);
        },
      );
    }
  }

  Widget _buildPatientCard(PatientItem patient) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0.5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text(
            patient.name[0].toUpperCase(),
            style: TextStyle(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          patient.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('${patient.age} years • ${patient.bloodGroup}'),
            Text(patient.phone, style: const TextStyle(fontSize: 12)),
          ],
        ),
        isThreeLine: true,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Handle patient selection
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: ${patient.name}')),
          );
        },
      ),
    );
  }

  Widget _buildDrugCard(DrugItem drug) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0.5,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.medication,
            color: Colors.green.shade700,
          ),
        ),
        title: Text(
          drug.brandName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('${drug.genericName} • ${drug.form}'),
            Text(drug.companyName, style: const TextStyle(fontSize: 12)),
          ],
        ),
        isThreeLine: true,
        trailing: IconButton(
          onPressed: () {
            // Handle favorite toggle
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${drug.brandName} options')),
            );
          },
          icon: const Icon(Icons.more_horiz_outlined),
        ),
      ),
    );
  }
}
