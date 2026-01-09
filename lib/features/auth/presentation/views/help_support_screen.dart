import 'package:flutter/material.dart';

class HelpSupportDoctorScreen extends StatelessWidget {
  const HelpSupportDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: Colors.black,
        leading: const BackButton(),
      ),
      backgroundColor: Colors.grey.shade100,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🔍 Search bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search support topics...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 📚 Help Categories
          const Text(
            "Common Topics",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _supportTile(
            icon: Icons.calendar_today,
            title: 'Appointment Issues',
            subtitle: 'Help with scheduling, rescheduling, or canceling',
          ),
          _supportTile(
            icon: Icons.account_circle,
            title: 'Profile & Credentials',
            subtitle: 'Update your profile, license or availability',
          ),
          _supportTile(
            icon: Icons.attach_money,
            title: 'Payment & Billing',
            subtitle: 'Consultation fees, payouts, and invoices',
          ),
          _supportTile(
            icon: Icons.bug_report,
            title: 'Technical Support',
            subtitle: 'App issues, errors, bugs or login problems',
          ),
          _supportTile(
            icon: Icons.contact_mail,
            title: 'Contact Admin',
            subtitle: 'Reach out to platform administrators',
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _supportTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0.5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // TODO: Navigate to detailed help page
        },
      ),
    );
  }
}
