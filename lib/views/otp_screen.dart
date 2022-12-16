import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff171926),
      body: Container(
        color: const Color(0xff171926),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter the OTP sent to your phone',
              style: TextStyle(
                color: Color(0xffB0B0B0),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            OtpField(
              controller: _otpController,
              numberOfFields: 4,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    child: const Text('Verify OTP'),
                    onPressed: () {
                      setState(
                        () {
                          _isLoading = true;
                        },
                      );
                      // Verify the OTP entered by the user
                      // If successful, navigate to the next screen
                      // If unsuccessful, show an error message
                      // and set _isLoading to false
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

class OtpField extends StatelessWidget {
  final TextEditingController controller;
  final int numberOfFields;

  const OtpField({
    super.key,
    required this.controller,
    required this.numberOfFields,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> fields = List.generate(
      numberOfFields,
      (index) => SizedBox(
        width: 40,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Color(0xffB0B0B0),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: fields,
      ),
    );
  }
}
