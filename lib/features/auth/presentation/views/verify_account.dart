import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthx_patient/configs/custom_size.dart';

class VerifyAccountScreen extends StatefulWidget {
  final String email;
  const VerifyAccountScreen({super.key, required this.email});

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  List<String> _code = ['', '', '', '', '', ''];
  int _currentIndex = 0;
  int _timer = 48;
  Timer? _countdownTimer;

  late final TextEditingController _hiddenController;
  late final FocusNode _hiddenFocusNode;

  @override
  void initState() {
    super.initState();
    _hiddenController = TextEditingController();
    _hiddenFocusNode = FocusNode();
    _startTimer();

    // Autofocus keyboard on open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _hiddenFocusNode.requestFocus();
      }
    });
  }

  void _startTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return; // prevent calling setState after dispose
      if (_timer > 0) {
        setState(() => _timer--);
      } else {
        timer.cancel();
      }
    });
  }

  // Future<void> _verifyCode(AuthViewModel authVM, BuildContext context) async {
  //   if (_code.isEmpty) return;
  //
  //   final success =
  //       await authVM.verifyEmail(email: widget.email, code: _code.join(''));
  //
  //   if (!mounted) return;
  //
  //   if (success) {
  //     AppSnackBar.show(
  //       context,
  //       message: "Successfully Verified.",
  //     );
  //
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (_) => const VerificationSuccessfulScreen(
  //           title: 'Account Verified',
  //           subTitle:
  //               "Your account has been verified successfully, now let's enjoy Paypay features!",
  //         ),
  //       ),
  //     );
  //   } else {
  //     AppSnackBar.show(
  //       context,
  //       message: "Don't Match Code, Please Try Again.",
  //     );
  //   }
  // }
  //
  // Future<void> _resendCode(AuthViewModel authVM, BuildContext context) async {
  //   final success = await authVM.resendCode(email: widget.email);
  //
  //   if (!mounted) return;
  //
  //   if (success) {
  //     AppSnackBar.show(context, message: "Successfully sent new code.");
  //     setState(() {
  //       _timer = 48;
  //     });
  //     _countdownTimer?.cancel();
  //     _startTimer();
  //   } else {
  //     AppSnackBar.show(context, message: "Already verified account.");
  //   }
  // }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _hiddenController.dispose();
    _hiddenFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //   final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Verify Code",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Please enter the code we just sent to email",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                child: Text(
                  widget.email,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: screenSize(context, .2)),

              // Hidden TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _hiddenController,
                  focusNode: _hiddenFocusNode,
                  keyboardType: TextInputType.text,
                  maxLength: 6,
                  showCursor: false,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: const TextStyle(color: Colors.transparent),
                  cursorColor: Colors.transparent,
                  decoration: const InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  onChanged: (value) {
                    if (value.length <= 6 && mounted) {
                      setState(() {
                        for (int i = 0; i < 6; i++) {
                          _code[i] = i < value.length ? value[i] : '';
                        }
                        _currentIndex = value.length;
                      });
                    }
                  },
                ),
              ),

              // Code circles
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (i) {
                  final isSelected = _currentIndex == i;
                  return GestureDetector(
                    onTap: () => _hiddenFocusNode.requestFocus(),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: screenSize(context, .15),
                      height: screenSize(context, .15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              isSelected ? Colors.blue : Colors.grey.shade300,
                          width: 2,
                        ),
                        color: Colors.grey.shade100,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _code[i],
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              // Resend code
              Center(
                child: _timer > 0
                    ? Text.rich(
                        TextSpan(
                          text: "Resend code in ",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 16),
                          children: [
                            TextSpan(
                              text: "00:${_timer.toString().padLeft(2, '0')}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          // _resendCode(authVM, context);
                        },
                        child: const Text(
                          "Resend Code",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 24),

              // Continue button
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: screenSize(context, .1),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: _code.every((c) => c.isNotEmpty)
                        ? () {
                            // if (authVM.isLoading) return;
                            // _verifyCode(authVM, context);
                          }
                        : null,
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
