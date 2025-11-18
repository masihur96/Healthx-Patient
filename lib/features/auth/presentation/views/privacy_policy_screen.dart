import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Policy'),
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: Colors.black,
        leading: const BackButton(),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Privacy Policy for MedicarePro',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              Text(
                '1. Introduction',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'This Privacy Policy explains how we collect, use, and protect your information when you use the MedicarePro platform as a doctor.',
              ),

              SizedBox(height: 16),
              Text(
                '2. Information We Collect',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '• Personal details (name, email, phone, specialization)\n'
                    '• Professional documents (license, certifications)\n'
                    '• App usage data and device information',
              ),

              SizedBox(height: 16),
              Text(
                '3. How We Use Your Information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We use your information to:\n'
                    '• Manage your profile and appointments\n'
                    '• Communicate with patients\n'
                    '• Improve app functionality\n'
                    '• Comply with regulations',
              ),

              SizedBox(height: 16),
              Text(
                '4. Data Security',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We use industry-standard measures to protect your data. However, no system is 100% secure.',
              ),

              SizedBox(height: 16),
              Text(
                '5. Sharing Your Information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We do not sell your personal data. Data may be shared with:\n'
                    '• Patients (limited info only)\n'
                    '• Legal authorities (if required)\n'
                    '• Service providers under NDA',
              ),

              SizedBox(height: 16),
              Text(
                '6. Your Rights',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'You can:\n'
                    '• Access or update your data\n'
                    '• Request deletion (within limits)\n'
                    '• Contact us for privacy-related concerns',
              ),

              SizedBox(height: 16),
              Text(
                '7. Contact Us',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'If you have questions, contact: support@medicarepro.app',
              ),

              SizedBox(height: 32),
              Center(
                child: Text(
                  'Updated: July 22, 2025',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
