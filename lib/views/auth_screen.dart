import 'package:flutter/material.dart';

// Define a list of country names and flags
final List<String> countries = [
  'India',
  'USA',
  'China',
  'Russia',
  'Japan',
];
final List<String> flags = [
  '🇮🇳',
  '🇺🇸',
  '🇨🇳',
  '🇷🇺',
  '🇯🇵',
];

final List<String> countryCodes = [
  '+91',
  '+1',
  '+86',
  '+7',
  '+81',
];

// Define the initial selected country and flag
String selectedCountry = 'India';
String selectedFlag = '🇮🇳';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff171926),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff171926),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff464c56),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xff464c56),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your mobile number',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xff242430),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCountry,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xff464c56),
                        ),
                        iconSize: 24,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCountry = newValue!;
                            selectedFlag = flags[countries.indexOf(newValue)];
                          });
                        },
                        items: countries
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                Text(
                                  flags[countries.indexOf(value)],
                                  style: const TextStyle(
                                    fontSize: 19,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  // add a
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      style: const TextStyle(
                        fontSize: 21,
                        color: Color(0xff464c56),
                      ),
                      decoration: InputDecoration(
                        prefix: Text(
                          countryCodes[countries.indexOf(selectedCountry)],
                        ),
                        prefixStyle: const TextStyle(
                          fontSize: 21,
                          color: Color(0xff464c56),
                        ),
                        counterText: '',
                        hintText: 'Mobile Number',
                        hintStyle: const TextStyle(
                          color: Color(0xff464c56),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff464c56),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff464c56),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                'By creating an account, you agree to our Terms of Service and Privacy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    // add gilroy font
                    style: TextStyle(
                      fontSize: 18,
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
