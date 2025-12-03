import 'package:flutter/material.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import 'package:healthx_patient/features/auth/data/models/auth_user.dart';
import 'package:healthx_patient/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:healthx_patient/features/auth/presentation/views/registration_screen.dart';
import 'package:healthx_patient/features/home_tab/drawer_screen.dart';
import 'package:healthx_patient/shared/app_snackbar.dart';
import 'package:healthx_patient/shared/custom_text_form_field.dart';
import 'package:healthx_patient/shared/medi_care_pro_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  bool isMedicalSelected = true;
  final _formKey = GlobalKey<FormState>();
  String _bMDC = "";
  String _password = "";
  bool _isKeyboardVisible = false;
  bool _isSecure = false;
  bool _isLoading = false;

  String _passwordInput = '';
  bool _hasMinLength = false;
  bool _hasNumber = false;
  bool _hasLetter = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    setState(() {
      _isKeyboardVisible = bottomInset > 0.0;
    });
  }

  _login(AuthViewModel authVM, BuildContext context) async {
    print("object");
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) => DrawerScreen(
                  authUser: AuthUser(),
                )), // Replace BottomNavScreen with your desired screen
        (Route<dynamic> route) => false,
      );
      setState(() {
        _isLoading = true;
      });

      final success = await authVM.login(
        email: _bMDC,
        password: _password,
      );

      print("Login Success:: $success");

      if (success) {
        if (!mounted) return;

        setState(() {
          _isLoading = false;
        });
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => DrawerScreen(
                    authUser: AuthUser(),
                  )), // Replace BottomNavScreen with your desired screen
          (Route<dynamic> route) => false,
        );
        AppSnackBar.show(
          context,
          message: "Successfully Logged in.",
        );
      } else {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          AppSnackBar.show(
            context,
            message: "Invalid Email or Password",
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true, // 👈 Important
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text(
                "Welcome Back!",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                "Sign In to your account",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
              ),
              // const SizedBox(height: 32),
              // _googleSignInButton(),
              // const SizedBox(height: 16),
              // _dividerWithOr(),
              const SizedBox(height: 16),
              _loginForm(),
              //  const SizedBox(height: 8),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: TextButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (_) => ForgetPasswordScreen(
              //                     initialEmail: _bMDC,
              //                   )));
              //       // showDialog(
              //       //   barrierDismissible: false,
              //       //   context: context,
              //       //   builder: (_) => BounchingDialog(
              //       //     width: screenSize(context, 0.6),
              //       //     height: screenSize(context, 1.1),
              //       //     child: ForgetPasswordDialog(),
              //       //   ),
              //       // );
              //     },
              //     child: Text(
              //       "Forgot Password?",
              //       style: TextStyle(
              //         color: Colors.blue[700],
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 8),
              MediCareProButton(
                height: 48,
                width: double.infinity,
                isLoading: _isLoading,

                // onTap: _handleLogin,
                onTap: () {
                  if (authVM.isLoading) return;

                  _login(authVM, context);
                },
                title: 'Sign In',
                bgColor: AppColors.yellow,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don’t have account? ",
                      style: TextStyle(color: Colors.grey[600])),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => RegistrationScreen()),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _googleSignInButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: BorderSide(color: Colors.grey[300]!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () async {
        // final googleAuthService = GoogleAuthService();
        //
        // // 👇 Start Google login flow
        // final user = await googleAuthService.loginWithGoogle();
        //
        // if (user != null) {
        //   // ✅ Success — Navigate to BottomNavScreen
        //   if (context.mounted) {
        //     Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(builder: (_) => BottomNavScreen()),
        //       (route) => false, // removes all previous routes
        //     );
        //   }
        //
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(
        //           "Welcome, Dr. ${user['firstname']} ${user['lastname']}!"),
        //     ),
        //   );
        // } else {
        //   // ❌ Failed login
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //         content: Text("Google Sign-In failed. Please try again.")),
        //   );
        // }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/google_icon.png', // Add a Google logo to your assets
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 12),
          Text(
            "Sign in with Google",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dividerWithOr() {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1, color: Colors.grey[300])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("OR", style: TextStyle(color: Colors.grey[600])),
        ),
        Expanded(child: Divider(thickness: 1, color: Colors.grey[300])),
      ],
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            labelText: "Type your Email or Phone Number",
            prefixIconData: Icons.email_outlined,
            onSaved: (String? value) {
              _bMDC = value!;
            },
            onChanged: (value) {
              setState(() {
                _bMDC = value;
              });
            },
            validator: (String? value) {
              if (value == null || value.trim() == "") {
                return 'Enter Email Address or Phone';
              }

              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            labelText: "Type your password",
            prefixIconData: Icons.lock_outline,
            suffixIconData: _isSecure ? Icons.visibility : Icons.visibility_off,
            isObscure: !_isSecure,
            suffixOnTap: () {
              setState(() {
                _isSecure = !_isSecure;
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
                _buildPasswordRule("Minimum 8 characters", _hasMinLength),
                _buildPasswordRule("At least 1 number (0-9)", _hasNumber),
                _buildPasswordRule(
                    "At least lowercase or uppercase letters", _hasLetter),
              ],
            ),
        ],
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
