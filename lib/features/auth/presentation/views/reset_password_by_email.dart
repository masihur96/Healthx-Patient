import 'package:flutter/material.dart';
import 'package:healthx_patient/shared/custom_text_form_field.dart';

class ResetPasswordByEmail extends StatefulWidget {
  final String? initialEmail;
  const ResetPasswordByEmail({super.key, this.initialEmail});

  @override
  State<ResetPasswordByEmail> createState() => _ResetPasswordByEmailState();
}

class _ResetPasswordByEmailState extends State<ResetPasswordByEmail> {
  // _resetPassword(
  //     AuthViewModel authVM, BuildContext context, String email) async {
  //   print("object");
  //
  //   final success = await authVM.createPasswordToken(
  //     email: email,
  //   );
  //
  //   print("Send Token Success:: $success");
  //
  //   if (success) {
  //     if (!mounted) return;
  //
  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (_) => CreateNewPasswordScreen()));
  //     AppSnackBar.show(
  //       context,
  //       message: "Temporary password sent to your email!",
  //     );
  //   } else {
  //     if (!mounted) return;
  //     if (mounted) {
  //       AppSnackBar.show(
  //         context,
  //         message: "Something went wrong, try again!",
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Example pre-filled email, replace with your logic if needed
    // final authVM = Provider.of<AuthViewModel>(context);
    final TextEditingController emailController =
        TextEditingController(text: widget.initialEmail ?? "");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Reset Password",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Enter your email, we will send a verification code to email",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Type your email",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: CustomTextFormField(
                textEditingController: emailController,
                labelText: "Type your Email",
                prefixIconData: Icons.email_outlined,
                validator: (String? value) {
                  if (value == null || value.trim() == "") {
                    return 'Enter Email Address';
                  }
                  return null;
                },
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // if (authVM.isLoading) return;
                  //
                  // _resetPassword(authVM, context, emailController.text.trim());

                  //
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (_) => CreateNewPasswordScreen()));
                  // TODO: Implement send link logic
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
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
