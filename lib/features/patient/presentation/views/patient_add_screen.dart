// import 'package:flutter/material.dart';
// import 'package:medicare_doctor/configs/custom_size.dart';
// import 'package:medicare_doctor/features/patient/presentation/viewmodels/patient_view_model.dart';
// import 'package:medicare_doctor/shared/app_snackbar.dart';
// import 'package:medicare_doctor/shared/custom_text_form_field.dart';
// import 'package:provider/provider.dart';
//
// class PatientAddScreen extends StatefulWidget {
//   @override
//   _PatientAddScreenState createState() => _PatientAddScreenState();
// }
//
// class _PatientAddScreenState extends State<PatientAddScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String? _selectedGender;
//   String? _selectedDateType;
//   bool _checkboxValue = false;
//   DateTime? _selectedDate;
//   bool _isLoading = false;
//   // Controllers for text fields
//
//   String _name = "";
//   String _phone = "";
//   String _email = "";
//   String _age = "";
//   String _dob = "";
//
//   _addPatient(PatientViewModel patientVM, BuildContext context) async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       setState(() {
//         _isLoading = true;
//       });
//
//       if (_checkboxValue) {
//         final success = await patientVM.registerPatient(
//           email: _email,
//           fullName: _name,
//           phone: _phone,
//           age: _age,
//           dob: _dob,
//           gender: _selectedGender ?? "",
//         );
//
//         print("Registration Success:: $success");
//
//         if (success) {
//           if (!mounted) return;
//
//           setState(() {
//             _isLoading = false;
//           });
//
//           AppSnackBar.show(
//             context,
//             message: "Successfully Registered.",
//           );
//           Navigator.pop(context);
//         } else {
//           if (!mounted) return;
//           setState(() {
//             _isLoading = false;
//           });
//           if (mounted) {
//             AppSnackBar.show(
//               context,
//               message: "Failed to register",
//             );
//           }
//         }
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//         AppSnackBar.show(
//           context,
//           message: "Please agree to terms ",
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authVM = Provider.of<PatientViewModel>(context);
//     return Scaffold(
//       appBar: AppBar(
//         leading: BackButton(),
//         centerTitle: true,
//         title: Text("Add New Patients",
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               MediCareProTextFormField(
//                 labelText: "Enter Patient Name",
//                 onSaved: (String? value) {
//                   _name = value!;
//                 },
//                 prefixIconData: Icons.person_outline,
//                 validator: (String? value) {
//                   if (value!.isEmpty) {
//                     return 'This Field is Required';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               MediCareProTextFormField(
//                 labelText: "Email",
//                 keyboardType: TextInputType.emailAddress,
//                 onSaved: (String? value) {
//                   _email = value!;
//                 },
//                 prefixIconData: Icons.email_outlined,
//                 validator: (String? value) {
//                   if (value == null || value.trim() == "") {
//                     return 'Enter Email Address';
//                   }
//                   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return 'Invalid Email';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               MediCareProTextFormField(
//                 labelText: "Enter Phone Number",
//                 onSaved: (String? value) {
//                   _phone = value!;
//                 },
//                 prefixIconData: Icons.lock_outline,
//                 keyboardType: TextInputType.phone,
//                 validator: (String? value) {
//                   bool mobileValid = RegExp(r'^(?:\+?88|0088)?01[13-9]\d{8}$')
//                       .hasMatch(value!);
//                   if (value == null || value.trim() == "") {
//                     return 'Phone is Required';
//                   }
//                   if (!mobileValid) {
//                     return 'Incorrect Mobile Number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               _buildDropdownField(
//                 label: "Gender",
//                 value: _selectedGender,
//                 items: ["male", "female", "other"],
//                 onChanged: (val) => setState(() => _selectedGender = val),
//               ),
//               SizedBox(height: 16),
//               MediCareProTextFormField(
//                 labelText: "Enter Age",
//                 onSaved: (String? value) {
//                   _age = value!;
//                 },
//                 prefixIconData: Icons.lock_outline,
//                 keyboardType: TextInputType.number,
//                 validator: (String? value) {
//                   if (value == null || value.trim() == "") {
//                     return 'Phone is Required';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               Text("Date Of Birth",
//                   style: TextStyle(fontWeight: FontWeight.w500)),
//               SizedBox(height: 8),
//               GestureDetector(
//                 onTap: () async {
//                   DateTime? picked = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(1900),
//                     lastDate: DateTime.now(),
//                   );
//                   if (picked != null) {
//                     setState(() {
//                       _selectedDate = picked;
//                       _dob = "${picked.year}-${picked.month}-${picked.day}";
//                     });
//                   }
//                 },
//                 child: MediCareProTextFormField(
//                   textEditingController: TextEditingController(text: _dob),
//                   labelText: "Date of birth",
//                   isEnable: false,
//                   prefixIconData: Icons.lock_outline,
//                   keyboardType: TextInputType.phone,
//                   validator: (String? value) {
//                     if (value == null || value.trim() == "") {
//                       return 'Date of Birth  is Required';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               SizedBox(height: 16),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _checkboxValue,
//                     onChanged: (val) => setState(() => _checkboxValue = val!),
//                   ),
//                   Expanded(
//                     child: Text(
//                       "Lorem ipsum dolor sit amet consectetur.Lorem ipsum dolor sit amet consectetur.",
//                       style: TextStyle(fontSize: 13),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 24),
//               Align(
//                 alignment: Alignment.topRight,
//                 child: SizedBox(
//                   width: screenSize(context, .5),
//                   height: 48,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF246BFD),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                     ),
//                     onPressed: () {
//                       if (authVM.isLoading) return;
//
//                       _addPatient(authVM, context);
//
//                       // Submit logic
//                     },
//                     child: Text("Add new Patients",
//                         style: TextStyle(fontSize: 16, color: Colors.white)),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDropdownField({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (label.isNotEmpty) ...[
//           Text(label),
//           SizedBox(height: 8),
//         ],
//         DropdownButtonFormField<String>(
//           value: value,
//           isExpanded: true,
//           decoration: InputDecoration(
//             hintText: "Select goals category...",
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//             contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//           ),
//           items: items
//               .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//               .toList(),
//           onChanged: onChanged,
//         ),
//       ],
//     );
//   }
// }
