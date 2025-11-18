// import 'package:flutter/material.dart';
// import 'package:medicare_doctor/features/patient/data/models/patient_model.dart';
// import 'package:medicare_doctor/features/patient/presentation/viewmodels/patient_view_model.dart';
// import 'package:medicare_doctor/features/patient/presentation/views/patient_add_screen.dart';
// import 'package:medicare_doctor/features/patient/presentation/views/widgets/patient_card.dart';
// import 'package:medicare_doctor/shared/app_snackbar.dart';
// import 'package:medicare_doctor/shared/empty_placeholder.dart';
// import 'package:provider/provider.dart';
//
// class PatientScreen extends StatefulWidget {
//   final bool isForm;
//   const PatientScreen({super.key, required this.isForm});
//
//   @override
//   State<PatientScreen> createState() => _PatientScreenState();
// }
//
// class _PatientScreenState extends State<PatientScreen>
//     with SingleTickerProviderStateMixin {
//   String searchItem = "";
//   List<PatientItem> patientList = [];
//   List<PatientItem> filteredPatientList = [];
//   bool _isLoading = false;
//   late TabController _tabController;
//   int _selectedTabIndex = 0;
//   late ScrollController _scrollController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _scrollController = ScrollController();
//     _scrollController.addListener(_onScroll);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<PatientViewModel>().fetchPatientListData(forceRefresh: true);
//     });
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   void _onScroll() {
//     if (_scrollController.position.pixels >=
//         _scrollController.position.maxScrollExtent - 200) {
//       // Trigger load more when user is 200 pixels from the bottom
//       final patientVM = context.read<PatientViewModel>();
//       if (!patientVM.isLoadingMore && patientVM.hasMoreData) {
//         patientVM.loadMoreAuthors();
//       }
//     }
//   }
//
//   void _filterPatients(String searchTerm) {
//     setState(() {
//       searchItem = searchTerm;
//       if (searchTerm.isEmpty) {
//         filteredPatientList = patientList;
//       } else {
//         filteredPatientList = patientList.where((patient) {
//           final fullName = "${patient} ${patient.lastname}".toLowerCase();
//           return fullName.contains(searchTerm.toLowerCase());
//         }).toList();
//       }
//     });
//   }
//
//   void _onTabChanged(int index) {
//     setState(() {
//       _selectedTabIndex = index;
//       // Filter patients based on tab
//       switch (index) {
//         case 0: // All
//           filteredPatientList = patientList;
//           break;
//         case 1: // Follow up
//           // Filter patients who need follow up (you can customize this logic)
//           AppSnackBar.show(context,
//               message:
//                   "We're working on this feature. It will be available in a future update.");
//
//           filteredPatientList =
//               patientList.where((patient) => patient != null).toList();
//           break;
//         case 2: // New
//           AppSnackBar.show(context,
//               message:
//                   "We're working on this feature. It will be available in a future update.");
//
//           // Filter new patients (you can customize this logic)
//           filteredPatientList =
//               patientList.where((patient) => patient == false).toList();
//           break;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return buildMobileView(context);
//       },
//     );
//   }
//
//   Widget buildMobileView(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Patients",
//         ),
//         leading: widget.isForm
//             ? IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(Icons.arrow_back_ios_outlined))
//             : SizedBox(),
//         leadingWidth: widget.isForm ? 100 : 0,
//         centerTitle: false,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (_) => PatientAddScreen()));
//         },
//         backgroundColor: Colors.lightBlue,
//         child: Icon(Icons.add, color: Colors.white),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Consumer<PatientViewModel>(builder: (context, patientVM, child) {
//           if (patientVM.isLoading) {
//             return Text("Loading");
//           }
//           if (patientVM.error != null) {
//             return Text(patientVM.error.toString());
//           }
//           if (patientVM.patients.isEmpty) {
//             return EmptyPlaceHolder();
//           }
//
//           return Column(
//             children: [
//               // Tabs
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(color: Colors.grey.shade300, width: 1),
//                   ),
//                 ),
//                 child: TabBar(
//                   controller: _tabController,
//                   onTap: _onTabChanged,
//                   labelColor: Colors.black,
//                   unselectedLabelColor: Colors.grey,
//                   indicatorColor: Colors.blue,
//                   indicatorWeight: 2,
//                   tabs: [
//                     Tab(text: "All"),
//                     Tab(text: "Follow up"),
//                     Tab(text: "New"),
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: 16),
//
//               // Search Bar
//               GestureDetector(
//                 onTap: () {
//                   AppSnackBar.show(context,
//                       message:
//                           "We're working on this feature. It will be available in a future update.");
//                   // Navigator.push(context,
//                   //     MaterialPageRoute(builder: (_) => PatientSearchScreen()));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: TextField(
//                     onChanged: _filterPatients,
//                     enabled: false,
//                     decoration: InputDecoration(
//                       hintText: "Search reason",
//                       hintStyle: TextStyle(color: Colors.grey),
//                       prefixIcon: Icon(Icons.search, color: Colors.grey),
//                       border: InputBorder.none,
//                       contentPadding:
//                           EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                     ),
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 16),
//
//               // Patient List
//               Expanded(
//                 child: ListView.builder(
//                   controller: _scrollController,
//                   itemCount: patientVM.patients.length +
//                       (patientVM.isLoadingMore ? 1 : 0),
//                   itemBuilder: (context, index) {
//                     if (index == patientVM.patients.length) {
//                       // Show loading indicator at the bottom
//                       return Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                       );
//                     }
//                     return PatientCard(patient: patientVM.patients[index]);
//                   },
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
