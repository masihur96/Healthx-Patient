// import 'package:flutter/material.dart';
// import 'package:healthx_patient/features/profile_tab/repository/profile_repository.dart';
// import 'package:open_share_plus/open.dart';
//
// import '../../profile_tab/model/profile_model.dart';
//
// class TelemedicineScreen extends StatefulWidget {
//   const TelemedicineScreen({super.key});
//
//   @override
//   State<TelemedicineScreen> createState() => _TelemedicineScreenState();
// }
//
// class _TelemedicineScreenState extends State<TelemedicineScreen> {
//   final ProfileRepository profileRepository = ProfileRepository();
//   ProfileModel? profileModel;
//   bool _isOnline = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // getProfile();
//   }
//
//   getProfile() async {
//     profileModel = await profileRepository.getProfile();
//
//     print(profileModel!.firstname);
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: SizedBox(),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Use constraints to determine if the view is for mobile or desktop
//           bool isMobile = constraints.maxWidth < 600;
//
//           return Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: isMobile ? 15.0 : 30.0,
//               vertical: isMobile ? 10.0 : 20.0,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Telemedicine',
//                       style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                             fontSize: isMobile ? 20 : 28,
//                           ),
//                     ),
//                     Switch.adaptive(
//                       value: _isOnline,
//                       onChanged: (value) {
//                         setState(() {
//                           _isOnline = value;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: isMobile ? 10 : 20),
//                 profileModel == null
//                     ? SizedBox()
//                     : _isOnline
//                         ? Expanded(
//                             child: Stack(
//                               children: [
//                                 // Background Image
//                                 Image.asset(
//                                   'assets/images/splash_assets.png',
//                                   fit: BoxFit.cover,
//                                 ),
//
//                                 // Action Button
//                                 Positioned(
//                                     bottom: MediaQuery.of(context).size.height *
//                                         0.1, // 10% from bottom
//                                     left: 0,
//                                     right: 0,
//                                     child: Column(
//                                       children: [
//                                         SizedBox(
//                                             height: MediaQuery.of(context)
//                                                     .size
//                                                     .height *
//                                                 0.05), // 5% of screen height
//
//                                         // Doctor's Name and Title
//                                         Column(
//                                           children: [
//                                             Text(
//                                               profileModel!.firstname,
//                                               style: TextStyle(
//                                                 fontSize: 22,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             Text(
//                                               profileModel?.doctorInfo
//                                                       ?.specialization ??
//                                                   "",
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: Colors.grey,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//
//                                         SizedBox(
//                                             height: MediaQuery.of(context)
//                                                     .size
//                                                     .height *
//                                                 0.1),
//                                         ElevatedButton(
//                                           onPressed: () {
//                                             Open.whatsApp(
//                                                 whatsAppNumber:
//                                                     formatPhoneNumber(
//                                                         profileModel?.doctorInfo
//                                                                 ?.phoneNumber ??
//                                                             "01740719204"),
//                                                 text:
//                                                     "Hello How can i help you?");
//                                           },
//                                           style: ElevatedButton.styleFrom(
//                                             shape: CircleBorder(),
//                                             padding: EdgeInsets.all(20),
//                                             backgroundColor: Colors.green,
//                                           ),
//                                           child: Icon(Icons.call,
//                                               size: 30, color: Colors.white),
//                                         ),
//                                       ],
//                                     )),
//                               ],
//                             ),
//                           )
//                         : Expanded(
//                             child: Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'You are Offline now',
//                                     style: TextStyle(
//                                       fontSize: isMobile ? 18 : 24,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   SizedBox(height: isMobile ? 10 : 20),
//                                   Text(
//                                     'Please go online!\nAs soon as you go online,\nYou will be available to patients for taking appointments',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontSize: isMobile ? 14 : 18,
//                                     ),
//                                   ),
//                                   SizedBox(height: isMobile ? 20 : 40),
//                                   Icon(
//                                     Icons.power_off,
//                                     size: isMobile ? 80 : 120,
//                                     color: Colors.grey,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   String formatPhoneNumber(String? phoneNumber) {
//     if (phoneNumber == null || phoneNumber.isEmpty) {
//       return ''; // Handle null or empty phone numbers
//     }
//
//     if (!phoneNumber.startsWith('880')) {
//       return '880$phoneNumber'; // Add the prefix if it's missing
//     }
//
//     return phoneNumber; // Return the original if the prefix is already present
//   }
// }
