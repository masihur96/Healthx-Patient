import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: Colors.black,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_outlined)),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Terms & Conditions for MedicarePro',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              Text(
                '1. Acceptance of Terms',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'By registering as a doctor on MedicarePro, you agree to abide by the following terms and conditions.',
              ),

              SizedBox(height: 16),
              Text(
                '2. Professional Responsibility',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'You confirm that you are licensed and authorized to provide medical consultations and services to patients.',
              ),

              SizedBox(height: 16),
              Text(
                '3. Use of Platform',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'You will use the MedicarePro app ethically and only for professional, lawful medical interactions. Misuse may result in suspension.',
              ),

              SizedBox(height: 16),
              Text(
                '4. Appointment Conduct',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'You must attend scheduled appointments on time and provide proper documentation where required.',
              ),

              SizedBox(height: 16),
              Text(
                '5. Data Privacy & Confidentiality',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'You agree to maintain the confidentiality of patient information and comply with all applicable health data laws.',
              ),

              SizedBox(height: 16),
              Text(
                '6. Payment & Fees',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'MedicarePro will process payments on a regular cycle. Any discrepancies must be reported within 7 days.',
              ),

              SizedBox(height: 16),
              Text(
                '7. Termination',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Your access to the platform can be revoked at any time due to violations of these terms or applicable laws.',
              ),

              SizedBox(height: 16),
              Text(
                '8. Changes to Terms',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'These terms may be updated occasionally. Continued use implies acceptance of the latest terms.',
              ),

              SizedBox(height: 24),
              Center(
                child: Text(
                  'Last updated: July 22, 2025',
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
