// import 'package:animated_reorderable_list/animated_reorderable_list.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:medicare_doctor/configs/custom_size.dart';
// import 'package:medicare_doctor/core/constants/app_colors.dart';
// import 'package:medicare_doctor/features/home_tab/model/advice_model.dart';
// import 'package:medicare_doctor/features/home_tab/model/complaint_model.dart';
// import 'package:medicare_doctor/features/home_tab/model/diagonosis_model.dart';
// import 'package:medicare_doctor/features/home_tab/model/investigation_model.dart';
// import 'package:medicare_doctor/features/home_tab/model/health_plan_model.dart';
// import 'package:medicare_doctor/features/home_tab/repository/rx_repository.dart';
// import 'package:medicare_doctor/features/home_tab/view/complain_details.dart';
// import 'package:medicare_doctor/features/patient/data/models/patient_model.dart';
// import 'package:medicare_doctor/features/patient/presentation/views/patient_add_screen.dart';
// import 'package:medicare_doctor/features/profile_tab/model/profile_model.dart';
// import 'package:medicare_doctor/features/profile_tab/repository/profile_repository.dart';
// import 'package:medicare_doctor/shared/bounching_dialog.dart';
// import 'package:medicare_doctor/shared/custom_list.dart';
// import 'package:medicare_doctor/shared/custom_text_form_field.dart';
// import 'package:medicare_doctor/shared/empty_placeholder.dart';
// import 'package:medicare_doctor/shared/loading_placeholder.dart';
// import 'package:medicare_doctor/shared/medi_care_pro_button.dart';
// import 'package:medicare_doctor/shared/providers/session_provider.dart';
// import 'package:provider/provider.dart';
//
// import 'folllow_up_picker.dart';
//
// class NewRxScreen extends StatefulWidget {
//   @override
//   State<NewRxScreen> createState() => _NewRxScreenState();
// }
//
// class _NewRxScreenState extends State<NewRxScreen> {
//   final RXRepository _rxRepository = RXRepository();
//
//   final ProfileRepository profileRepository = ProfileRepository();
//   ProfileModel? profileModel;
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   //Complaint
//   List<ComplaintData> complainList = [];
//   List<ComplaintData> favoriteComplainList = [];
//   List<ComplaintData> selectedComplainList = [];
//   String searchItem = "";
//   bool _isComplainLoading = false;
//
//   //Medication
//   List<MedicationData> medicationList = [];
//   List<MedicationData> favoriteMedicationList = [];
//   List<MedicationData> selectedMedicationList = [];
//   String medicationSearchItem = "";
//   bool _isMedicationLoading = false;
//
//   //Advice
//   List<AdviceData> adviceList = [];
//   List<AdviceData> favoriteAdviceList = [];
//   List<AdviceData> selectedAdviceList = [];
//   String adviceSearchItem = "";
//   bool _isAdviceLoading = false;
//
//   //Diagnosis
//   List<DiagnosisData> diagnosisList = [];
//   List<DiagnosisData> favoriteDiagnosisList = [];
//   List<DiagnosisData> selectedDiagnosisList = [];
//   String diagnosisSearchItem = "";
//   bool _isDiagnosisLoading = false;
//
//   //Investigation
//   List<InvestigationData> investigationList = [];
//   List<InvestigationData> favoriteInvestigationList = [];
//   List<InvestigationData> selectedInvestigationList = [];
//   String investigationSearchItem = "";
//   bool _isInvestigationLoading = false;
//
//   //Patient
//   List<PatientItem> patientList = [];
//   PatientItem? selectedPatient;
//
//   bool _isOnline = false;
//   bool _isAllListVisible = false;
//   bool _isAllPatientVisible = false;
//   bool _isNew = true;
//   bool _isFollow = false;
//   bool _isReport = false;
//
//   @override
//   void initState() {
//     fetchData();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   fetchData() async {
//     await getProfile();
//
//     await getAllFavoriteComplain();
//     await getAllFavoriteMedication();
//     await getAllFavoriteAdvice();
//     await getAllFavoriteDiagnosis();
//     await getAllFavoriteInvestigation();
//   }
//
//   getProfile() async {
//     profileModel = await profileRepository.getProfile();
//
//     print(profileModel!.firstname);
//     setState(() {});
//   }
//
//   //Complain
//   getAllFavoriteComplain() async {
//     _isComplainLoading = true;
//     ComplaintModel? favoriteComplainModel =
//         await _rxRepository.getComplain(isFavourite: true, search: "");
//     if (favoriteComplainModel != null) {
//       setState(() {
//         favoriteComplainList = favoriteComplainModel.results;
//       });
//       print("Favorite Complain List: ${favoriteComplainList.length}");
//     }
//     _isComplainLoading = false;
//     setState(() {});
//   }
//
//   getAllComplain({required String search}) async {
//     _isComplainLoading = true;
//     ComplaintModel? complainModel =
//         await _rxRepository.getComplain(isFavourite: false, search: search);
//     if (complainModel != null) {
//       setState(() {
//         complainList = complainModel.results;
//       });
//       print("Complain List: ${complainList.length}");
//     }
//     _isComplainLoading = false;
//     setState(() {});
//   }
//
//   void addComplaints(String search) async {
//     if (complainList.isEmpty) {
//       await _rxRepository.addComplain(name: search);
//     }
//     setState(() {});
//   }
//
//   //Medication
//   getAllFavoriteMedication() async {
//     _isMedicationLoading = true;
//     MedicationModel? medicationModel =
//         await _rxRepository.getAllMedication(isFavourite: true, search: "");
//     if (medicationModel != null) {
//       setState(() {
//         favoriteMedicationList = medicationModel.results;
//       });
//       print("favorite Medication List: ${favoriteMedicationList.length}");
//     }
//     _isMedicationLoading = false;
//     setState(() {});
//   }
//
//   getAllMedication({required String search}) async {
//     _isMedicationLoading = true;
//     MedicationModel? medicationModel = await _rxRepository.getAllMedication(
//         isFavourite: false, search: search);
//     if (medicationModel != null) {
//       setState(() {
//         medicationList = medicationModel.results;
//       });
//       print("Medication List: ${medicationList.length}");
//     }
//     _isMedicationLoading = false;
//     setState(() {});
//   }
//
//   void addMedication(String search) async {
//     if (medicationList.isEmpty) {
//       await _rxRepository.addMedication(name: search);
//     }
//     setState(() {});
//   }
//
//   //Advice
//   getAllFavoriteAdvice() async {
//     _isAdviceLoading = true;
//     AdviceModel? adviceModel =
//         await _rxRepository.getAllAdvice(isFavourite: true, search: "");
//     if (adviceModel != null) {
//       setState(() {
//         favoriteAdviceList = adviceModel.results;
//       });
//       print("favoriteAdviceList: ${favoriteAdviceList.length}");
//     }
//     _isAdviceLoading = false;
//     setState(() {});
//   }
//
//   getAllAdvice({required String search}) async {
//     _isAdviceLoading = true;
//     AdviceModel? adviceModel =
//         await _rxRepository.getAllAdvice(isFavourite: false, search: search);
//     if (adviceModel != null) {
//       setState(() {
//         adviceList = adviceModel.results;
//       });
//       print("AdviceList: ${adviceList.length}");
//     }
//     _isAdviceLoading = false;
//     setState(() {});
//   }
//
//   void addAdvice(String search) async {
//     if (adviceList.isEmpty) {
//       await _rxRepository.addAdvice(name: search);
//     }
//   }
//
//   //Diagnosis
//   getAllFavoriteDiagnosis() async {
//     _isDiagnosisLoading = true;
//     DiagnosisModel? diagnosisModel =
//         await _rxRepository.getAllDiagnosis(isFavourite: true, search: "");
//     if (diagnosisModel != null) {
//       setState(() {
//         favoriteDiagnosisList = diagnosisModel.results;
//       });
//
//       print("favoriteDiagnosisList: ${favoriteDiagnosisList.length}");
//     }
//     _isDiagnosisLoading = false;
//     setState(() {});
//   }
//
//   getAllDiagnosis({required String search}) async {
//     _isDiagnosisLoading = true;
//     DiagnosisModel? diagnosisModel =
//         await _rxRepository.getAllDiagnosis(isFavourite: false, search: "");
//     if (diagnosisModel != null) {
//       setState(() {
//         diagnosisList = diagnosisModel.results;
//       });
//
//       print("Diagnosis List: ${diagnosisList.length}");
//     }
//     _isDiagnosisLoading = false;
//     setState(() {});
//   }
//
//   void addDiagnosis(String search) async {
//     if (diagnosisList.isEmpty) {
//       await _rxRepository.addDiagnosis(name: search);
//     }
//   }
//
//   //Investigation
//   getAllFavoriteInvestigation() async {
//     _isInvestigationLoading = true;
//     InvestigationModel? investigationModel =
//         await _rxRepository.getAllInvestigation(isFavourite: true, search: "");
//     if (investigationModel != null) {
//       setState(() {
//         favoriteInvestigationList = investigationModel.results;
//       });
//
//       print("Favorite Investigation List: ${favoriteInvestigationList.length}");
//     }
//     _isInvestigationLoading = false;
//     setState(() {});
//   }
//
//   getAllInvestigation({required String search}) async {
//     _isInvestigationLoading = true;
//     InvestigationModel? investigationModel = await _rxRepository
//         .getAllInvestigation(isFavourite: false, search: search);
//     if (investigationModel != null) {
//       setState(() {
//         investigationList = investigationModel.results;
//       });
//       print("Investigation List: ${investigationList.length}");
//     }
//     _isInvestigationLoading = false;
//     setState(() {});
//   }
//
//   void addInvestigation(String search) async {
//     if (investigationList.isEmpty) {
//       await _rxRepository.addInvestigation(name: search);
//     }
//   }
//
//   void handleClear() {
//     // Handle the clear button press here
//     setState(() {
//       // For example, remove the first item in the list
//       if (selectedComplainList.isNotEmpty) {
//         selectedComplainList.removeAt(0);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final sessionProvider = Provider.of<SessionProvider>(context);
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text(
//           'New Rx',
//           style: Theme.of(context).textTheme.titleMedium!,
//         ),
//         actions: [
//           Switch(
//             value: _isOnline,
//             onChanged: (value) {
//               setState(() {
//                 _isOnline = !_isOnline;
//               });
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 16.0),
//             child: Center(
//               child: Text('Offline',
//                   style: Theme.of(context).textTheme.titleSmall!),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 selectedPatient == null
//                     ? SizedBox(
//                         height: _isAllPatientVisible
//                             ? screenSize(context, .4)
//                             : screenSize(context, .24),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                                 child: GenericListViewer<PatientItem>(
//                               searchFieldVisibility: true,
//                               listVisibility: _isAllPatientVisible,
//                               items: patientList,
//                               onSubmitted: (value) {
//                                 print("On Complain submit: $value");
//                                 _isAllPatientVisible = false;
//                               },
//                               itemBuilder: (item) {
//                                 return GestureDetector(
//                                   onTap: () {
//                                     _isAllPatientVisible = false;
//                                     selectedPatient = item;
//                                     setState(() {});
//                                   },
//                                   child: Column(
//                                     children: [
//                                       patientTile(item: item),
//                                       Divider()
//                                     ],
//                                   ),
//                                 );
//                               },
//                               searchFunction: (item, searchTerm) {
//                                 setState(() {
//                                   _isAllPatientVisible = true;
//                                   searchItem = searchTerm;
//                                 });
//
//                                 print("On searchItem: ${searchItem}");
//
//                                 return item.firstname
//                                     .toLowerCase()
//                                     .contains(searchTerm.toLowerCase());
//                               },
//                               searchHint: 'Search by Patient ...',
//                             )),
//                             SizedBox(width: 8.0),
//                             IconButton(
//                               icon: Icon(Icons.add),
//                               onPressed: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (_) => PatientAddScreen()));
//                                 // Add your onPressed code here!
//                               },
//                             ),
//                           ],
//                         ),
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: patientTile(item: selectedPatient!),
//                       ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ToggleButtons(
//                       isSelected: [_isNew, _isFollow, _isReport],
//                       onPressed: (int index) {
//                         print(index);
//                         if (index == 0) {
//                           setState(() {
//                             _isNew = true;
//                             _isFollow = false;
//                             _isReport = false;
//                           });
//                         } else if (index == 1) {
//                           setState(() {
//                             _isNew = false;
//                             _isFollow = true;
//                             _isReport = false;
//                           });
//                         } else if (index == 2) {
//                           setState(() {
//                             _isNew = false;
//                             _isFollow = false;
//                             _isReport = true;
//                           });
//                         }
//
//                         // Add your onPressed code here!
//                       },
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                           child: Text(
//                             'New',
//                             style: Theme.of(context).textTheme.titleSmall!,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                           child: Text(
//                             'Follow-up',
//                             style: Theme.of(context).textTheme.titleSmall!,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                           child: Text(
//                             'Report',
//                             style: Theme.of(context).textTheme.titleSmall!,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           DefaultTabController(
//             length: 6,
//             child: Expanded(
//               child: Column(
//                 children: [
//                   TabBar(
//                     isScrollable: true,
//                     labelStyle: Theme.of(context).textTheme.titleSmall!,
//                     tabs: [
//                       Tab(text: 'Complaint'),
//                       Tab(text: 'Medication'),
//                       Tab(text: 'Advice'),
//                       Tab(text: 'Diagnosis'),
//                       Tab(text: 'Investigation'),
//                       Tab(text: 'Follow-up'),
//                     ],
//                   ),
//                   Expanded(
//                     child: TabBarView(
//                       children: [
//                         _buildComplaintTab(),
//                         _buildMedicationTab(),
//                         _buildAdviceTab(),
//                         _buildDiagnosisTab(),
//                         _buildInvestigationTab(),
//                         _buildFollow_upTab(sessionProvider),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       endDrawer: Drawer(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 8.0),
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               SizedBox(
//                 height: screenSize(context, .15),
//               ),
//               Text(
//                 "Rx Preview",
//                 style: Theme.of(context).textTheme.titleMedium!,
//               ),
//               selectedComplainList.isEmpty
//                   ? SizedBox()
//                   : GenericListWidget<ComplaintData>(
//                       title: "Complain",
//                       itemList: selectedComplainList,
//                       itemNameExtractor: (item) => item.name,
//                       onClear: handleClear,
//                     ),
//               selectedMedicationList.isEmpty
//                   ? SizedBox()
//                   : GenericListWidget<MedicationData>(
//                       title: "Medication",
//                       itemList: selectedMedicationList,
//                       itemNameExtractor: (item) => item.name,
//                       onClear: handleClear,
//                     ),
//               selectedAdviceList.isEmpty
//                   ? SizedBox()
//                   : GenericListWidget<AdviceData>(
//                       title: "Advice",
//                       itemList: selectedAdviceList,
//                       itemNameExtractor: (item) => item.name,
//                       onClear: handleClear,
//                     ),
//               selectedDiagnosisList.isEmpty
//                   ? SizedBox()
//                   : GenericListWidget<DiagnosisData>(
//                       title: "Diagnosis",
//                       itemList: selectedDiagnosisList,
//                       itemNameExtractor: (item) => item.name,
//                       onClear: handleClear,
//                     ),
//               selectedInvestigationList.isEmpty
//                   ? SizedBox()
//                   : GenericListWidget<InvestigationData>(
//                       title: "Investigation",
//                       itemList: selectedInvestigationList,
//                       itemNameExtractor: (item) => item.name,
//                       onClear: handleClear,
//                     ),
//               sessionProvider.getFollowUpDate == null
//                   ? SizedBox()
//                   : Text(
//                       "Follow-up ",
//                       style: Theme.of(context)
//                           .textTheme
//                           .titleSmall!
//                           .copyWith(color: Colors.blue),
//                     ),
//               sessionProvider.getFollowUpDate == null
//                   ? SizedBox()
//                   : Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             "Follow-up on ${convertAndFormatDate(sessionProvider.getFollowUpDate!)}",
//                             style: Theme.of(context).textTheme.bodySmall!,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.clear,
//                             color: Colors.redAccent,
//                           ),
//                         ),
//                       ],
//                     ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//               icon: Icon(Icons.settings),
//               onPressed: () {
//                 showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: true,
//                   builder: (BuildContext context) {
//                     return StatefulBuilder(builder:
//                         (BuildContext context, StateSetter modalState) {
//                       return SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.15,
//                           child: Padding(
//                             padding: const EdgeInsets.all(18.0),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("More Option"),
//                                     IconButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         icon: Icon(Icons.clear))
//                                   ],
//                                 ),
//                                 Spacer(),
//                                 GestureDetector(
//                                   onTap: () async {
//                                     modalState(() {
//                                       sessionProvider.setFollowUpDate("");
//                                       selectedPatient = null;
//                                       selectedComplainList = [];
//                                       selectedMedicationList = [];
//                                       selectedAdviceList = [];
//                                       selectedDiagnosisList = [];
//                                       selectedInvestigationList = [];
//                                     });
//                                     Navigator.pop(context);
//                                   },
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Icon(Icons.backspace_outlined),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Text("Clear All"),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ));
//                     });
//                   },
//                 );
//
//                 // Add your onPressed code here!
//               },
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 print("-----------------------");
//
//                 if (selectedPatient != null) {
//                   bool isSuccess = await _rxRepository.createPrescription(
//                     name: "From App",
//                     doctorId: profileModel!.id,
//                     patientId: selectedPatient!.id,
//                     prescriptionType: "CURRENT",
//                     historyProp1: "historyProp1",
//                     complaintList: complainList,
//                     investigationList: investigationList,
//                     diagnosisList: diagnosisList,
//                     medicationList: [],
//                     adviceList: [],
//                     followUpDate: sessionProvider.getFollowUpDate == null
//                         ? ""
//                         : sessionProvider.getFollowUpDate!,
//                   );
//
//                   if (isSuccess) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text("Successfully Created"),
//                       ),
//                     );
//                   }
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text("Patient Select First"),
//                     ),
//                   );
//                 }
//
//                 // Add your onPressed code here!
//               },
//               child: Text(
//                 'Save Rx',
//                 style: Theme.of(context).textTheme.bodyMedium!,
//               ),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(150, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.visibility),
//               onPressed: () {
//                 _scaffoldKey.currentState?.openEndDrawer();
//                 // Add your onPressed code here!
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget patientTile({required PatientItem item}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
//       decoration: BoxDecoration(
//           color: AppColors.card2Color,
//           borderRadius: BorderRadius.all(Radius.circular(5))),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 20,
//             child: Icon(Icons.person),
//           ),
//           SizedBox(
//             width: 5,
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "${item.firstname} ${item.lastname}",
//                 style: Theme.of(context).textTheme.titleSmall!,
//               ),
//               Text(
//                 item.phoneNumber,
//                 style: Theme.of(context).textTheme.bodySmall!,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildComplaintTab() {
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Stack(
//         children: [
//           SizedBox(
//             height: 10,
//           ),
//           favoriteComplainList.isEmpty
//               ? SizedBox()
//               : Padding(
//                   padding: const EdgeInsets.only(top: 10.0),
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: favoriteComplainList.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           if (!selectedComplainList
//                               .contains(favoriteComplainList[index])) {
//                             setState(() {
//                               selectedComplainList
//                                   .add(favoriteComplainList[index]);
//                               selectedComplainList.toSet().toList();
//                             });
//                           }
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: Text(
//                             "🤍 ${favoriteComplainList[index].name}",
//                             style: Theme.of(context).textTheme.titleSmall!,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//           selectedComplainList.isEmpty
//               ? SizedBox()
//               : Padding(
//                   padding: const EdgeInsets.only(top: 120.0),
//                   child: AnimatedReorderableListView(
//                     isSameItem: (a, b) => a.id == b.id,
//                     items: selectedComplainList,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Padding(
//                         key: Key("${selectedComplainList[index].id}${index}"),
//                         padding: const EdgeInsets.symmetric(vertical: 3.0),
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (_) => ComplainDetailsScreen()));
//                           },
//                           child: Container(
//                               padding: const EdgeInsets.all(5.0),
//                               decoration: BoxDecoration(
//                                   color: AppColors.whiteColor,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(5))),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(selectedComplainList[index].name),
//                                   IconButton(
//                                       onPressed: () {
//                                         setState(() {
//                                           selectedComplainList.remove(
//                                               selectedComplainList[index]);
//                                         });
//                                       },
//                                       icon: Icon(Icons.close))
//                                 ],
//                               )),
//                         ),
//                       );
//                     },
//                     enterTransition: [FlipInX(), ScaleIn()],
//                     exitTransition: [SlideInLeft()],
//                     insertDuration: const Duration(milliseconds: 300),
//                     removeDuration: const Duration(milliseconds: 300),
//                     onReorder: (int oldIndex, int newIndex) {
//                       setState(() {
//                         ComplaintData complainData =
//                             selectedComplainList.removeAt(oldIndex);
//                         selectedComplainList.insert(newIndex, complainData);
//                       });
//                     },
//                   ),
//                 ),
//           Padding(
//             padding:
//                 EdgeInsets.only(top: favoriteComplainList.isEmpty ? 10 : 50.0),
//             child: MediCareProTextFormField(
//               hintText: "Search by complain",
//               prefixIconData: Icons.search,
//               onChanged: (String value) {
//                 getAllComplain(search: value);
//                 setState(() {
//                   _isAllListVisible = true;
//                 });
//                 print(value);
//               },
//               onFieldSubmitted: (value) {
//                 addComplaints(value);
//                 setState(() {
//                   _isAllListVisible = false;
//                 });
//               },
//             ),
//           ),
//           _isComplainLoading
//               ? LoadingPlaceHolder()
//               : complainList.isEmpty
//                   ? GestureDetector(
//                       onTap: () {
//                         _rxRepository.RefreshToken();
//                       },
//                       child: EmptyPlaceHolder())
//                   : _isAllListVisible
//                       ? Padding(
//                           padding: const EdgeInsets.only(top: 120.0),
//                           child: ListView.builder(
//                             itemCount: complainList.length,
//                             itemBuilder: (context, index) {
//                               var item = complainList[index];
//                               bool _isFavorite = item.isFavourite;
//                               return GestureDetector(
//                                 onTap: () {
//                                   if (!selectedComplainList.contains(item)) {
//                                     selectedComplainList.add(item);
//                                     selectedComplainList.toSet().toList();
//                                   }
//                                   setState(() {
//                                     _isAllListVisible = false;
//                                   });
//                                 },
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 1.0),
//                                   child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 5.0),
//                                       decoration: BoxDecoration(
//                                           color: AppColors.card2Color,
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(5))),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             item.name,
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .titleSmall!,
//                                           ),
//                                           IconButton(
//                                             onPressed: () async {
//                                               await _rxRepository
//                                                   .updateComplain(
//                                                       complementUUID: item.id,
//                                                       isFavorite: _isFavorite
//                                                           ? false
//                                                           : true)
//                                                   .then((value) =>
//                                                       getAllComplain(
//                                                           search: ""))
//                                                   .then((value) {
//                                                 if (!selectedComplainList
//                                                     .contains(item)) {
//                                                   selectedComplainList
//                                                       .add(item);
//                                                   selectedComplainList
//                                                       .toSet()
//                                                       .toList();
//                                                 }
//
//                                                 setState(() {});
//                                                 _isAllListVisible = false;
//                                               });
//                                             },
//                                             icon: Icon(_isFavorite
//                                                 ? Icons.favorite
//                                                 : Icons.favorite_outline),
//                                           )
//                                         ],
//                                       )),
//                                 ),
//                               );
//                             },
//                           ),
//                         )
//                       : SizedBox(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMedicationTab() {
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Stack(
//         children: [
//           favoriteMedicationList.isEmpty
//               ? SizedBox()
//               : Padding(
//                   padding: const EdgeInsets.only(top: 20.0),
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: favoriteMedicationList.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           if (!selectedMedicationList
//                               .contains(favoriteMedicationList[index])) {
//                             setState(() {
//                               selectedMedicationList
//                                   .add(favoriteMedicationList[index]);
//                               selectedMedicationList.toSet().toList();
//                             });
//                           }
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: Text(
//                             "🤍 ${favoriteMedicationList[index].name}",
//                             style: Theme.of(context).textTheme.titleSmall!,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//           Padding(
//             padding: const EdgeInsets.only(top: 120.0),
//             child: AnimatedReorderableListView(
//               isSameItem: (a, b) => a.id == b.id,
//               items: selectedMedicationList,
//               itemBuilder: (BuildContext context, int index) {
//                 return Padding(
//                   key: Key("${selectedMedicationList[index].id}${index}"),
//                   padding: const EdgeInsets.symmetric(vertical: 3.0),
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => ComplainDetailsScreen()));
//                     },
//                     child: Container(
//                         padding: const EdgeInsets.all(5.0),
//                         decoration: BoxDecoration(
//                             color: AppColors.whiteColor,
//                             borderRadius: BorderRadius.all(Radius.circular(5))),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               selectedMedicationList[index].name,
//                               style: Theme.of(context).textTheme.titleSmall!,
//                             ),
//                             IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     selectedMedicationList
//                                         .remove(selectedMedicationList[index]);
//                                   });
//                                 },
//                                 icon: Icon(Icons.close))
//                           ],
//                         )),
//                   ),
//                 );
//               },
//               enterTransition: [FlipInX(), ScaleIn()],
//               exitTransition: [SlideInLeft()],
//               insertDuration: const Duration(milliseconds: 300),
//               removeDuration: const Duration(milliseconds: 300),
//               onReorder: (int oldIndex, int newIndex) {
//                 setState(() {
//                   MedicationData medicationData =
//                       selectedMedicationList.removeAt(oldIndex);
//                   selectedMedicationList.insert(newIndex, medicationData);
//                 });
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//                 top: favoriteMedicationList.isEmpty ? 10 : 50.0),
//             child: MediCareProTextFormField(
//               hintText: "Search by Medication",
//               prefixIconData: Icons.search,
//               onChanged: (String value) {
//                 getAllMedication(search: value);
//                 setState(() {
//                   _isAllListVisible = true;
//                 });
//                 print(value);
//               },
//               onFieldSubmitted: (value) {
//                 addMedication(value);
//                 setState(() {
//                   _isAllListVisible = false;
//                 });
//               },
//             ),
//           ),
//           _isMedicationLoading
//               ? LoadingPlaceHolder()
//               : medicationList.isEmpty
//                   ? EmptyPlaceHolder()
//                   : _isAllListVisible
//                       ? Padding(
//                           padding: const EdgeInsets.only(top: 120.0),
//                           child: ListView.builder(
//                             itemCount: medicationList.length,
//                             itemBuilder: (context, index) {
//                               var item = medicationList[index];
//                               bool _isFavorite = item.isFavourite;
//                               return GestureDetector(
//                                 onTap: () {
//                                   if (!selectedMedicationList.contains(item)) {
//                                     selectedMedicationList.add(item);
//                                     selectedMedicationList.toSet().toList();
//                                   }
//                                   setState(() {
//                                     _isAllListVisible = false;
//                                   });
//                                 },
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 1.0),
//                                   child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 5.0),
//                                       decoration: BoxDecoration(
//                                           color: AppColors.card2Color,
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(5))),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             item.name,
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .titleSmall!,
//                                           ),
//                                           IconButton(
//                                             onPressed: () async {
//                                               await _rxRepository
//                                                   .updateMedication(
//                                                       medicationUUID: item.id,
//                                                       isFavorite: _isFavorite
//                                                           ? false
//                                                           : true)
//                                                   .then((value) =>
//                                                       getAllMedication(
//                                                           search: ""))
//                                                   .then((value) {
//                                                 if (!selectedMedicationList
//                                                     .contains(item)) {
//                                                   selectedMedicationList
//                                                       .add(item);
//                                                   selectedMedicationList
//                                                       .toSet()
//                                                       .toList();
//                                                 }
//
//                                                 setState(() {});
//                                                 _isAllListVisible = false;
//                                               });
//                                             },
//                                             icon: Icon(_isFavorite
//                                                 ? Icons.favorite
//                                                 : Icons.favorite_outline),
//                                           )
//                                         ],
//                                       )),
//                                 ),
//                               );
//                             },
//                           ),
//                         )
//                       : SizedBox(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAdviceTab() {
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Stack(
//         children: [
//           SizedBox(
//             height: 10,
//           ),
//           favoriteAdviceList.isEmpty
//               ? SizedBox()
//               : Padding(
//                   padding: const EdgeInsets.only(top: 10.0),
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: favoriteAdviceList.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           if (!selectedAdviceList
//                               .contains(favoriteAdviceList[index])) {
//                             setState(() {
//                               selectedAdviceList.add(favoriteAdviceList[index]);
//                               selectedAdviceList.toSet().toList();
//                             });
//                           }
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: Text(
//                             "🤍 ${favoriteAdviceList[index].name}",
//                             style: Theme.of(context).textTheme.titleSmall!,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//           Padding(
//             padding: const EdgeInsets.only(top: 120.0),
//             child: AnimatedReorderableListView(
//               isSameItem: (a, b) => a.id == b.id,
//               items: selectedAdviceList,
//               itemBuilder: (BuildContext context, int index) {
//                 return Padding(
//                   key: Key("${selectedAdviceList[index].id}${index}"),
//                   padding: const EdgeInsets.symmetric(vertical: 3.0),
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => ComplainDetailsScreen()));
//                     },
//                     child: Container(
//                         padding: const EdgeInsets.all(5.0),
//                         decoration: BoxDecoration(
//                             color: AppColors.whiteColor,
//                             borderRadius: BorderRadius.all(Radius.circular(5))),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               selectedAdviceList[index].name,
//                               style: Theme.of(context).textTheme.titleSmall!,
//                             ),
//                             IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     selectedAdviceList
//                                         .remove(selectedAdviceList[index]);
//                                   });
//                                 },
//                                 icon: Icon(Icons.close))
//                           ],
//                         )),
//                   ),
//                 );
//               },
//               enterTransition: [FlipInX(), ScaleIn()],
//               exitTransition: [SlideInLeft()],
//               insertDuration: const Duration(milliseconds: 300),
//               removeDuration: const Duration(milliseconds: 300),
//               onReorder: (int oldIndex, int newIndex) {
//                 setState(() {
//                   AdviceData adviceData = selectedAdviceList.removeAt(oldIndex);
//                   selectedAdviceList.insert(newIndex, adviceData);
//                 });
//               },
//             ),
//           ),
//           Padding(
//             padding:
//                 EdgeInsets.only(top: favoriteAdviceList.isEmpty ? 10 : 50.0),
//             child: MediCareProTextFormField(
//               hintText: "Search by Advice",
//               prefixIconData: Icons.search,
//               onChanged: (String value) {
//                 getAllAdvice(search: value);
//                 setState(() {
//                   _isAllListVisible = true;
//                 });
//                 print(value);
//               },
//               onFieldSubmitted: (value) {
//                 addAdvice(value);
//                 setState(() {
//                   _isAllListVisible = false;
//                 });
//               },
//             ),
//           ),
//           _isAdviceLoading
//               ? LoadingPlaceHolder()
//               : adviceList.isEmpty
//                   ? EmptyPlaceHolder()
//                   : _isAllListVisible
//                       ? Padding(
//                           padding: const EdgeInsets.only(top: 120.0),
//                           child: ListView.builder(
//                             itemCount: adviceList.length,
//                             itemBuilder: (context, index) {
//                               var item = adviceList[index];
//                               bool _isFavorite = item.isFavourite;
//                               return GestureDetector(
//                                 onTap: () {
//                                   if (!selectedAdviceList.contains(item)) {
//                                     selectedAdviceList.add(item);
//                                     selectedAdviceList.toSet().toList();
//                                   }
//                                   setState(() {
//                                     _isAllListVisible = false;
//                                   });
//                                 },
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 1.0),
//                                   child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 5.0),
//                                       decoration: BoxDecoration(
//                                           color: AppColors.card2Color,
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(5))),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             item.name,
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .titleSmall!,
//                                           ),
//                                           IconButton(
//                                             onPressed: () async {
//                                               await _rxRepository
//                                                   .updateAdvice(
//                                                       adviceUUID: item.id,
//                                                       isFavorite: _isFavorite
//                                                           ? false
//                                                           : true)
//                                                   .then((value) =>
//                                                       getAllMedication(
//                                                           search: ""))
//                                                   .then((value) {
//                                                 if (!selectedAdviceList
//                                                     .contains(item)) {
//                                                   selectedAdviceList.add(item);
//                                                   selectedAdviceList
//                                                       .toSet()
//                                                       .toList();
//                                                 }
//
//                                                 setState(() {});
//                                                 _isAllListVisible = false;
//                                               });
//                                             },
//                                             icon: Icon(_isFavorite
//                                                 ? Icons.favorite
//                                                 : Icons.favorite_outline),
//                                           )
//                                         ],
//                                       )),
//                                 ),
//                               );
//                             },
//                           ),
//                         )
//                       : SizedBox(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDiagnosisTab() {
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Stack(
//         children: [
//           SizedBox(
//             height: 10,
//           ),
//           favoriteDiagnosisList.isEmpty
//               ? SizedBox()
//               : Padding(
//                   padding: const EdgeInsets.only(top: 10.0),
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: favoriteDiagnosisList.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           if (!selectedDiagnosisList
//                               .contains(favoriteDiagnosisList[index])) {
//                             setState(() {
//                               selectedDiagnosisList
//                                   .add(favoriteDiagnosisList[index]);
//                               selectedDiagnosisList.toSet().toList();
//                             });
//                           }
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: Text(
//                             "🤍 ${favoriteDiagnosisList[index].name}",
//                             style: Theme.of(context).textTheme.titleSmall!,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//           Padding(
//             padding: const EdgeInsets.only(top: 120.0),
//             child: AnimatedReorderableListView(
//               isSameItem: (a, b) => a.id == b.id,
//               items: selectedDiagnosisList,
//               itemBuilder: (BuildContext context, int index) {
//                 return Padding(
//                   key: Key("${selectedDiagnosisList[index].id}${index}"),
//                   padding: const EdgeInsets.symmetric(vertical: 3.0),
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => ComplainDetailsScreen()));
//                     },
//                     child: Container(
//                         padding: const EdgeInsets.all(5.0),
//                         decoration: BoxDecoration(
//                             color: AppColors.whiteColor,
//                             borderRadius: BorderRadius.all(Radius.circular(5))),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               selectedDiagnosisList[index].name,
//                               style: Theme.of(context).textTheme.titleSmall!,
//                             ),
//                             IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     selectedDiagnosisList
//                                         .remove(selectedDiagnosisList[index]);
//                                   });
//                                 },
//                                 icon: Icon(Icons.close))
//                           ],
//                         )),
//                   ),
//                 );
//               },
//               enterTransition: [FlipInX(), ScaleIn()],
//               exitTransition: [SlideInLeft()],
//               insertDuration: const Duration(milliseconds: 300),
//               removeDuration: const Duration(milliseconds: 300),
//               onReorder: (int oldIndex, int newIndex) {
//                 setState(() {
//                   DiagnosisData diagnosisData =
//                       selectedDiagnosisList.removeAt(oldIndex);
//                   selectedDiagnosisList.insert(newIndex, diagnosisData);
//                 });
//               },
//             ),
//           ),
//           Padding(
//             padding:
//                 EdgeInsets.only(top: favoriteDiagnosisList.isEmpty ? 10 : 50.0),
//             child: MediCareProTextFormField(
//               hintText: "Search by Diagnosis",
//               prefixIconData: Icons.search,
//               onChanged: (String value) {
//                 getAllDiagnosis(search: value);
//                 setState(() {
//                   _isAllListVisible = true;
//                 });
//                 print(value);
//               },
//               onFieldSubmitted: (value) {
//                 addDiagnosis(value);
//                 setState(() {
//                   _isAllListVisible = false;
//                 });
//               },
//             ),
//           ),
//           _isDiagnosisLoading
//               ? LoadingPlaceHolder()
//               : diagnosisList.isEmpty
//                   ? EmptyPlaceHolder()
//                   : _isAllListVisible
//                       ? Padding(
//                           padding: const EdgeInsets.only(top: 120.0),
//                           child: ListView.builder(
//                             itemCount: diagnosisList.length,
//                             itemBuilder: (context, index) {
//                               var item = diagnosisList[index];
//                               bool _isFavorite = item.isFavourite;
//                               return GestureDetector(
//                                 onTap: () {
//                                   if (!selectedDiagnosisList.contains(item)) {
//                                     selectedDiagnosisList.add(item);
//                                     selectedDiagnosisList.toSet().toList();
//                                   }
//                                   setState(() {
//                                     _isAllListVisible = false;
//                                   });
//                                 },
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 1.0),
//                                   child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 5.0),
//                                       decoration: BoxDecoration(
//                                           color: AppColors.card2Color,
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(5))),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             item.name,
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .titleSmall!,
//                                           ),
//                                           IconButton(
//                                             onPressed: () async {
//                                               await _rxRepository
//                                                   .updateDiagnosis(
//                                                       diagnosisUUID: item.id,
//                                                       isFavorite: _isFavorite
//                                                           ? false
//                                                           : true)
//                                                   .then((value) =>
//                                                       getAllDiagnosis(
//                                                           search: ""))
//                                                   .then((value) {
//                                                 if (!selectedDiagnosisList
//                                                     .contains(item)) {
//                                                   selectedDiagnosisList
//                                                       .add(item);
//                                                   selectedDiagnosisList
//                                                       .toSet()
//                                                       .toList();
//                                                 }
//
//                                                 setState(() {});
//                                                 _isAllListVisible = false;
//                                               });
//                                             },
//                                             icon: Icon(_isFavorite
//                                                 ? Icons.favorite
//                                                 : Icons.favorite_outline),
//                                           )
//                                         ],
//                                       )),
//                                 ),
//                               );
//                             },
//                           ),
//                         )
//                       : SizedBox(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInvestigationTab() {
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Stack(
//         children: [
//           SizedBox(
//             height: 10,
//           ),
//           favoriteInvestigationList.isEmpty
//               ? SizedBox()
//               : Padding(
//                   padding: const EdgeInsets.only(top: 10.0),
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: favoriteInvestigationList.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           if (!selectedInvestigationList
//                               .contains(favoriteInvestigationList[index])) {
//                             setState(() {
//                               selectedInvestigationList
//                                   .add(favoriteInvestigationList[index]);
//                               selectedInvestigationList.toSet().toList();
//                             });
//                           }
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: Text(
//                             "🤍 ${favoriteInvestigationList[index].name}",
//                             style: Theme.of(context).textTheme.titleSmall!,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//           Padding(
//             padding: const EdgeInsets.only(top: 120.0),
//             child: AnimatedReorderableListView(
//               isSameItem: (a, b) => a.id == b.id,
//               items: selectedInvestigationList,
//               itemBuilder: (BuildContext context, int index) {
//                 return Padding(
//                   key: Key("${selectedInvestigationList[index].id}${index}"),
//                   padding: const EdgeInsets.symmetric(vertical: 3.0),
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => ComplainDetailsScreen()));
//                     },
//                     child: Container(
//                         padding: const EdgeInsets.all(5.0),
//                         decoration: BoxDecoration(
//                             color: AppColors.whiteColor,
//                             borderRadius: BorderRadius.all(Radius.circular(5))),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               selectedInvestigationList[index].name,
//                               style: Theme.of(context).textTheme.titleSmall!,
//                             ),
//                             IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     selectedInvestigationList.remove(
//                                         selectedInvestigationList[index]);
//                                   });
//                                 },
//                                 icon: Icon(Icons.close))
//                           ],
//                         )),
//                   ),
//                 );
//               },
//               enterTransition: [FlipInX(), ScaleIn()],
//               exitTransition: [SlideInLeft()],
//               insertDuration: const Duration(milliseconds: 300),
//               removeDuration: const Duration(milliseconds: 300),
//               onReorder: (int oldIndex, int newIndex) {
//                 setState(() {
//                   InvestigationData investigationData =
//                       selectedInvestigationList.removeAt(oldIndex);
//                   selectedInvestigationList.insert(newIndex, investigationData);
//                 });
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//                 top: favoriteInvestigationList.isEmpty ? 10 : 50.0),
//             child: MediCareProTextFormField(
//               hintText: "Search by Investigation",
//               prefixIconData: Icons.search,
//               onChanged: (String value) {
//                 getAllInvestigation(search: value);
//                 setState(() {
//                   _isAllListVisible = true;
//                 });
//                 print(value);
//               },
//               onFieldSubmitted: (value) {
//                 addInvestigation(value);
//                 setState(() {
//                   _isAllListVisible = false;
//                 });
//               },
//             ),
//           ),
//           _isInvestigationLoading
//               ? LoadingPlaceHolder()
//               : investigationList.isEmpty
//                   ? EmptyPlaceHolder()
//                   : _isAllListVisible
//                       ? Padding(
//                           padding: const EdgeInsets.only(top: 120.0),
//                           child: ListView.builder(
//                             itemCount: investigationList.length,
//                             itemBuilder: (context, index) {
//                               var item = investigationList[index];
//                               bool _isFavorite = item.isFavourite;
//                               return GestureDetector(
//                                 onTap: () {
//                                   if (!selectedInvestigationList
//                                       .contains(item)) {
//                                     selectedInvestigationList.add(item);
//                                     selectedInvestigationList.toSet().toList();
//                                   }
//                                   setState(() {
//                                     _isAllListVisible = false;
//                                   });
//                                 },
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 1.0),
//                                   child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 5.0),
//                                       decoration: BoxDecoration(
//                                           color: AppColors.card2Color,
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(5))),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             item.name,
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .titleSmall!,
//                                           ),
//                                           IconButton(
//                                             onPressed: () async {
//                                               await _rxRepository
//                                                   .updateInvestigation(
//                                                       investigationUUID:
//                                                           item.id,
//                                                       isFavorite: _isFavorite
//                                                           ? false
//                                                           : true)
//                                                   .then((value) =>
//                                                       getAllInvestigation(
//                                                           search: ""))
//                                                   .then((value) {
//                                                 if (!selectedInvestigationList
//                                                     .contains(item)) {
//                                                   selectedInvestigationList
//                                                       .add(item);
//                                                   selectedInvestigationList
//                                                       .toSet()
//                                                       .toList();
//                                                 }
//
//                                                 setState(() {});
//                                                 _isAllListVisible = false;
//                                               });
//                                             },
//                                             icon: Icon(_isFavorite
//                                                 ? Icons.favorite
//                                                 : Icons.favorite_outline),
//                                           )
//                                         ],
//                                       )),
//                                 ),
//                               );
//                             },
//                           ),
//                         )
//                       : SizedBox(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFollow_upTab(SessionProvider sessionProvider) {
//     return Center(
//         child: Column(
//       children: [
//         SizedBox(
//           height: 10,
//         ),
//         MediCareProButton(
//             title: '+ Select a date for Follow-up',
//             height: 50,
//             width: screenSize(context, .9),
//             bgColor: AppColors.secondary,
//             onTap: () {
//               print("-----------------------");
//               print(sessionProvider.getFollowUpDate);
//               showDialog(
//                 context: context,
//                 builder: (_) => BounchingDialog(
//                   height: screenSize(context, 1.5),
//                   child: FollowUpPicker(),
//                 ),
//               );
//             },
//             isLoading: false),
//         sessionProvider.getFollowUpDate == null
//             ? SizedBox()
//             : Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             showDialog(
//                               context: context,
//                               builder: (_) => BounchingDialog(
//                                 height: screenSize(context, 1.5),
//                                 child: FollowUpPicker(),
//                               ),
//                             );
//                           },
//                           icon: Icon(Icons.edit)),
//                       Expanded(
//                         child: Text(
//                           "Follow-up on ${convertAndFormatDate(sessionProvider.getFollowUpDate!)}",
//                           style: Theme.of(context).textTheme.bodySmall!,
//                         ),
//                       ),
//                       Spacer(),
//                       IconButton(
//                           onPressed: () {
//                             sessionProvider.setFollowUpDate(null);
//                           },
//                           icon: Icon(Icons.clear)),
//                     ],
//                   ),
//                 ),
//               )
//       ],
//     ));
//   }
//
//   String convertAndFormatDate(String dateString) {
//     // Parse the input date string
//     final inputDate = DateFormat('dd-MM-yyyy').parse(dateString);
//
//     // Calculate the difference from now
//     final now = DateTime.now();
//     final difference = inputDate.difference(now).inDays;
//
//     // Format the input date
//     final formatter = DateFormat('EEE, MMM d, yyyy');
//     final formattedDate = formatter.format(inputDate);
//
//     // Return the formatted date with the difference in days
//     return '$formattedDate ($difference days)';
//   }
// }
//
// class GenericListWidget<T> extends StatelessWidget {
//   final List<T> itemList;
//
//   final String title;
//   final String Function(T) itemNameExtractor;
//   final VoidCallback onClear;
//
//   GenericListWidget({
//     required this.title,
//     required this.itemList,
//     required this.itemNameExtractor,
//     required this.onClear,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: Theme.of(context)
//               .textTheme
//               .titleSmall!
//               .copyWith(color: Colors.blue),
//         ),
//         for (T item in itemList)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 itemNameExtractor(item),
//                 style: Theme.of(context).textTheme.bodySmall!,
//               ),
//               IconButton(
//                 onPressed: onClear,
//                 icon: Icon(
//                   Icons.clear,
//                   color: Colors.redAccent,
//                 ),
//               ),
//             ],
//           ),
//       ],
//     );
//   }
// }
