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
  bool _isLoading = false;
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
              OtpField(
                controller: _otpController,
                numberOfFields: 4,
                errorText: 'Please enter a valid OTP',
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
                          fontSize: 17,
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
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
  final int numberOfFields;
  final Color borderColor;
  final BorderRadius borderRadius;
  final double borderWidth;
  final String errorText;
  final bool enabled;

  const OtpField({
    Key? key,
    required this.controller,
    required this.numberOfFields,
    this.borderColor = const Color(0xffB0B0B0),
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.borderWidth = 2.0,
    required this.errorText,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> fields = List.generate(
      numberOfFields,
      (index) => SizedBox(
        width: 45,
        child: TextFormField(
          maxLength: 4,
          controller: controller,
          validator: (value) {
            if (value?.length != numberOfFields) {
              return errorText;
            }
            return null;
          },
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

    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: fields,
      ),
    );
  }
}
