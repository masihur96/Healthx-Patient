// import 'package:flutter/material.dart';
// import 'package:healthx_patient/configs/route_generator.dart';
// import 'package:healthx_patient/core/constants/app_colors.dart';
//
// class DoctorDetailScreen extends StatefulWidget {
//   final Map<String, dynamic> doctor;
//   const DoctorDetailScreen({super.key, required this.doctor});
//
//   @override
//   State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
// }
//
// class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
//   DateTime _selectedDate = DateTime.now();
//   String? _selectedTime;
//   String _consultType = 'Online';
//
//   List<String> get _timeSlots {
//     return const [
//       '09:00 AM', '09:30 AM', '10:00 AM', '10:30 AM', '11:00 AM',
//       '02:00 PM', '02:30 PM', '03:00 PM', '03:30 PM', '04:00 PM',
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final d = widget.doctor;
//     return Scaffold(
//       appBar: AppBar(title: Text(d['name'] ?? 'Doctor Detail')),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _ProfileHeader(d: d),
//             const SizedBox(height: 16),
//             _AboutSection(d: d),
//             const SizedBox(height: 16),
//             _AvailabilitySection(
//               selectedDate: _selectedDate,
//               onDateChanged: (date) => setState(() => _selectedDate = date),
//               timeSlots: _timeSlots,
//               selectedTime: _selectedTime,
//               onTimeSelected: (t) => setState(() => _selectedTime = t),
//             ),
//             const SizedBox(height: 16),
//             _ConsultationType(
//               value: _consultType,
//               onChanged: (v) => setState(() => _consultType = v),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _selectedTime == null
//                     ? null
//                     : () {
//                         Navigator.of(context).pushNamed(
//                           RouteGenerator.bookingConfirmationRoute,
//                           arguments: {
//                             'doctor': d,
//                             'date': _selectedDate,
//                             'time': _selectedTime,
//                             'type': _consultType,
//                           },
//                         );
//                       },
//                 child: const Text('Book Appointment'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _ProfileHeader extends StatelessWidget {
//   final Map<String, dynamic> d;
//   const _ProfileHeader({required this.d});
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: AppColors.white,
//       borderRadius: BorderRadius.circular(16),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 36,
//               backgroundColor: Colors.grey.shade300,
//               child: const Icon(Icons.person, color: Colors.white, size: 36),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(d['name'] ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                   const SizedBox(height: 4),
//                   Text(d['specialty'] ?? ''),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       const Icon(Icons.local_hospital, size: 16),
//                       const SizedBox(width: 6),
//                       Expanded(child: Text(d['hospital'] ?? '')),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   Row(
//                     children: [
//                       const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
//                       const SizedBox(width: 4),
//                       Text('${d['rating'] ?? 0} (${d['reviews'] ?? 0} reviews)'),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _AboutSection extends StatelessWidget {
//   final Map<String, dynamic> d;
//   const _AboutSection({required this.d});
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: AppColors.white,
//       borderRadius: BorderRadius.circular(16),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('About', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//             const SizedBox(height: 8),
//             Text('Experience: ${d['experience'] ?? ''}'),
//             const SizedBox(height: 6),
//             const Text('Education: MBBS, FCPS (Sample)'),
//             const SizedBox(height: 6),
//             const Text('Languages: English, Bangla'),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _AvailabilitySection extends StatelessWidget {
//   final DateTime selectedDate;
//   final ValueChanged<DateTime> onDateChanged;
//   final List<String> timeSlots;
//   final String? selectedTime;
//   final ValueChanged<String> onTimeSelected;
//
//   const _AvailabilitySection({
//     required this.selectedDate,
//     required this.onDateChanged,
//     required this.timeSlots,
//     required this.selectedTime,
//     required this.onTimeSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final days = List.generate(7, (i) => DateTime.now().add(Duration(days: i)));
//     return Material(
//       color: AppColors.white,
//       borderRadius: BorderRadius.circular(16),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('Availability', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//             const SizedBox(height: 12),
//             SizedBox(
//               height: 56,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: days.length,
//                 separatorBuilder: (_, __) => const SizedBox(width: 8),
//                 itemBuilder: (context, i) {
//                   final dt = days[i];
//                   final selected = dt.day == selectedDate.day && dt.month == selectedDate.month && dt.year == selectedDate.year;
//                   return ChoiceChip(
//                     label: Text('${dt.day}/${dt.month}'),
//                     selected: selected,
//                     onSelected: (_) => onDateChanged(dt),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 12),
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: timeSlots.map((t) {
//                 final selected = t == selectedTime;
//                 return ChoiceChip(
//                   label: Text(t),
//                   selected: selected,
//                   onSelected: (_) => onTimeSelected(t),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _ConsultationType extends StatelessWidget {
//   final String value;
//   final ValueChanged<String> onChanged;
//   const _ConsultationType({required this.value, required this.onChanged});
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: AppColors.white,
//       borderRadius: BorderRadius.circular(16),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: RadioListTile<String>(
//                 value: 'Online',
//                 groupValue: value,
//                 onChanged: (v) => onChanged(v ?? 'Online'),
//                 title: const Text('Online Video Call'),
//               ),
//             ),
//             Expanded(
//               child: RadioListTile<String>(
//                 value: 'In-person',
//                 groupValue: value,
//                 onChanged: (v) => onChanged(v ?? 'In-person'),
//                 title: const Text('In-Person Visit'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
