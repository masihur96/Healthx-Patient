// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:medicare_doctor/configs/custom_size.dart';
// import 'package:medicare_doctor/core/constants/app_colors.dart';
// import 'package:medicare_doctor/features/home_tab/model/age_model.dart';
// import 'package:medicare_doctor/features/home_tab/model/patient_model.dart';
// import 'package:medicare_doctor/features/home_tab/repository/patient_repository.dart';
// import 'package:medicare_doctor/features/patient/data/models/patient_model.dart';
// import 'package:medicare_doctor/shared/chill_scaffold.dart';
// import 'package:medicare_doctor/shared/custom_appbar.dart';
// import 'package:medicare_doctor/shared/global_methods.dart';
// import 'package:medicare_doctor/shared/medi_care_pro_button.dart';
// import 'package:medicare_doctor/shared/custom_text_form_field.dart';
//
// class EditPatientScreen extends StatefulWidget {
//   final PatientItem patientData;
//   const EditPatientScreen({super.key, required this.patientData});
//
//   @override
//   _EditPatientScreenState createState() => _EditPatientScreenState();
// }
//
// class _EditPatientScreenState extends State<EditPatientScreen> {
//   final PatientRepository _patientRepository = PatientRepository();
//
//   final _formKey = GlobalKey<FormState>();
//   final _otpFormKey = GlobalKey<FormState>();
//   String _selectedBloodGroup = 'A+';
//   String _selectedDemography = 'Urban';
//   String _selectedGender = 'Male';
//   bool _isExpanded = false;
//   bool _isLoading = false;
//   bool _isObsecure = false;
//   String _name = "";
//   String _phone = "";
//   String _otpToken = "";
//
//   String _dob = "";
//   DateTime? _selectedDate;
//   String _occupation = "";
//   String _email = "";
//   String _fatherName = "";
//   String _motherName = "";
//   String _spouseName = "";
//   String _addressName = "";
//   String _password = "";
//
//   int years = 0;
//   int months = 0;
//   int days = 0;
//
//   @override
//   void initState() {
//     setPrevValue();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   setPrevValue() {
//     setState(() {
//       _name = "${widget.patientData.firstname} ${widget.patientData.lastname}";
//       _phone = "${widget.patientData.phoneNumber}";
//       _selectedDate = DateTime.parse(widget.patientData.dateOfBirth!);
//       _selectedGender = widget.patientData.gender.isEmpty
//           ? "Other"
//           : widget.patientData.gender == "male"
//               ? "Male"
//               : "Female";
//       print(_selectedGender);
//
//       if (widget.patientData.dateOfBirth != null) {
//         years = widget.patientData.dateOfBirth!.year;
//         months = widget.patientData.dateOfBirth!.month;
//         days = widget.patientData.dateOfBirth!.day;
//       }
//
//       updateBirthdate();
//     });
//   }
//
//   void selectDate(BuildContext context, DateTime? initialDate,
//       Function(DateTime) onDateSelected) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: initialDate ?? DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       onDateSelected(picked);
//     }
//   }
//
//   DateTime calculateBirthdate(int years, int months, int days) {
//     DateTime now = DateTime.now();
//     return DateTime(now.year - years, now.month - months, now.day - days);
//   }
//
//   void updateBirthdate() {
//     setState(() {
//       _selectedDate = calculateBirthdate(years, months, days);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChillScaffold(
//       floatingActionButton: SizedBox(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             ChillAppbar(
//               title: "Patient Update",
//               showBackWidget: true,
//             ),
//             Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   MediCareProTextFormField(
//                     initialValue: _name,
//                     keyboardType: TextInputType.text,
//                     labelText: "Patient\'s Name",
//                     hintText: "Patient\'s Name",
//                     onSaved: (String? value) {
//                       _name = value!;
//                     },
//                     validator: (String? value) {
//                       if (value!.isEmpty) {
//                         return 'This Field is Required';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   MediCareProTextFormField(
//                     initialValue: _phone,
//                     keyboardType: TextInputType.phone,
//                     labelText: 'Phone Number',
//                     hintText: 'Phone Number',
//                     onSaved: (String? value) {
//                       _phone = value!;
//                     },
//                     validator: (String? value) {
//                       bool mobileValid =
//                           RegExp(r'^(?:\+?88|0088)?01[13-9]\d{8}$')
//                               .hasMatch(value!);
//                       if (value == null || value.trim() == "") {
//                         return 'Phone is Required';
//                       }
//                       if (!mobileValid) {
//                         return 'Incorrect Mobile Number';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       selectDate(context, _selectedDate, (pickedDate) {
//                         setState(() {
//                           _selectedDate = pickedDate;
//                           // Calculate the age based on the picked date
//                           AgeModel age = calculateAge(_selectedDate!);
//                           years = age.years;
//                           months = age.months;
//                           days = age.days;
//                         });
//                       });
//                     },
//                     child: MediCareProTextFormField(
//                       textEditingController: TextEditingController(
//                           text: _selectedDate == null
//                               ? ""
//                               : formatDate(_selectedDate!)),
//                       keyboardType: TextInputType.datetime,
//                       labelText: 'Date of Birth',
//                       hintText: 'Date of Birth',
//                       isEnable: false,
//                       onSaved: (String? value) {
//                         // Save logic
//                       },
//                       validator: (String? value) {
//                         if (value!.isEmpty) {
//                           return 'This Field is Required';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   buildAgeFields(),
//                   SizedBox(height: 16.0),
//                   Text(
//                     'Gender*',
//                     style: Theme.of(context).textTheme.titleMedium!,
//                   ),
//                   SizedBox(height: 8.0),
//                   Row(
//                     children: ['Male', 'Female', 'Other'].map((gender) {
//                       return Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _selectedGender = gender;
//                             });
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: 3.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: _selectedGender == gender
//                                     ? Colors.blue
//                                     : Colors.white,
//                                 border: Border.all(color: Colors.grey),
//                                 borderRadius: BorderRadius.circular(5.0),
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: 12.0),
//                               child: Center(
//                                 child: Text(
//                                   gender,
//                                   style: TextStyle(
//                                     color: _selectedGender == gender
//                                         ? Colors.white
//                                         : Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   MediCareProTextFormField(
//                     keyboardType: TextInputType.text,
//                     labelText: 'Occupation',
//                     hintText: 'Search occupation...',
//                     onSaved: (String? value) {
//                       _occupation = value!;
//                     },
//                     validator: (String? value) {
//                       if (value!.isEmpty) {
//                         return 'This Field is Required';
//                       }
//                       return null;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16.0),
//             if (_isExpanded) ...[
//               SizedBox(height: 16.0),
//               Text(
//                 'Blood Group*',
//                 style: Theme.of(context).textTheme.titleMedium!,
//               ),
//               SizedBox(height: 8.0),
//               Wrap(
//                 spacing: 8.0,
//                 children: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
//                     .map((group) {
//                   return ChoiceChip(
//                     label: Text(
//                       group,
//                       style: Theme.of(context).textTheme.titleSmall!,
//                     ),
//                     selected: _selectedBloodGroup == group,
//                     onSelected: (bool selected) {
//                       setState(() {
//                         _selectedBloodGroup = group;
//                       });
//                     },
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 'Demography*',
//                 style: Theme.of(context).textTheme.titleMedium!,
//               ),
//               SizedBox(height: 8.0),
//               Wrap(
//                 spacing: 8.0,
//                 children: ['Urban', 'Semi Urban', 'Rural'].map((option) {
//                   return ChoiceChip(
//                     label: Text(
//                       option,
//                       style: Theme.of(context).textTheme.titleSmall!,
//                     ),
//                     selected: _selectedDemography == option,
//                     onSelected: (bool selected) {
//                       setState(() {
//                         _selectedDemography = option;
//                       });
//                     },
//                   );
//                 }).toList(),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               MediCareProTextFormField(
//                 keyboardType: TextInputType.emailAddress,
//                 labelText: 'Email',
//                 hintText: 'Email',
//                 onChanged: (String? value) {
//                   _email = value!;
//                 },
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               MediCareProTextFormField(
//                 keyboardType: TextInputType.text,
//                 labelText: 'Father\'s Name',
//                 hintText: "Type father\'s name here...",
//                 onChanged: (String? value) {
//                   _fatherName = value!;
//                 },
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               MediCareProTextFormField(
//                 keyboardType: TextInputType.text,
//                 labelText: 'Mother\'s Name',
//                 hintText: "Type mother\'s name here...",
//                 onChanged: (String? value) {
//                   _motherName = value!;
//                 },
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               MediCareProTextFormField(
//                 keyboardType: TextInputType.text,
//                 labelText: 'Spouse\'s Name',
//                 hintText: "Type Spouse\'s name here...",
//                 onChanged: (String? value) {
//                   _spouseName = value!;
//                 },
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               MediCareProTextFormField(
//                 keyboardType: TextInputType.text,
//                 labelText: 'Address',
//                 hintText: "TType address here...",
//                 onChanged: (String? value) {
//                   _addressName = value!;
//                 },
//               ),
//             ],
//             SizedBox(height: 16.0),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     _isExpanded = !_isExpanded;
//                   });
//                 },
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.blue,
//                   backgroundColor: Colors.blue[100],
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(_isExpanded ? 'Show Less' : 'Show More'),
//                     Icon(_isExpanded
//                         ? Icons.arrow_drop_up
//                         : Icons.arrow_drop_down),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Center(
//               child: MediCareProButton(
//                 height: screenSize(context, .1),
//                 width: screenSize(context, .8),
//                 bgColor: AppColors.buttonColor,
//                 isLoading: _isLoading,
//                 onTap: () async {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     setState(() {
//                       _isLoading = true;
//                     });
//
//                     bool isSuccess = await _patientRepository.updatePatient(
//                       patientId: widget.patientData.id,
//                       bloodGroup: _selectedBloodGroup,
//                       occupation: _occupation,
//                       email: _email,
//                       name: _name,
//                       phone: _phone,
//                       dob: DateFormat('yyyy-MM-dd').format(_selectedDate!),
//                       gender: _selectedGender,
//                     );
//
//                     if (isSuccess) {
//                       setState(() {
//                         _isLoading = false;
//                       });
//
//                       ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text("Successfully Updated")));
//                     } else {
//                       setState(() {
//                         _isLoading = false;
//                       });
//                       ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text("Something went wrong")));
//                     }
//                   }
//                 },
//                 title: "Update",
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildAgeFields() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           child: MediCareProTextFormField(
//             isEnable: true,
//             textAlign: TextAlign.left, // Aligns text to the left
//             textEditingController: TextEditingController(
//               text: years.toString(),
//             )..selection = TextSelection.fromPosition(
//                 TextPosition(offset: years.toString().length),
//               ),
//             labelText: 'Years',
//             onChanged: (value) {
//               years = int.tryParse(value) ?? 0;
//               updateBirthdate();
//             },
//           ),
//         ),
//         SizedBox(width: 8.0),
//         Expanded(
//           child: MediCareProTextFormField(
//             isEnable: true,
//             textEditingController:
//                 TextEditingController(text: months.toString())
//                   ..selection = TextSelection.fromPosition(
//                     TextPosition(offset: months.toString().length),
//                   ),
//             labelText: 'Months',
//             onChanged: (value) {
//               months = int.tryParse(value) ?? 0;
//               updateBirthdate();
//             },
//           ),
//         ),
//         SizedBox(width: 8.0),
//         Expanded(
//           child: MediCareProTextFormField(
//             isEnable: true,
//             textEditingController: TextEditingController(text: days.toString())
//               ..selection = TextSelection.fromPosition(
//                 TextPosition(offset: days.toString().length),
//               ),
//             labelText: 'Days',
//             onChanged: (value) {
//               days = int.tryParse(value) ?? 0;
//               updateBirthdate();
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
