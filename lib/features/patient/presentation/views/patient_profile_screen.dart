// import 'package:flutter/material.dart';
// import 'package:medicare_doctor/configs/custom_size.dart';
// import 'package:medicare_doctor/core/constants/app_colors.dart';
// import 'package:medicare_doctor/features/patient/data/models/patient_model.dart';
// import 'package:medicare_doctor/shared/chill_scaffold.dart';
// import 'package:medicare_doctor/shared/custom_appbar.dart';
// import 'package:medicare_doctor/shared/global_methods.dart';
//
// class PatientProfileScreen extends StatefulWidget {
//   final PatientItem patientData;
//   const PatientProfileScreen({super.key, required this.patientData});
//
//   @override
//   State<PatientProfileScreen> createState() => _PatientProfileScreenState();
// }
//
// class _PatientProfileScreenState extends State<PatientProfileScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChillScaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       floatingActionButton: GestureDetector(
//         onTap: () {
//           // Navigator.push(
//           //     context,
//           //     MaterialPageRoute(
//           //         builder: (_) => EditPatientScreen(
//           //               patientData: widget.patientData,
//           //             )));
//         },
//         child: Card(
//           color: AppColors.buttonColor,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
//             child: Text("Edit Patient",
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleSmall!
//                     .copyWith(color: AppColors.whiteColor)),
//           ),
//         ),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth > 600) {
//             // Desktop view
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildHeader(),
//                   SizedBox(height: 16),
//                   _buildTabBar(),
//                   SizedBox(height: 16),
//                   Expanded(
//                     child: TabBarView(
//                       controller: _tabController,
//                       children: [
//                         _buildProfileContent(),
//                         _buildPrescriptionContent(),
//                         _buildNoteContent(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             // Mobile view
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   ChillAppbar(
//                     title: "Patient Profile",
//                     showBackWidget: true,
//                   ),
//                   _buildHeader(),
//                   SizedBox(height: 16),
//                   _buildTabBar(),
//                   SizedBox(height: 16),
//                   Expanded(
//                     child: TabBarView(
//                       controller: _tabController,
//                       children: [
//                         _buildProfileContent(),
//                         _buildPrescriptionContent(),
//                         _buildNoteContent(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 30,
//           backgroundImage: NetworkImage(
//             widget.patientData.image ??
//                 "https://gravatar.com/avatar/cf22437ee471a66b96151345fb8a5e88?s=400&d=robohash&r=x",
//           ),
//         ),
//         const SizedBox(width: 16),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: screenSize(context, .7),
//               child: Text(
//                 "${widget.patientData.firstname} ${widget.patientData.lastname}",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Text(
//               "ID- ${widget.patientData.id.split("-").last}",
//               style: TextStyle(fontSize: 14, color: Colors.grey),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTabBar() {
//     return TabBar(
//       controller: _tabController,
//       labelColor: Colors.blue,
//       unselectedLabelColor: Colors.grey,
//       indicatorColor: Colors.blue,
//       tabs: [
//         Tab(text: 'Profile'),
//         Tab(text: 'Prescription'),
//         Tab(text: 'Note'),
//       ],
//     );
//   }
//
//   Widget _buildProfileContent() {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           infoCard(
//             title: 'Basic Info',
//             children: [
//               InfoTile(label: 'Gender', value: widget.patientData.gender),
//               widget.patientData.dateOfBirth == null ||
//                       widget.patientData.dateOfBirth.toString().isEmpty
//                   ? SizedBox()
//                   : InfoTile(
//                       label: 'Date of Birth',
//                       value: formatDateAndDifference(
//                           widget.patientData.dateOfBirth!),
//                     ),
//               InfoTile(
//                   label: 'Blood Group', value: widget.patientData.bloodGroup),
//               InfoTile(
//                   label: 'Occupation', value: widget.patientData.occupation),
//             ],
//           ),
//           infoCard(
//             title: 'Contact',
//             children: [
//               InfoTile(label: 'Phone', value: widget.patientData.phoneNumber),
//               InfoTile(label: 'Email', value: widget.patientData.email),
//             ],
//           ),
//           infoCard(
//             title: 'Family',
//             children: [
//               InfoTile(label: "Father's Name", value: "N/A"),
//               InfoTile(label: "Mother's Name", value: "N/A"),
//               InfoTile(label: "Spouse's Name", value: "N/A"),
//             ],
//           ),
//           infoCard(
//             title: 'Address',
//             children: [
//               InfoTile(label: "Division", value: "N/A"),
//               InfoTile(label: "Mother's NameDistrict", value: "N/A"),
//               InfoTile(label: "Thana", value: "N/A"),
//               InfoTile(label: "Post Office", value: "N/A"),
//               InfoTile(label: "Home Address", value: "N/A"),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget infoCard({required String title, required List<Widget> children}) {
//     return Card(
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(14.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 8),
//                 Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: children),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget InfoTile({required String label, required String value}) {
//     return value.isEmpty
//         ? SizedBox()
//         : Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 Text(value),
//               ],
//             ),
//           );
//   }
//
//   Widget _buildPrescriptionContent() {
//     return Center(
//       child: Text('Prescription content goes here'),
//     );
//   }
//
//   Widget _buildNoteContent() {
//     return Center(
//       child: Text('Note content goes here'),
//     );
//   }
// }
//
// class ProfileSection extends StatelessWidget {
//   final String title;
//   final List<Widget> children;
//
//   ProfileSection({required this.title, required this.children});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8),
//           Column(children: children),
//         ],
//       ),
//     );
//   }
// }
