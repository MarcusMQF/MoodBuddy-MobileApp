import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moodbuddy_app/util/text_box.dart';
import 'package:provider/provider.dart';
import 'package:moodbuddy_app/util/user_provider.dart';
import 'package:moodbuddy_app/signup_page.dart'; // Import the SignUpPage

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _bioController = TextEditingController(text: 'empty bio');

  // Loading state
  bool _isLoading = false;

  Future<void> editField(BuildContext context, String field, TextEditingController controller) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $field"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter new $field",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(controller.text);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ).then((newValue) {
      if (newValue != null) {
        // ignore: use_build_context_synchronously
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUsername(newValue);
      }
    });
  }

  // Function to handle logout and show loading animation
  void _handleLogout() {
    setState(() {
      _isLoading = true; // Show loading animation
    });

    // Wait for 3 seconds before navigating to SignUpPage
    Future.delayed(const Duration(seconds: 2), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignUpPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 242),
      body: Stack(
        children: [
          ListView(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Display the selected avatar from UserProvider
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: Lottie.network(userProvider.selectedAvatarUrl),
                  ),
                  Positioned(
                    bottom: 52,
                    right: 140,
                    child: GestureDetector(
                      onTap: () {
                        // Show the curved bottom sheet when the edit button is clicked
                        showModalBottomSheet(
                          backgroundColor: const Color.fromARGB(255, 255, 248, 239),
                          context: context,
                          isScrollControlled: false, // Remove this to make it half-screen
                          isDismissible: true, // Allows dismissing the sheet by tapping outside
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return AvatarSelectionBottomSheet();
                          },
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 41, 28, 9),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10, // Adjust this value to move the text further down
                    child: Text(
                      userProvider.usernameController.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 35,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'WelcomeMandala',
                        color: Color.fromARGB(255, 41, 28, 9),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.only(left: 22.0),
                child: Text(
                  'My Details',
                  style: TextStyle(color: Color.fromARGB(255, 71, 71, 71), fontWeight: FontWeight.bold),
                ),
              ),
              MyTextBox(
                text: userProvider.usernameController.text,
                sectionName: 'Username :',
                onPressed: () => editField(context, 'Username', userProvider.usernameController),
              ),
              MyTextBox(
                text: _bioController.text,
                sectionName: 'Bio :',
                onPressed: () => editField(context, 'Bio', _bioController),
              ),
              const SizedBox(height: 50), // Add some space between bio and logout button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0), // Adjust horizontal padding
                child: ElevatedButton(
                  onPressed: _handleLogout, // Call the logout function
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Red color for logout button
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Log out',
                    style: TextStyle(
                      fontFamily: 'NexaHeavy',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Loading animation overlay
          if (_isLoading)
            Center(
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color.fromARGB(255, 41, 28, 9),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Lottie.network(
                    'https://lottie.host/70ec7f5f-eaee-44f0-9188-5268b3d0fcdb/TdzkVAJsg9.json',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class AvatarSelectionBottomSheet extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _AvatarSelectionBottomSheetState createState() => _AvatarSelectionBottomSheetState();
}

class _AvatarSelectionBottomSheetState extends State<AvatarSelectionBottomSheet> {
  int _selectedAvatarIndex = -1;

  void _selectAvatar(int index) {
    setState(() {
      _selectedAvatarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Choose Your Avatar',
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 35,
              fontWeight: FontWeight.bold,
              fontFamily: 'WelcomeMandala',
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAvatarContainer(
                0,
                'https://lottie.host/53ab36c2-ea65-4159-ad05-51ecee62b79c/3TuoLD4q4d.json',
              ),
              _buildAvatarContainer(
                1,
                'https://lottie.host/92f0017b-9bc1-438b-bf2b-180b72458e2f/ZwhyabkNy4.json',
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAvatarContainer(
                2,
                'https://lottie.host/202802e0-792c-40ac-8365-264e4ffc5694/XvGLUFbfE8.json',
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              // Save the selected avatar URL to the UserProvider
              if (_selectedAvatarIndex != -1) {
                final selectedAvatarUrl = [
                  'https://lottie.host/53ab36c2-ea65-4159-ad05-51ecee62b79c/3TuoLD4q4d.json',
                  'https://lottie.host/92f0017b-9bc1-438b-bf2b-180b72458e2f/ZwhyabkNy4.json',
                  'https://lottie.host/202802e0-792c-40ac-8365-264e4ffc5694/XvGLUFbfE8.json',
                ][_selectedAvatarIndex];

                userProvider.updateSelectedAvatar(selectedAvatarUrl);
              }

              // Close the bottom sheet
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 41, 28, 9),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                fontFamily: 'NexaHeavy',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarContainer(int index, String lottieUrl) {
    return GestureDetector(
      onTap: () => _selectAvatar(index),
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _selectedAvatarIndex == index ? Colors.green : Colors.black,
            width: 4,
          ),
        ),
        child: Center(
          child: Lottie.network(
            lottieUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}