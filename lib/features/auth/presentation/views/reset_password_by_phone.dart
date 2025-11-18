import 'package:flutter/material.dart';

import 'create_new_password_screen.dart';

class ResetPasswordByPhone extends StatefulWidget {
  const ResetPasswordByPhone({super.key});

  @override
  State<ResetPasswordByPhone> createState() => _ResetPasswordByPhoneState();
}

class _ResetPasswordByPhoneState extends State<ResetPasswordByPhone> {
  final TextEditingController _phoneController =
      TextEditingController(text: "+6282332877994");
  bool _hasError = true; // Set to true to show error as in the screenshot

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              "Reset Password",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Enter your phone number, we will send a\nverification code to email",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF8A8A8A),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "Type your phone number",
              style: TextStyle(
                color: _hasError ? Colors.red : Color(0xFF8A8A8A),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                isDense: true,
                border: const UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: _hasError ? Colors.red : Colors.grey,
                    width: 1,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: _hasError ? Colors.red : Colors.blue,
                    width: 2,
                  ),
                ),
                errorText: _hasError ? '' : null,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            // Add more space to push the button to the bottom
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CreateNewPasswordScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2979FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  "Send Link",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
