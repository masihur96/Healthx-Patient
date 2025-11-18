// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _controller = TextEditingController();
//   Timer? _debounceTimer;
//   int _selectedIndex = 0; // 0 = Patient, 1 = Medicine
//
//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(_onChanged);
//   }
//
//   @override
//   void dispose() {
//     _debounceTimer?.cancel();
//     _controller.removeListener(_onChanged);
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _onChanged() {
//     _debounceTimer?.cancel();
//     _debounceTimer = Timer(const Duration(milliseconds: 450), () {
//       final query = _controller.text.trim();
//       if (query.length > 2) {
//         if (_selectedIndex == 0) {
//           context.read<PatientViewModel>().searchPatientData(query: query);
//         } else {
//           context.read<MedicineViewModel>().searchMedicine(query: query);
//         }
//       } else {
//         if (_selectedIndex == 0) {
//           context.read<PatientViewModel>().clearSearchResults();
//         } else {
//           context.read<MedicineViewModel>().clearSearchResults();
//         }
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8.0),
//             child: Icon(Icons.arrow_back_ios),
//           ),
//         ),
//         title: const Text('Search'),
//         centerTitle: true,
//       ),
//       body: Consumer2<PatientViewModel, MedicineViewModel>(
//         builder: (context, pvm, mvm, _) {
//           final isLoading = _selectedIndex == 0 ? pvm.isLoading : mvm.isLoading;
//           final hasError = _selectedIndex == 0 ? pvm.error : mvm.error;
//           return Column(
//             children: [
//               const SizedBox(height: 8),
//               _buildToggle(),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: TextField(
//                   controller: _controller,
//                   autofocus: true,
//                   decoration: InputDecoration(
//                     hintText: _selectedIndex == 0
//                         ? 'Type Patient name...'
//                         : 'Type Medicine name...',
//                     prefixIcon: const Icon(Icons.search),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     suffixIcon: _controller.text.isNotEmpty
//                         ? IconButton(
//                             onPressed: () async {
//                               _controller.clear();
//                               if (_selectedIndex == 0) {
//                                 pvm.clearSearchResults();
//                                 await pvm.fetchPatientListData();
//                               } else {
//                                 mvm.clearSearchResults();
//                                 await mvm.fetchMedicineData();
//                               }
//                             },
//                             icon: const Icon(Icons.clear),
//                           )
//                         : null,
//                   ),
//                   textInputAction: TextInputAction.search,
//                   onSubmitted: (value) {
//                     final v = value.trim();
//                     if (v.length > 2) {
//                       if (_selectedIndex == 0) {
//                         pvm.searchPatientData(query: v);
//                       } else {
//                         mvm.searchMedicine(query: v);
//                       }
//                     }
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: isLoading
//                     ? const Center(child: CircularProgressIndicator())
//                     : _buildResults(pvm, mvm, hasError),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildToggle() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: ChoiceChip(
//               label: const Text('Patient'),
//               selected: _selectedIndex == 0,
//               onSelected: (v) {
//                 if (!v) return;
//                 setState(() {
//                   _selectedIndex = 0;
//                 });
//                 _onChanged();
//               },
//             ),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: ChoiceChip(
//               label: const Text('Medicine'),
//               selected: _selectedIndex == 1,
//               onSelected: (v) {
//                 if (!v) return;
//                 setState(() {
//                   _selectedIndex = 1;
//                 });
//                 _onChanged();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildResults(
//       PatientViewModel pvm, MedicineViewModel mvm, String? error) {
//     final queryEmpty = _controller.text.trim().isEmpty;
//     if (queryEmpty) {
//       return const Center(
//         child: Text('Start typing to search'),
//       );
//     }
//     if (error != null) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(error),
//             const SizedBox(height: 12),
//             ElevatedButton(
//               onPressed: () {
//                 final q = _controller.text.trim();
//                 if (q.length > 2) {
//                   if (_selectedIndex == 0) {
//                     pvm.searchPatientData(query: q);
//                   } else {
//                     mvm.searchMedicine(query: q);
//                   }
//                 }
//               },
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       );
//     }
//
//     if (_selectedIndex == 0) {
//       final List<PatientItem> patients = pvm.searchPatient;
//       if (patients.isEmpty) {
//         return const Center(child: Text('No Patient found'));
//       }
//       return ListView.separated(
//         itemCount: patients.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 8),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         itemBuilder: (context, index) {
//           final patient = patients[index];
//           return PatientCard(patient: patient);
//         },
//       );
//     } else {
//       final List<DrugItem> drugs = mvm.searchDrug;
//       if (drugs.isEmpty) {
//         return const Center(child: Text('No Medicine found'));
//       }
//       return ListView.separated(
//         itemCount: drugs.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 8),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         itemBuilder: (context, index) {
//           final drug = drugs[index];
//           return Card(
//             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             elevation: .5,
//             child: Stack(
//               children: [
//                 ListTile(
//                   title: Text(drug.brandName),
//                   subtitle: Text('${drug.genericName} • ${drug.companyName}'),
//                   trailing: Text(drug.form),
//                 ),
//                 Positioned(
//                   right: 0,
//                   top: -5,
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.more_horiz_outlined),
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       );
//     }
//   }
// }
