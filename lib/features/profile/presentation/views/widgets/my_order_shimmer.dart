// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
//
// class OrdersShimmerScreen extends StatelessWidget {
//   const OrdersShimmerScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 5, // Number of shimmer cards to show
//       itemBuilder: (context, index) {
//         return _buildShimmerOrderCard();
//       },
//     );
//   }
//
//   Widget _buildShimmerOrderCard() {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildShimmerHeader(),
//           _buildShimmerDetails(),
//           _buildShimmerItems(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildShimmerHeader() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: const BoxDecoration(
//         color: Color(0xFFF8F9FA),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(16),
//           topRight: Radius.circular(16),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ShimmerBox(width: 100, height: 20),
//               const SizedBox(height: 8),
//               ShimmerBox(width: 80, height: 14),
//             ],
//           ),
//           ShimmerBox(width: 70, height: 24, borderRadius: 20),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildShimmerDetails() {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
//               const SizedBox(width: 8),
//               ShimmerBox(width: 150, height: 14),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               const Icon(Icons.payment, size: 16, color: Colors.grey),
//               const SizedBox(width: 8),
//               ShimmerBox(width: 120, height: 14),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildShimmerItems() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Section title row
//           Row(
//             children: [
//               const Icon(Icons.menu_book, size: 18, color: Colors.grey),
//               const SizedBox(width: 8),
//               ShimmerBox(width: 80, height: 16),
//               const Spacer(),
//               ShimmerBox(width: 60, height: 18, borderRadius: 12),
//             ],
//           ),
//           const SizedBox(height: 12),
//
//           // Book items shimmer
//           Column(
//             children: List.generate(
//               2,
//                   (index) => Padding(
//                 padding: const EdgeInsets.only(bottom: 12),
//                 child: Row(
//                   children: [
//                     ShimmerBox(width: 50, height: 70, borderRadius: 8),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ShimmerBox(width: double.infinity, height: 14),
//                           const SizedBox(height: 6),
//                           ShimmerBox(width: 120, height: 12),
//                           const SizedBox(height: 6),
//                           ShimmerBox(width: 80, height: 12),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// /// Reusable shimmer box
// class ShimmerBox extends StatelessWidget {
//   final double width;
//   final double height;
//   final double borderRadius;
//
//   const ShimmerBox({
//     super.key,
//     required this.width,
//     required this.height,
//     this.borderRadius = 4,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: Container(
//         width: width,
//         height: height,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//       ),
//     );
//   }
// }
