import 'package:flutter/material.dart';
import 'package:healthx_patient/shared/custom_text_form_field.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _token = "";
  String _password = "";
  bool _obscurePassword = true;
  String _passwordInput = '';
  bool _hasMinLength = false;
  bool _hasNumber = false;
  bool _hasLetter = false;

  // _createPassword(AuthViewModel authVM, BuildContext context) async {
  //   print("object");
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //
  //     final success = await authVM.setPasswordWithToken(
  //       token: _token,
  //       newPassword: _password,
  //     );
  //
  //     print("Send Token Success:: $success");
  //
  //     if (success) {
  //       if (!mounted) return;
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (_) => VerificationSuccessfulScreen(
  //                     title: 'Password Changed',
  //                     subTitle:
  //                         "Password changed successfully, you can login again with a new password",
  //                   )));
  //       // Process data.
  //
  //       AppSnackBar.show(
  //         context,
  //         message: "Temporary password sent to your email!",
  //       );
  //     } else {
  //       if (!mounted) return;
  //       if (mounted) {
  //         AppSnackBar.show(
  //           context,
  //           message: "Something went wrong, try again!",
  //         );
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //   final authVM = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'New Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Create a new password that is safe and easy to remember',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: "Token",
                    prefixIconData: Icons.token_outlined,
                    validator: (String? value) {
                      if (value == null || value.trim() == "") {
                        return 'Enter your token';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _token = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    labelText: "Type your password",
                    prefixIconData: Icons.lock_outline,
                    suffixIconData: _obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    isObscure: !_obscurePassword,
                    suffixOnTap: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    onSaved: (String? value) {
                      _password = value!;
                    },
                    onChanged: (value) => _checkPasswordStrength(value),
                    validator: (String? value) {
                      if (value == null || value.trim() == "") {
                        return 'Enter Password';
                      }

                      return null;
                    },
                  ),
                  if (_passwordInput.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPasswordRule(
                            "Minimum 8 characters", _hasMinLength),
                        _buildPasswordRule(
                            "At least 1 number (0-9)", _hasNumber),
                        _buildPasswordRule(
                            "At least lowercase or uppercase letters",
                            _hasLetter),
                      ],
                    ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // if (authVM.isLoading) return;
                  //
                  // _createPassword(authVM, context);

                  // Handle confirm password logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2979FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Confirm New Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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

  Widget _buildPasswordRule(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
          size: 18,
        ),
        SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            color: isValid ? Colors.green : Colors.red,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  void _checkPasswordStrength(String password) {
    setState(() {
      _passwordInput = password;
      _hasMinLength = password.length >= 8;
      _hasNumber = RegExp(r'[0-9]').hasMatch(password);
      _hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password);
    });
  }
}
