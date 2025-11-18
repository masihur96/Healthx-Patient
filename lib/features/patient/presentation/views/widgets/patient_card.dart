// import 'package:flutter/material.dart';
// import 'package:medicare_doctor/features/patient/data/models/patient_model.dart';
// import 'package:medicare_doctor/shared/app_snackbar.dart';
//
// class PatientCard extends StatelessWidget {
//   final PatientItem patient;
//   const PatientCard({super.key, required this.patient});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (_) => PatientProfileScreen(patientData: patient),
//         //   ),
//         // );
//       },
//       child: Container(
//         margin: EdgeInsets.only(bottom: 12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 4,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   // Patient Image
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       image: patient.image != null
//                           ? DecorationImage(
//                               image: NetworkImage(patient.image ?? ""),
//                               fit: BoxFit.cover,
//                             )
//                           : null,
//                     ),
//                     child: patient.image == null
//                         ? Container(
//                             decoration: BoxDecoration(
//                               color: Colors.blue.shade100,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(
//                               patient.gender != "male"
//                                   ? Icons.woman
//                                   : Icons.person,
//                               color: Colors.blue,
//                               size: 30,
//                             ),
//                           )
//                         : null,
//                   ),
//
//                   SizedBox(width: 16),
//
//                   //Patient Details
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "${patient.firstname} ${patient.lastname}",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         patient.dateOfBirth == null
//                             ? SizedBox()
//                             : Text(
//                                 "Age : ${_calculateAge(DateTime.parse(patient.dateOfBirth!))} | Headache",
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey.shade600,
//                                 ),
//                               ),
//                         SizedBox(height: 4),
//                         Text(
//                           "No medical background issues",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   // Options Icon
//                 ],
//               ),
//             ),
//             Positioned(
//               right: 0,
//               top: 0,
//               child: Column(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       AppSnackBar.show(context,
//                           message:
//                               "We're working on this feature. It will be available in a future update.");
//                       // _showPatientOptions(context, patient);
//                     },
//                     icon: Icon(Icons.more_horiz, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showPatientOptions(BuildContext context, PatientItem patient) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => Container(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: Icon(Icons.edit),
//               title: Text("Edit Patient"),
//               onTap: () {
//                 Navigator.pop(context);
//                 // Navigate to edit patient screen
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.medical_services),
//               title: Text("View Medical History"),
//               onTap: () {
//                 Navigator.pop(context);
//                 // Navigate to medical history screen
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.delete, color: Colors.red),
//               title:
//                   Text("Delete Patient", style: TextStyle(color: Colors.red)),
//               onTap: () {
//                 Navigator.pop(context);
//                 _showDeleteConfirmation(context, patient);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showDeleteConfirmation(BuildContext context, PatientItem patient) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Delete Patient"),
//         content: Text(
//             "Are you sure you want to delete ${patient.firstname} ${patient.lastname}?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               // Implement delete functionality
//             },
//             child: Text("Delete", style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   int _calculateAge(DateTime? dateOfBirth) {
//     if (dateOfBirth == null) return 32; // Default age as shown in image
//     final now = DateTime.now();
//     int age = now.year - dateOfBirth.year;
//     if (now.month < dateOfBirth.month ||
//         (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
//       age--;
//     }
//     return age;
//   }
// }
