// import 'package:flutter/material.dart';
// import 'package:medicare_doctor/features/patient/data/models/patient_model.dart';
// import 'package:medicare_doctor/shared/global_methods.dart';
//
// class PatientCardTile extends StatelessWidget {
//   final PatientItem patientData;
//
//   const PatientCardTile({super.key, required this.patientData});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.blueAccent,
//                     backgroundImage: patientData.image != null
//                         ? NetworkImage(patientData.image ?? "")
//                         : AssetImage("assets/images/logo.png") as ImageProvider,
//                     child: patientData.image == null
//                         ? Icon(
//                             patientData.gender != "male"
//                                 ? Icons.woman
//                                 : Icons.account_circle_outlined,
//                             color: Colors.white,
//                           )
//                         : null, // No child when there's an image
//                   ),
//                 ],
//               ),
//               SizedBox(width: 10.0),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             "${patientData.firstname} ${patientData.lastname}",
//                             style: Theme.of(context).textTheme.titleMedium!,
//                           ),
//                         ),
//                         Icon(
//                           patientData.gender != "male"
//                               ? Icons.female
//                               : Icons.male,
//                           color: patientData.gender != "male"
//                               ? Colors.pink
//                               : Colors.blue,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 4.0),
//                     cardTile(
//                         title: patientData.phoneNumber,
//                         iconData: Icons.phone,
//                         context: context),
//                     cardTile(
//                         title: patientData.email ?? "",
//                         iconData: Icons.email,
//                         context: context),
//                     patientData.dateOfBirth == null
//                         ? SizedBox()
//                         : cardTile(
//                             title: formatDateAndDifference(
//                                 DateTime.parse(patientData.dateOfBirth!)),
//                             iconData: Icons.date_range,
//                             context: context),
//                     cardTile(
//                         title: patientData.patientRegistered
//                             ? "Verified"
//                             : "Un-verified",
//                         iconData: Icons.label,
//                         context: context),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
//
//   Widget cardTile(
//       {required String title,
//       required IconData iconData,
//       required BuildContext context}) {
//     return title.isEmpty || title == "null"
//         ? SizedBox()
//         : Row(
//             children: [
//               Icon(iconData, size: 16),
//               SizedBox(width: 5),
//               Text(title, style: Theme.of(context).textTheme.titleSmall!),
//             ],
//           );
//   }
// }
