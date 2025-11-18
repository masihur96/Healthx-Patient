// import 'package:flutter/material.dart';
// import 'package:medicare_doctor/configs/custom_size.dart';
// import 'package:medicare_doctor/core/constants/app_colors.dart';
// import 'package:medicare_doctor/shared/chill_scaffold.dart';
// import 'package:medicare_doctor/shared/medi_care_pro_button.dart';
// import 'package:medicare_doctor/shared/custom_text_form_field.dart';
//
// import '../../repository/auth_repository.dart';
//
// class ForgetPasswordDialog extends StatefulWidget {
//   const ForgetPasswordDialog({super.key});
//
//   @override
//   State<ForgetPasswordDialog> createState() => _ForgetPasswordDialogState();
// }
//
// class _ForgetPasswordDialogState extends State<ForgetPasswordDialog> {
//   bool isMedicalSelected = false;
//   bool _isLoading = false;
//   final _formKey = GlobalKey<FormState>();
//   final _otpFormKey = GlobalKey<FormState>();
//   String _email = "";
//   String _OTP = "";
//   bool isDone = false;
//   String _password = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return ChillScaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: SizedBox(),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             if (constraints.maxWidth > 600) {
//               // Desktop View
//               return _desktopView();
//             } else {
//               // Mobile View
//               return _mobileView();
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _mobileView() {
//     return SingleChildScrollView(
//       child: SizedBox(
//         height: screenSize(context, 1.4),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _header(context),
//             Text(
//               "Please type your BMDC\nto send you the\nverification code",
//               style: Theme.of(context).textTheme.titleSmall!,
//               textAlign: TextAlign.left,
//             ),
//             SizedBox(height: screenSize(context, .05)),
//             Align(
//               alignment: Alignment.center,
//               child: Image.asset(
//                 "assets/images/forget.png",
//                 fit: BoxFit.cover,
//                 height: screenSize(context, .4),
//                 width: screenSize(context, .3),
//               ),
//             ),
//             const Spacer(),
//             const Spacer(),
//             !isDone ? _formField() : otpWidget(),
//             const Spacer(),
//             !isDone ? _submitButton() : _setPasswordButton(),
//             const Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _desktopView() {
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             child: Image.asset(
//               "assets/images/forget.png",
//               fit: BoxFit.cover,
//               height: screenSize(context, .8),
//             ),
//           ),
//           SizedBox(
//             width: screenSize(context, .1),
//           ),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 _header(context),
//                 Text(
//                   "Please type your BMDC to send you the verification code",
//                   style: Theme.of(context).textTheme.titleSmall!,
//                   textAlign: TextAlign.left,
//                 ),
//                 SizedBox(height: screenSize(context, .05)),
//                 const SizedBox(height: 20),
//                 _formField(),
//                 const SizedBox(height: 20),
//                 _submitButton(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _header(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           "Forget Password",
//           style: Theme.of(context).textTheme.titleMedium!,
//         ),
//         IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.cancel),
//         ),
//       ],
//     );
//   }
//
//   Widget _formField() {
//     return Form(
//       key: _formKey,
//       child: SizedBox(
//         height: screenSize(context, .15),
//         child: MediCareProTextFormField(
//           labelText: "Enter Email Address",
//           onSaved: (String? value) {
//             _email = value!;
//           },
//           prefixIconData: Icons.email_outlined,
//           validator: (String? value) {
//             if (value == null || value.trim() == "") {
//               return 'Enter Email Address';
//             }
//             if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//               return 'Invalid Email';
//             }
//             return null;
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget otpWidget() {
//     return Form(
//       key: _otpFormKey,
//       child: SizedBox(
//         height: screenSize(context, .45),
//         child: Column(
//           children: [
//             MediCareProTextFormField(
//               labelText: "Enter OTP Code",
//               onSaved: (String? value) {
//                 _OTP = value!;
//               },
//               prefixIconData: Icons.code,
//               validator: (String? value) {
//                 if (value == null || value.trim() == "") {
//                   return 'Enter OTP Code';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             MediCareProTextFormField(
//               labelText: "Enter Your Password",
//               onSaved: (String? value) {
//                 _password = value!;
//               },
//               prefixIconData: Icons.lock_outline,
//               validator: (String? value) {
//                 if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&#]{6,}$')
//                     .hasMatch(value!)) {
//                   return 'At least 6 characters, letters & numbers.';
//                 }
//
//                 return null;
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _submitButton() {
//     return MediCareProButton(
//       title: "Send Code",
//       isLoading: _isLoading,
//       height: screenSize(context, .1),
//       width: screenSize(context, 1),
//       bgColor: AppColors.buttonColor,
//       onTap: () async {
//         // final AuthRepository _authRepository = AuthRepository();
//         // if (_formKey.currentState!.validate()) {
//         //   _formKey.currentState!.save();
//         //
//         //   if (_email.isNotEmpty) {
//         //     _isLoading = true;
//         //
//         //     isDone = await _authRepository.forgetPassword(email: _email);
//         //
//         //     if (!isDone) {
//         //       ScaffoldMessenger.of(context).showSnackBar(
//         //         SnackBar(
//         //           content: Text("No active account found"),
//         //         ),
//         //       );
//         //     }
//         //     setState(() {
//         //       _isLoading = false;
//         //     });
//         //   }
//         //
//         //   // Handle the send code logic here
//         // }
//       },
//     );
//   }
//
//   Widget _setPasswordButton() {
//     return MediCareProButton(
//       title: "Set Password",
//       isLoading: _isLoading,
//       height: screenSize(context, .1),
//       width: screenSize(context, 1),
//       bgColor: AppColors.buttonColor,
//       onTap: () async {
//         final AuthRepository _authRepository = AuthRepository();
//         if (_otpFormKey.currentState!.validate()) {
//           _otpFormKey.currentState!.save();
//
//           if (_OTP.isNotEmpty) {
//             setState(() {
//               _isLoading = true;
//             });
//             bool isDone = await _authRepository.setPassword(
//                 token: _OTP, newPassword: _password);
//             if (isDone) {
//               setState(() {
//                 _isLoading = false;
//               });
//               Navigator.pop(context);
//             } else {
//               setState(() {
//                 _isLoading = false;
//               });
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text("Server Error"),
//                 ),
//               );
//             }
//           }
//
//           // Handle the send code logic here
//         }
//       },
//     );
//   }
// }
