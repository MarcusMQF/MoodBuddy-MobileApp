import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for TextInputFormatter
import 'package:lottie/lottie.dart';
import 'package:moodbuddy_app/login_page.dart'; 

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 239), 
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  'MoodBuddy',
                  style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 41, 28, 9),
                    fontFamily: 'WelcomeMandala',
                    letterSpacing: 4,
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Lottie.network('https://lottie.host/86fda2c9-2afc-4964-b514-7820ca134146/VrPU3HbYHm.json'),
                ),
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Color.fromARGB(255, 110, 110, 110)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      fillColor: Color.fromARGB(255, 214, 213, 213),
                      filled: true, 
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: TextField(
                    obscureText: true, // Hide the input with dots
                    keyboardType: TextInputType.number, // Show numeric keyboard
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(4), // Limit input to 4 digits
                    ],
                    decoration: const InputDecoration(
                      hintText: '4-digit PIN',
                      hintStyle: TextStyle(color: Color.fromARGB(255, 110, 110, 110)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      fillColor: Color.fromARGB(255, 214, 213, 213),
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 41, 28, 9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'NexaHeavy',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}