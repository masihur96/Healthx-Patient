import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:healthx_patient/configs/custom_size.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import 'package:healthx_patient/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:healthx_patient/features/auth/presentation/views/login_screen.dart';
import 'package:healthx_patient/shared/app_snackbar.dart';
import 'package:healthx_patient/shared/custom_text_form_field.dart';
import 'package:healthx_patient/shared/medi_care_pro_button.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with WidgetsBindingObserver {
  // final GoogleAuthService _googleAuthService = GoogleAuthService();
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _phone = "";
  String _email = "";
  String _bmdc = "";
  String _password = "";
  String _confirmPassword = "";
  bool _isSecure = false;
  bool _confirmIsSecure = false;
  bool _agreedToTerms = false; // Add this for the checkbox
  bool _isLoading = false;
  bool _isKeyboardVisible = false;
  // Password hint state
  String _passwordInput = '';
  bool _hasMinLength = false;
  bool _hasNumber = false;
  bool _hasLetter = false;
  String? _sex;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void _checkPasswordStrength(String password) {
    setState(() {
      _passwordInput = password;
      _hasMinLength = password.length >= 8;
      _hasNumber = RegExp(r'[0-9]').hasMatch(password);
      _hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password);
    });
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

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final newValue = bottomInset > 0.0;
    if (newValue != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);
    // final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Back arrow
                SizedBox(height: 10),
                // Title and subtitle
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Create account and enjoy all services",
                    style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                  ),
                ),
                SizedBox(height: 20),
                // Google Sign In Button
                // SizedBox(
                //     width: double.infinity,
                //     child: OutlinedButton(
                //       style: OutlinedButton.styleFrom(
                //         padding: const EdgeInsets.symmetric(vertical: 12),
                //         side: BorderSide(color: Colors.grey[300]!),
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(8)),
                //       ),
                //       onPressed: () async {
                //         // await _googleAuthService.loginWithGoogle();
                //       },
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Image.asset(
                //             'assets/images/google_icon.png', // Add a Google logo to your assets
                //             height: 24,
                //             width: 24,
                //           ),
                //           const SizedBox(width: 12),
                //           Text(
                //             "Sign in with Google",
                //             style: TextStyle(
                //               fontWeight: FontWeight.w600,
                //               color: Colors.black87,
                //               fontSize: 16,
                //             ),
                //           ),
                //         ],
                //       ),
                //     )),
                // SizedBox(height: 16),
                // OR Divider
                // Row(
                //   children: [
                //     Expanded(child: Divider()),
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //       child: Text("OR", style: TextStyle(color: Colors.grey)),
                //     ),
                //     Expanded(child: Divider()),
                //   ],
                // ),

                // Form fields
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Username
                      CustomTextFormField(
                        labelText: "Enter Your Name",
                        onSaved: (String? value) {
                          _name = value!;
                        },
                        prefixIconData: Icons.person_outline,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'This Field is Required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenSize(context, .05)),
                      // Email
                      CustomTextFormField(
                        labelText: "Email",
                        onSaved: (String? value) {
                          _email = value!;
                        },
                        prefixIconData: Icons.email_outlined,
                        validator: (String? value) {
                          if (value == null || value.trim() == "") {
                            return 'Enter Email Address';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Invalid Email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenSize(context, .05)),
                      // Phone
                      CustomTextFormField(
                        labelText: "Enter Phone Number",
                        onSaved: (String? value) {
                          _phone = value!;
                        },
                        prefixIconData: Icons.lock_outline,
                        keyboardType: TextInputType.phone,
                        validator: (String? value) {
                          bool mobileValid =
                              RegExp(r'^(?:\+?88|0088)?01[13-9]\d{8}$')
                                  .hasMatch(value!);
                          if (value == null || value.trim() == "") {
                            return 'Phone is Required';
                          }
                          if (!mobileValid) {
                            return 'Incorrect Mobile Number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenSize(context, .05)),
                      // BMDC

                      CustomDropdownField(
                        labelText: "Sex",
                        prefixIconData: Icons.person_outline,
                        items: const ["Male", "Female", "Other"],
                        value: _sex,
                        onChanged: (value) {
                          setState(() {
                            _sex = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenSize(context, .05)),
                      // Password
                      CustomTextFormField(
                        labelText: "Password",
                        onSaved: (String? value) {
                          _password = value!;
                        },
                        onChanged: (value) => _checkPasswordStrength(value),
                        prefixIconData: Icons.lock_outline,
                        suffixIconData:
                            _isSecure ? Icons.visibility : Icons.visibility_off,
                        isObscure: _isSecure,
                        suffixOnTap: () {
                          setState(() {
                            _isSecure = !_isSecure;
                          });
                        },
                        validator: (String? value) {
                          if (!RegExp(
                                  r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&#]{6,}$')
                              .hasMatch(value!)) {
                            return 'At least 6 characters, letters & numbers.';
                          }
                          return null;
                        },
                      ),
                      // Password Hint
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

                      SizedBox(height: screenSize(context, .05)),
                      CustomTextFormField(
                        labelText: "Confirm Password",
                        onSaved: (String? value) {
                          _confirmPassword = value!;
                        },
                        prefixIconData: Icons.lock_outline,
                        suffixIconData: _confirmIsSecure
                            ? Icons.visibility
                            : Icons.visibility_off,
                        isObscure: _confirmIsSecure,
                        suffixOnTap: () {
                          setState(() {
                            _confirmIsSecure = !_confirmIsSecure;
                          });
                        },
                        validator: (String? value) {
                          if (!RegExp(
                                  r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&#]{6,}$')
                              .hasMatch(value!)) {
                            return 'At least 6 characters, letters & numbers.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenSize(context, .05)),
                      // Terms and Privacy Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: _agreedToTerms,
                            onChanged: (val) {
                              setState(() {
                                _agreedToTerms = val ?? false;
                              });
                            },
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: "I agree to the company ",
                                style: TextStyle(color: Colors.grey),
                                children: [
                                  TextSpan(
                                    text: "Term of Service",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // TODO: Open Terms of Service
                                      },
                                  ),
                                  TextSpan(
                                    text: " and ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // TODO: Open Privacy Policy
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize(context, .05)),
                      // Sign Up Button
                      MediCareProButton(
                        isLoading: _isLoading,
                        height: screenSize(context, .15),
                        width: screenSize(context, 1),
                        onTap: () {
                          if (authVM.isLoading) return;
                          if (_agreedToTerms) {
                            _register(authVM, context);
                          }
                        },
                        title: 'Sign Up',
                        bgColor: AppColors.yellow,
                      ),
                      SizedBox(height: screenSize(context, .05)),
                      // Sign In link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have an account? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen()),
                              );
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize(context, .05)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _register(AuthViewModel authVM, BuildContext context) async {
    print("object");
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      if (_password == _confirmPassword) {
        // final success = await authVM.register(
        //   email: _email,
        //   fullName: _name,
        //   phone: _phone,
        //   password: _password,
        //   bmdcNumber: _bmdc,
        // );
        //
        // print("Registration Success:: $success");
        //
        // if (success) {
        //   if (!mounted) return;
        //
        //   setState(() {
        //     _isLoading = false;
        //   });
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (_) => VerifyAccountScreen(
        //         email: _email,
        //       ),
        //     ),
        //   );
        //   AppSnackBar.show(
        //     context,
        //     message: "Successfully Registered.",
        //   );
        // } else {
        //   if (!mounted) return;
        //   setState(() {
        //     _isLoading = false;
        //   });
        //   if (mounted) {
        //     // Show the actual error from the ViewModel if available
        //     String errorMessage =
        //         authVM.error ?? "Email, BMDC Code or Phone is Already Exist";
        //     // Use longer duration for multi-line errors
        //     Duration duration = errorMessage.contains('\n')
        //         ? const Duration(seconds: 5)
        //         : const Duration(seconds: 3);
        //     AppSnackBar.show(
        //       context,
        //       message: errorMessage,
        //       duration: duration,
        //     );
        //   }
        // }
      } else {
        setState(() {
          _isLoading = false;
        });
        AppSnackBar.show(
          context,
          message: "Password doesn't match",
        );
      }
    }
  }
}

class CustomDropdownField extends StatelessWidget {
  final String labelText;
  final IconData prefixIconData;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const CustomDropdownField({
    super.key,
    required this.labelText,
    required this.prefixIconData,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIconData),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Change radius here
        ),
      ),
      validator: validator,
      onChanged: onChanged,
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
    );
  }
}
