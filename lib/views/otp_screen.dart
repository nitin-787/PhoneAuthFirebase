import 'dart:async';

import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;
  bool _isResending = false;
  int _remainingTime = 30;

  void startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff171926),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter OTP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "We've sent an OTP to your mobile number",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff5B5B5B),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  OtpField(
                    controller: _otpController,
                  ),
                  OtpField(
                    controller: _otpController,
                  ),
                  OtpField(
                    controller: _otpController,
                  ),
                  OtpField(
                    controller: _otpController,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  setState(() {
                    _isResending = true;
                  });
                  // Resend the OTP
                  bool success = await Future.delayed(
                    const Duration(seconds: 2),
                    () => true,
                  );
                  if (success) {
                    setState(() {
                      _remainingTime = 30;
                      _isResending = false;
                    });
                    startCountdown();
                  } else {
                    setState(() {
                      _isResending = false;
                    });
                    // Show an error message
                  }
                },
                highlightColor: Colors.blue,
                splashColor: Colors.blue[200],
                child: _isResending
                    ? const CircularProgressIndicator()
                    : Text(
                        'Resend OTP in $_remainingTime',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff5B5B5B),
                          fontSize: 18,
                        ),
                      ),
              ),
              const Spacer(),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_otpController.text.length != 4 ||
                              _otpController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a valid OTP'),
                              ),
                            );
                            return;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff7352EC),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
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

class OtpField extends StatelessWidget {
  final TextEditingController controller;
  final Color borderColor;
  final BorderRadius borderRadius;
  final double borderWidth;
  final bool enabled;

  const OtpField({
    Key? key,
    required this.controller,
    this.borderColor = const Color(0xff7352EC),
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.borderWidth = 1.0,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> fields = List.generate(
      1,
      (index) => SizedBox(
        width: 55,
        child: TextFormField(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          maxLength: 1,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
                width: borderWidth,
              ),
              borderRadius: borderRadius,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
                width: borderWidth,
              ),
              borderRadius: borderRadius,
            ),
          ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          enabled: enabled,
        ),
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: fields,
      ),
    );
  }
}
