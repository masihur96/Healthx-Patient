// import 'package:flutter/material.dart';
// import 'package:healthx_patient/features/medicine/data/models/medication_model.dart';
// import 'package:healthx_patient/shared/app_snackbar.dart';
//
// import 'medicine_search_screen.dart';
//
// class MedicineScreen extends StatefulWidget {
//   const MedicineScreen({super.key});
//
//   @override
//   State<MedicineScreen> createState() => _MedicineScreenState();
// }
//
// class _MedicineScreenState extends State<MedicineScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   String _selectedFilter = 'All';
//   bool _isReversed = false;
//
//   final List<String> _filterOptions = ['All', 'Tablet', 'Syrup', 'injection'];
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // context.read<MedicineViewModel>().fetchMedicineData(forceRefresh: true);
//     });
//   }
//
//   void _onScroll() {
//     if (_scrollController.position.pixels >=
//         _scrollController.position.maxScrollExtent - 200) {
//       // Trigger load more when user is 200 pixels from the bottom
//       // final medicineVM = context.read<MedicineViewModel>();
//       // if (!medicineVM.isLoadingMore && medicineVM.hasMoreData) {
//       //   medicineVM.loadMoreAuthors();
//       // }
//     }
//   }
//
//   List<DrugItem> _getFilteredDrugs(List<DrugItem> drugs) {
//     List<DrugItem> filtered = drugs;
//
//     // Filter by selected tab
//     if (_selectedFilter != 'All') {
//       print("_selectedFilter:: $_selectedFilter");
//
//       filtered = filtered
//           .where((drug) =>
//               drug.form.toLowerCase() == _selectedFilter.toLowerCase())
//           .toList();
//     }
//
//     // Apply reverse if enabled
//     if (_isReversed) {
//       filtered = filtered.reversed.toList();
//     }
//
//     return filtered;
//   }
//
//   void _onFilterChanged(String filter) {
//     setState(() {
//       _selectedFilter = filter;
//     });
//
//     if (filter != "All") {
//       AppSnackBar.show(context,
//           message:
//               "We're working on this feature. It will be available in a future update.");
//     }
//   }
//
//   void _toggleReverse() {
//     setState(() {
//       _isReversed = !_isReversed;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Medicine List'),
//         centerTitle: false,
//       ),
//       body: SafeArea(
//           child: Column(
//         children: [
//           _buildSearchBar(),
//           _buildFilterButtons(),
//           // _buildResultsHeader(medicineVM),
//           // Expanded(child: _buildMedicineList(medicineVM)),
//         ],
//       )),
//     );
//   }
//
//   Widget _buildSearchBar() {
//     return GestureDetector(
//       onTap: () {
//         print("object");
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => const MedicineSearchScreen(),
//           ),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: TextField(
//           controller: _searchController,
//           decoration: InputDecoration(
//             hintText: 'Search medicine...',
//             prefixIcon: const Icon(Icons.search),
//             filled: true,
//             enabled: false,
//             fillColor: Colors.grey[200],
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFilterButtons() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: _filterOptions.map((filter) {
//           final bool isSelected = filter == _selectedFilter;
//           return ChoiceChip(
//             label: Text(filter),
//             selected: isSelected,
//             onSelected: (_) => _onFilterChanged(filter),
//             selectedColor: Colors.blue,
//             labelStyle:
//                 TextStyle(color: isSelected ? Colors.white : Colors.black),
//           );
//         }).toList(),
//       ),
//     );
//   }
//   //
//   // Widget _buildResultsHeader(MedicineViewModel medicineVM) {
//   //   final filteredDrugs = _getFilteredDrugs(medicineVM.drugs);
//   //   return Padding(
//   //     padding: const EdgeInsets.all(16.0),
//   //     child: Row(
//   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //       children: [
//   //         Text(
//   //           '${filteredDrugs.length} medicines found',
//   //           style: const TextStyle(fontWeight: FontWeight.bold),
//   //         ),
//   //         GestureDetector(
//   //           onTap: _toggleReverse,
//   //           child: Row(
//   //             children: [
//   //               Text(
//   //                 _isReversed ? 'Reversed' : 'Default',
//   //                 style: const TextStyle(fontWeight: FontWeight.bold),
//   //               ),
//   //               const SizedBox(width: 4),
//   //               Icon(
//   //                 _isReversed ? Icons.arrow_upward : Icons.arrow_downward,
//   //                 size: 18,
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//   //
//   // Widget _buildMedicineList(MedicineViewModel medicineVM) {
//   //   if (medicineVM.isLoading) {
//   //     return const Center(child: CircularProgressIndicator());
//   //   }
//   //
//   //   if (medicineVM.drugs.isEmpty) {
//   //     return const Center(child: Text('No medicines found'));
//   //   }
//   //
//   //   final filteredDrugs = _getFilteredDrugs(medicineVM.drugs);
//   //
//   //   if (filteredDrugs.isEmpty) {
//   //     return const Center(child: Text('No medicines found for this filter'));
//   //   }
//   //
//   //   return ListView.builder(
//   //     controller: _scrollController,
//   //     itemCount: filteredDrugs.length + (medicineVM.isLoadingMore ? 1 : 0),
//   //     itemBuilder: (context, index) {
//   //       // Show loading indicator at the bottom
//   //       if (index == filteredDrugs.length) {
//   //         return const Padding(
//   //           padding: EdgeInsets.all(16.0),
//   //           child: Center(
//   //             child: CircularProgressIndicator(),
//   //           ),
//   //         );
//   //       }
//   //       final drug = filteredDrugs[index];
//   //       return Card(
//   //         // color: Colors.white,
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
//   //                 onPressed: () {
//   //                   AppSnackBar.show(context,
//   //                       message:
//   //                           "We're working on this feature. It will be available in a future update.");
//   //                 },
//   //                 icon: Icon(Icons.more_horiz_outlined),
//   //               ),
//   //             )
//   //           ],
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
// }
