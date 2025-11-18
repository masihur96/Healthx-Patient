// import 'package:flutter/material.dart';
// import 'package:medicare_doctor/configs/custom_size.dart';
// import 'package:medicare_doctor/shared/custom_text_form_field.dart';
//
// class ComplainDetailsScreen extends StatefulWidget {
//   @override
//   State<ComplainDetailsScreen> createState() => _ComplainDetailsScreenState();
// }
//
// class _ComplainDetailsScreenState extends State<ComplainDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'New Rx',
//           style: Theme.of(context).textTheme.titleMedium!,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(8)),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("test"),
//                   Divider(
//                     thickness: 1,
//                   ),
//                   Row(
//                     children: [
//                       Text("Value"),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: MediCareProTextFormField(),
//                         ),
//                       ),
//                       Text("For"),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: MediCareProTextFormField(),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: MediCareProTextFormField(
//                       maxLines: 5,
//                       hintText: "Type here.......",
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: screenSize(context, .1),
//                     child: Row(
//                       children: [],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
//         child: ElevatedButton(
//           onPressed: () {
//             // Add your onPressed code here!
//           },
//           child: Text('Done'),
//           style: ElevatedButton.styleFrom(
//             minimumSize: Size(150, 50),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
