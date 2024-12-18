import 'package:flutter/material.dart';
import 'signup_page.dart'; // Import the RegisterPage

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final List<Map<String, String>> _pages = [
    {
      'title': 'Track Your Emotions',
      'description': 'MoodBuddy is here to help you understand and record your feelings.',
    },
    {
      'title': 'Find Your Calm',
      'description': 'When you\'re feeling overwhelmed, MoodBuddy can suggest soothing activities and music to help you relax.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            height: double.infinity, // Fit the entire screen
            width: double.infinity, // Fit the entire screen
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // White Rectangular Shape with Curved Corners
          Positioned(
            top: MediaQuery.of(context).size.height * 0.65, // Position at the bottom of the background image
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 248, 239),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), // Adjust the radius as needed
                  topRight: Radius.circular(50), // Adjust the radius as needed
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 150, // Adjust the height as needed
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      itemCount: _pages.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _pages[index]['title']!,
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'WelcomeMandala',
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _pages[index]['description']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 87, 87, 87),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: _currentPage == index ? 20 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: _currentPage == index ? const Color.fromARGB(255, 255, 91, 91) : const Color.fromARGB(255, 184, 181, 179),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 30), // Add vertical spacing
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the RegisterPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 41, 28, 9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'Get Started',
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
        ],
      ),
    );
  }
}