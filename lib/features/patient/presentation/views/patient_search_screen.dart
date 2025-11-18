// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:medicare_doctor/features/patient/data/models/patient_model.dart';
// import 'package:medicare_doctor/features/patient/presentation/viewmodels/patient_view_model.dart';
// import 'package:medicare_doctor/features/patient/presentation/views/widgets/patient_card.dart';
// import 'package:provider/provider.dart';
//
// class PatientSearchScreen extends StatefulWidget {
//   const PatientSearchScreen({super.key});
//
//   @override
//   State<PatientSearchScreen> createState() => _PatientSearchScreenState();
// }
//
// class _PatientSearchScreenState extends State<PatientSearchScreen> {
//   final TextEditingController _controller = TextEditingController();
//   Timer? _debounceTimer;
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
//         context.read<PatientViewModel>().searchPatientData(query: query);
//       } else {
//         context.read<PatientViewModel>().clearSearchResults();
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
//           icon: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: const Icon(Icons.arrow_back_ios),
//           ),
//         ),
//         title: const Text('Search Patient'),
//         centerTitle: true,
//       ),
//       body: Consumer<PatientViewModel>(
//         builder: (context, vm, _) {
//           return Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: TextField(
//                   controller: _controller,
//                   autofocus: true,
//                   decoration: InputDecoration(
//                     hintText: 'Type Patient name...',
//                     prefixIcon: const Icon(Icons.search),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     suffixIcon: _controller.text.isNotEmpty
//                         ? IconButton(
//                             onPressed: () async {
//                               _controller.clear();
//                               vm.clearSearchResults();
//                               await vm.fetchPatientListData();
//                             },
//                             icon: const Icon(Icons.clear),
//                           )
//                         : null,
//                   ),
//                   textInputAction: TextInputAction.search,
//                   onSubmitted: (value) {
//                     final v = value.trim();
//                     if (v.length > 2) {
//                       vm.searchPatientData(query: v);
//                     }
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: _buildResults(vm),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildResults(PatientViewModel vm) {
//     if (vm.isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//     final List<PatientItem> patients = vm.searchPatient;
//
//     if (_controller.text.trim().isEmpty) {
//       return const Center(
//         child: Text('Start typing to search Medicine'),
//       );
//     }
//     if (vm.error != null) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(vm.error!),
//             const SizedBox(height: 12),
//             ElevatedButton(
//               onPressed: () {
//                 final q = _controller.text.trim();
//                 if (q.length > 2) vm.searchPatientData(query: q);
//               },
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       );
//     }
//     if (patients.isEmpty) {
//       return const Center(child: Text('No Medicine found'));
//     }
//     return ListView.separated(
//       itemCount: patients.length,
//       separatorBuilder: (_, __) => const SizedBox(height: 8),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       itemBuilder: (context, index) {
//         final patient = patients[index];
//         return PatientCard(patient: patient);
//         ;
//       },
//     );
//   }
// }
