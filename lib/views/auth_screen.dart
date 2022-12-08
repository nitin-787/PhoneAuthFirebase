import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                'SKIP',
                style: TextStyle(
                  color: Color(0xff464c56),
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
              Text(
                'Enter your mobile number',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xff464c56),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCountry,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
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
                                Text(
                                  value,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      style: const TextStyle(
                        fontSize: 19, // Increase font size
                        color: Color(0xff464c56),
                      ),
                      decoration: InputDecoration(
                        prefix: Text(
                          countryCodes[countries.indexOf(selectedCountry)],
                          style: const TextStyle(
                            fontSize: 19,
                            color: Color(0xff464c56),
                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
