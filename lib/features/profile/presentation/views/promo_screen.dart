// import 'package:flutter/material.dart';
// import 'package:anuj_prokashon/features/profile/presentation/views/widgets/add_promo.dart';
// import 'package:anuj_prokashon/configs/app_localizations.dart';
// import 'package:anuj_prokashon/configs/custom_size.dart';
// import 'package:anuj_prokashon/shared/bounching_dialog.dart';
//
// class PromoScreen extends StatelessWidget {
//    PromoScreen({super.key});
//
//   final List<Map<String, dynamic>> promoCodes = [
//     {
//       'code': 'SP10',
//       'expiryDate': 'Apr 30, 2025',
//       'discount': '10%',
//       'validity': 'Valid for the book published by শোভা প্রকাশ',
//       'maxDiscount': 'Max discount BDT 1000',
//       'used': 0,
//       'total': 32,
//     },
//     {
//       'code': 'JM33',
//       'expiryDate': 'May 03, 2025',
//       'discount': '33%',
//       'validity': 'Valid for the book আব্দার কষ্ট',
//       'maxDiscount': 'Max discount BDT 200',
//       'used': 0,
//       'total': 10,
//     },
//     {
//       'code': 'WELCOME',
//       'expiryDate': 'Jan 01, 2026',
//       'discount': '40%',
//       'validity': 'Valid for the book category of ওয়েলকাম',
//       'maxDiscount': 'Max discount BDT 1000',
//       'used': 0,
//       'total': 1,
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context);
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
//           child: Column(
//             children: [
//
//
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(localizations.promo,style: TextStyle(fontSize: screenSize(context, .05,),fontWeight: FontWeight.w600),),
//                   Spacer(),
//
//                   TextButton(onPressed: (){
//                     showDialog(
//                       barrierDismissible: true,
//                       context: context,
//                       builder: (_) => BounchingDialog(
//                         width: screenSize(context, 0.6),
//                         height: screenSize(
//                             context, 1),
//                         child: AddPromoScreen(),
//                       ),
//                     );
//
//
//                   }, child: Text("Add Promo",style: TextStyle(fontSize: screenSize(context, .05,),fontWeight: FontWeight.w600),))
//
//                 ],),
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.all(16.0),
//                   itemCount: promoCodes.length,
//                   itemBuilder: (context, index) {
//                     final promo = promoCodes[index];
//                     return _buildPromoCard(
//                       context,
//                       promo['code'],
//                       promo['expiryDate'],
//                       promo['discount'],
//                       promo['validity'],
//                       promo['maxDiscount'],
//                       promo['used'],
//                       promo['total'],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPromoCard(BuildContext context,String code, String expiryDate, String discount, String validity, String maxDiscount,
//       int used, int total) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text(code, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                     Text(' Expiry date: $expiryDate'),
//                   ],
//                 ),
//
//
//                 Text(validity),
//                 Text(maxDiscount),
//                 SizedBox(height: 10,),
//                 Text('Used $used/$total times',style: TextStyle(color: Colors.green),),
//               ],
//             ),
//           ),
//           Positioned(
//             right: 10,
//             top: 10,
//             child: Text(discount,style: TextStyle(color: Colors.yellow.shade900,fontSize: screenSize(context, .035)),),)
//         ],
//       ),
//     );
//   }
// }
