// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// class MedicineSearchScreen extends StatefulWidget {
//   const MedicineSearchScreen({super.key});
//
//   @override
//   State<MedicineSearchScreen> createState() => _MedicineSearchScreenState();
// }
//
// class _MedicineSearchScreenState extends State<MedicineSearchScreen> {
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
//         //    context.read<MedicineViewModel>().searchMedicine(query: query);
//       } else {
//         //   context.read<MedicineViewModel>().clearSearchResults();
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
//         title: const Text('Search Medicine'),
//         centerTitle: true,
//       ),
//       // body: Consumer<MedicineViewModel>(
//       //   builder: (context, vm, _) {
//       //     return Column(
//       //       children: [
//       //         Padding(
//       //           padding: const EdgeInsets.all(16.0),
//       //           child: TextField(
//       //             controller: _controller,
//       //             autofocus: true,
//       //             decoration: InputDecoration(
//       //               hintText: 'Type Medicine name...',
//       //               prefixIcon: const Icon(Icons.search),
//       //               border: OutlineInputBorder(
//       //                 borderRadius: BorderRadius.circular(12),
//       //               ),
//       //               suffixIcon: _controller.text.isNotEmpty
//       //                   ? IconButton(
//       //                       onPressed: () async {
//       //                         _controller.clear();
//       //                         vm.clearSearchResults();
//       //                         await vm.fetchMedicineData();
//       //                       },
//       //                       icon: const Icon(Icons.clear),
//       //                     )
//       //                   : null,
//       //             ),
//       //             textInputAction: TextInputAction.search,
//       //             onSubmitted: (value) {
//       //               final v = value.trim();
//       //               if (v.length > 2) {
//       //                 vm.searchMedicine(query: v);
//       //               }
//       //             },
//       //           ),
//       //         ),
//       //         Expanded(
//       //           child: _buildResults(vm),
//       //         ),
//       //       ],
//       //     );
//       //   },
//       // ),
//     );
//   }
//
//   // Widget _buildResults(MedicineViewModel vm) {
//   //   if (vm.isLoading) {
//   //     return const Center(child: CircularProgressIndicator());
//   //   }
//   //   final List<DrugItem> drugs = vm.searchDrug;
//   //
//   //   if (_controller.text.trim().isEmpty) {
//   //     return const Center(
//   //       child: Text('Start typing to search Medicine'),
//   //     );
//   //   }
//   //   if (vm.error != null) {
//   //     return Center(
//   //       child: Column(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: [
//   //           Text(vm.error!),
//   //           const SizedBox(height: 12),
//   //           ElevatedButton(
//   //             onPressed: () {
//   //               final q = _controller.text.trim();
//   //               if (q.length > 2) vm.searchMedicine(query: q);
//   //             },
//   //             child: const Text('Retry'),
//   //           ),
//   //         ],
//   //       ),
//   //     );
//   //   }
//   //   if (drugs.isEmpty) {
//   //     return const Center(child: Text('No Medicine found'));
//   //   }
//   //   return ListView.separated(
//   //     itemCount: drugs.length,
//   //     separatorBuilder: (_, __) => const SizedBox(height: 8),
//   //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//   //     itemBuilder: (context, index) {
//   //       final drug = drugs[index];
//   //       return Card(
//   //         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//   //         shape:
//   //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//   //         elevation: .5,
//   //         child: Stack(
//   //           children: [
//   //             ListTile(
//   //               title: Text(drug.brandName),
//   //               subtitle: Text('${drug.genericName} • ${drug.companyName}'),
//   //               trailing: Text(drug.form),
//   //             ),
//   //             Positioned(
//   //               right: 0,
//   //               top: -5,
//   //               child: IconButton(
//   //                 onPressed: () {},
//   //                 icon: Icon(Icons.more_horiz_outlined),
//   //               ),
//   //             )
//   //           ],
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
//   //
//   // String _initials(String name) {
//   //   final parts = name.trim().split(' ');
//   //   if (parts.length >= 2) return parts[1];
//   //   return parts.first;
//   // }
// }
