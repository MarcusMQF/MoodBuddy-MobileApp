import 'package:flutter/material.dart';

class ConnectDicesPage extends StatefulWidget {
  const ConnectDicesPage({super.key});

  @override
  State<ConnectDicesPage> createState() => _ConnectDicesPageState();
}

class _ConnectDicesPageState extends State<ConnectDicesPage> {
  bool _isConnected = false; // Track the connection status

  void _toggleConnection() {
    setState(() {
      _isConnected = !_isConnected; // Toggle the connection status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/connectbg.png'), // Path to your background image
                fit: BoxFit.cover, // Fit the image to the full screen
              ),
            ),
          ),
          // White Back Arrow at the Top Left
          Positioned(
            top: 47, // Adjust the top position as needed
            left: 4, // Adjust the left position as needed
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white, // White back arrow
                size: 24, // Adjust the size of the arrow
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Go back to the previous screen
              },
            ),
          ),
          // Big Circle Connect Button at the Top
          Positioned(
            top: 100, // Adjust the top position as needed
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _toggleConnection, // Call the toggle function on tap
                child: Container(
                  width: 150, // Adjust the size of the circle
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isConnected ? null : Colors.white.withOpacity(0.8), // Change color based on connection status
                    gradient: _isConnected
                        ? const LinearGradient(
                            colors: [Colors.green, Colors.lightGreen], // Gradient green
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    border: Border.all(
                      color: _isConnected ? Colors.green : Colors.blue, // Change border color based on connection status
                      width: 4, // Border width
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/power.png', // Path to your power icon image
                      width: 80, // Adjust the size of the image
                      height: 80,
                      color: _isConnected ? Colors.white : null, // Change image color when connected
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Fixed Bottom Dialog
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 380, // Adjust the height of the bottom dialog
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9), // Semi-transparent white background
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Centered Title
                    Center(
                      child: Text(
                        'How to Connect Story Dices to the MoodBuddy App',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 14), // Spacing after the title
                    // Instructions
                    Text(
                      '1. Power on the Story Dice by pressing the small button on the side of each die. The dice will enter pairing mode, indicated by a flashing LED.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 136, 136, 136),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '2. Open the MoodBuddy app and navigate to the Settings section.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 136, 136, 136),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '3. Tap the "Connect Dice" option.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 136, 136, 136),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '4. The app will automatically scan for nearby Story Dice devices. Select the dice you want to connect from the list.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 136, 136, 136),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '5. If prompted, confirm the pairing by entering the 4-digit code displayed on the corresponding die.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 136, 136, 136),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '6. Once connected, the app will confirm the successful pairing. You can now start using the Story Dice with the Mood Diary app.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 136, 136, 136),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Connected Text Popup
          if (_isConnected) // Show only when connected
            Positioned(
              top: 300, // Adjust the position as needed
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.green, Colors.lightGreen], // Gradient green
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Connected',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}