// import 'package:flutter/material.dart';
//
// class DoctorSettingsScreen extends StatefulWidget {
//   const DoctorSettingsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DoctorSettingsScreen> createState() => _DoctorSettingsScreenState();
// }
//
// class _DoctorSettingsScreenState extends State<DoctorSettingsScreen> {
//   bool notificationsEnabled = true;
//   bool darkModeEnabled = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//         backgroundColor: Colors.white,
//         elevation: 0.5,
//         foregroundColor: Colors.black,
//         leading: const BackButton(),
//       ),
//       backgroundColor: Colors.grey[100],
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           // Profile Section
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               children: [
//                 const CircleAvatar(
//                   radius: 30,
//                   backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/65.jpg'),
//                 ),
//                 const SizedBox(width: 16),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text('Dr. John Smith', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                     SizedBox(height: 4),
//                     Text('Cardiologist', style: TextStyle(color: Colors.grey)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),
//
//           // General Settings
//           const Text("General", style: TextStyle(fontWeight: FontWeight.bold)),
//           const SizedBox(height: 12),
//           _switchTile(
//             title: 'Notifications',
//             value: notificationsEnabled,
//             onChanged: (val) => setState(() => notificationsEnabled = val),
//           ),
//           _switchTile(
//             title: 'Dark Mode',
//             value: darkModeEnabled,
//             onChanged: (val) => setState(() => darkModeEnabled = val),
//           ),
//           _tile(
//             icon: Icons.language,
//             title: 'Language',
//             subtitle: 'English',
//             onTap: () {
//               // TODO: Change language
//             },
//           ),
//           const SizedBox(height: 24),
//
//           // Account Settings
//           const Text("Account", style: TextStyle(fontWeight: FontWeight.bold)),
//           const SizedBox(height: 12),
//           _tile(
//             icon: Icons.lock_outline,
//             title: 'Change Password',
//             onTap: () {
//               // TODO: Change password
//             },
//           ),
//           _tile(
//             icon: Icons.schedule,
//             title: 'Manage Availability',
//             onTap: () {
//               // TODO: Manage schedule
//             },
//           ),
//           _tile(
//             icon: Icons.logout,
//             title: 'Logout',
//             onTap: () {
//               // TODO: Logout action
//             },
//             color: Colors.red,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _tile({
//     required IconData icon,
//     required String title,
//     String? subtitle,
//     required VoidCallback onTap,
//     Color? color,
//   }) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: Icon(icon, color: color ?? Colors.blue),
//         title: Text(title, style: TextStyle(color: color ?? Colors.black)),
//         subtitle: subtitle != null ? Text(subtitle) : null,
//         trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//         onTap: onTap,
//       ),
//     );
//   }
//
//   Widget _switchTile({
//     required String title,
//     required bool value,
//     required ValueChanged<bool> onChanged,
//   }) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: SwitchListTile(
//         title: Text(title),
//         value: value,
//         onChanged: onChanged,
//         activeColor: Colors.blue,
//       ),
//     );
//   }
// }
