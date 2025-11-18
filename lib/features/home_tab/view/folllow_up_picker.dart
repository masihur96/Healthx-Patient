// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:medicare_doctor/core/constants/app_colors.dart';
// import 'package:medicare_doctor/shared/providers/session_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class FollowUpPicker extends StatefulWidget {
//   const FollowUpPicker({super.key});
//
//   @override
//   State<FollowUpPicker> createState() => _FollowUpPickerState();
// }
//
// class _FollowUpPickerState extends State<FollowUpPicker> {
//   String _selectedDate = "";
//
// // Function to add days to the current date
//   DateTime addDays(int daysToAdd) {
//     final now = DateTime.now();
//     return now.add(Duration(days: daysToAdd));
//   }
//
// // Function to add months to the current date
//   DateTime addMonths(int monthsToAdd) {
//     final now = DateTime.now();
//     final newMonth = now.month + monthsToAdd;
//     final newYear = now.year + (newMonth - 1) ~/ 12;
//     final adjustedMonth = (newMonth - 1) % 12 + 1;
//     final daysInMonth = DateTime(newYear, adjustedMonth + 1, 0).day;
//
//     return DateTime(
//         newYear, adjustedMonth, now.day > daysInMonth ? daysInMonth : now.day);
//   }
//
// // Function to add years to the current date
//   DateTime addYears(int yearsToAdd) {
//     final now = DateTime.now();
//     final newYear = now.year + yearsToAdd;
//     return DateTime(newYear, now.month, now.day);
//   }
//
//   // Utility function to format the date
//   String formatDate(DateTime date) {
//     final formatter = DateFormat('dd-MM-yyyy');
//     return formatter.format(date);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'New Rx',
//           style: Theme.of(context).textTheme.titleMedium!,
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0),
//           child: Column(
//             children: [
//               Text(
//                 "Follow-up after:",
//                 style: Theme.of(context).textTheme.bodyMedium!,
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   selectDay(
//                       title: "3 Days",
//                       onTap: () {
//                         setState(() {
//                           _selectedDate = formatDate(addDays(3));
//                         });
//                         Provider.of<SessionProvider>(context, listen: false)
//                             .setFollowUpDate(_selectedDate);
//
//                         Navigator.pop(context);
//                         print('3 Days Later: ${formatDate(addDays(3))}');
//                       }),
//                   selectDay(
//                       title: "5 Days",
//                       onTap: () {
//                         setState(() {
//                           _selectedDate = formatDate(addDays(5));
//                         });
//                         Provider.of<SessionProvider>(context, listen: false)
//                             .setFollowUpDate(_selectedDate);
//
//                         Navigator.pop(context);
//                         print('5 Days Later: ${formatDate(addDays(5))}');
//                       }),
//                   selectDay(
//                       title: "7 Days",
//                       onTap: () {
//                         setState(() {
//                           _selectedDate = formatDate(addDays(7));
//                         });
//                         Provider.of<SessionProvider>(context, listen: false)
//                             .setFollowUpDate(_selectedDate);
//
//                         Navigator.pop(context);
//                         print('7 Days Later: ${formatDate(addDays(7))}');
//                       }),
//                   selectDay(
//                       title: "15 Days",
//                       onTap: () {
//                         setState(() {
//                           _selectedDate = formatDate(addDays(15));
//                         });
//                         Provider.of<SessionProvider>(context, listen: false)
//                             .setFollowUpDate(_selectedDate);
//                         Navigator.pop(context);
//                         print('15 Days Later: ${formatDate(addDays(15))}');
//                       }),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   selectDay(
//                       title: "1 Month",
//                       onTap: () {
//                         setState(() {
//                           _selectedDate = formatDate(addMonths(1));
//                         });
//                         Provider.of<SessionProvider>(context, listen: false)
//                             .setFollowUpDate(_selectedDate);
//
//                         Navigator.pop(context);
//                         print('1 Month Later: $_selectedDate');
//                       }),
//                   selectDay(
//                       title: "1.5 Month",
//                       onTap: () {
//                         setState(() {
//                           _selectedDate = formatDate(addDays(46));
//                         });
//                         Provider.of<SessionProvider>(context, listen: false)
//                             .setFollowUpDate(_selectedDate);
//
//                         Navigator.pop(context);
//                         print('1.5 Months Later: $_selectedDate');
//                       }),
//                   selectDay(
//                       title: "2 Month",
//                       onTap: () {
//                         setState(() {
//                           _selectedDate = formatDate(addMonths(2));
//                         });
//                         Provider.of<SessionProvider>(context, listen: false)
//                             .setFollowUpDate(_selectedDate);
//
//                         Navigator.pop(context);
//                         print('2 Month Later: $_selectedDate');
//                       }),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   selectDay(
//                       title: "3 Month",
//                       onTap: () {
//                         setState(() {
//                           _selectedDate = formatDate(addMonths(3));
//                         });
//                         Provider.of<SessionProvider>(context, listen: false)
//                             .setFollowUpDate(_selectedDate);
//
//                         Navigator.pop(context);
//                         print('3 Month Later: $_selectedDate');
//                       }),
//                   selectDay(
//                       title: "6 Month",
//                       onTap: () {
//                         setState(() {
//                           _selectedDate = formatDate(addMonths(6));
//                         });
//                         Provider.of<SessionProvider>(context, listen: false)
//                             .setFollowUpDate(_selectedDate);
//
//                         Navigator.pop(context);
//                         print('6 Month Later: $_selectedDate');
//                       }),
//                   selectDay(
//                       title: "1 Year",
//                       onTap: () {
//                         setState(() {
//                           _selectedDate = formatDate(addYears(1));
//                         });
//                         Provider.of<SessionProvider>(context, listen: false)
//                             .setFollowUpDate(_selectedDate);
//
//                         Navigator.pop(context);
//                         print('1 Year Later: $_selectedDate');
//                       }),
//                 ],
//               ),
//               TableCalendar(
//                 daysOfWeekVisible: false,
//                 headerStyle: HeaderStyle(
//                     titleCentered: true, formatButtonVisible: false),
//                 focusedDay: DateTime.now(),
//                 firstDay: DateTime(2000),
//                 lastDay: DateTime(2101),
//                 onDaySelected: (selectedDay, focusedDay) {
//                   setState(() {
//                     _selectedDate = formatDate(selectedDay);
//                   });
//                   Provider.of<SessionProvider>(context, listen: false)
//                       .setFollowUpDate(_selectedDate);
//
//                   Navigator.pop(context);
//                   print('Specific: $_selectedDate');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget selectDay({required String title, required Function() onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 2.0),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
//           decoration: BoxDecoration(
//               color: AppColors.whiteColor,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(8),
//               )),
//           child: Text(
//             title,
//             style: Theme.of(context).textTheme.bodySmall!,
//           ),
//         ),
//       ),
//     );
//   }
// }
