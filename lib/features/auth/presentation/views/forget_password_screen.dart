import 'package:flutter/material.dart';
import 'package:healthx_patient/features/auth/presentation/views/reset_password_by_email.dart';
import 'package:healthx_patient/shared/app_snackbar.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final String? initialEmail;
  const ForgetPasswordScreen({super.key, this.initialEmail});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_outlined)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Select verification method and we will\nsend verification code',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            _VerificationOption(
              icon: Icons.email_outlined,
              title: 'Email',
              subtitle: widget.initialEmail == null
                  ? "********@mail.com"
                  : widget.initialEmail!.isEmpty
                      ? "********@mail.com"
                      : widget.initialEmail!,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ResetPasswordByEmail(
                            initialEmail: widget.initialEmail)));
              },
            ),
            const SizedBox(height: 16),
            _VerificationOption(
              icon: Icons.phone_outlined,
              title: 'Phone Number',
              subtitle: '**** **** **** 2345',
              onTap: () {
                AppSnackBar.show(context,
                    message:
                        "We're working on this feature. It will be available in a future update.");
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (_) => ResetPasswordByPhone()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _VerificationOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _VerificationOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 28, color: Colors.black87),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
