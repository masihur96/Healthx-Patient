// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
//
// class ProfileShimmer extends StatelessWidget {
//   const ProfileShimmer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey.shade300,
//       highlightColor: Colors.grey.shade100,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               CircleAvatar(
//                 radius: 50,
//                 backgroundColor: Colors.white,
//               ),
//               const SizedBox(height: 16),
//               Container(height: 20, width: 120, color: Colors.white),
//               const SizedBox(height: 8),
//               Container(height: 16, width: 180, color: Colors.white),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(height: 50, width: 100, color: Colors.white),
//                   Container(height: 50, width: 100, color: Colors.white),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Container(height: 40, width: double.infinity, color: Colors.white),
//               const SizedBox(height: 10),
//               Container(height: 40, width: double.infinity, color: Colors.white),
//               const SizedBox(height: 20),
//               ...List.generate(4, (index) => Column(
//                 children: [
//                   ListTile(
//                     leading: Container(height: 30, width: 30, color: Colors.white),
//                     title: Container(height: 16, width: double.infinity, color: Colors.white),
//                   ),
//                   const Divider(),
//                 ],
//               )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
