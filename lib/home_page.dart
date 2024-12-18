import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:moodbuddy_app/flappy_bird.dart';
import 'package:moodbuddy_app/stats_page.dart';
import 'story_dice_page.dart';
import 'profile_page.dart';
import 'package:provider/provider.dart'; 
import 'package:moodbuddy_app/util/user_provider.dart'; 
import 'package:flame/game.dart'; 
import 'package:lottie/lottie.dart'; 
import 'mood_tracker_page.dart'; 
import 'connect_dices_page.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = <Widget>[
    const HomeContent(), // Replace with your actual home content widget
    const StoryDicePage(),
    const ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 239), 
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GNav(
            backgroundColor: Colors.transparent,
            color: Colors.black,
            activeColor: Colors.white,
            tabBackgroundColor: const Color.fromARGB(255, 41, 28, 9),
            padding: const EdgeInsets.all(16),
            selectedIndex: _currentIndex,
            onTabChange: _onTabTapped,
            gap: 8,
            tabs: const [
              GButton(icon: Icons.home_rounded, text: 'Home'),
              GButton(icon: Icons.star_rounded, text: 'Story Dice'),
              GButton(icon: Icons.person_rounded, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int _currentPage = 0; // Track the current page index for the cards

  // List of custom titles for each music card
  final List<String> musicCardTitles = [
    'Relaxing Beats',
    'Energetic Vibes',
    'Calm Melodies',
    'Happy Tunes',
    'Sad Melodies',
    'Angry Rhythms',
  ];

  // List of background image paths for each music card
  final List<String> musicCardBackgrounds = [
    'assets/music1.png',
    'assets/music2.png',
    'assets/music3.png',
    'assets/music4.png',
    'assets/music5.png',
    'assets/music6.png',
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final username = userProvider.usernameController.text;
    final selectedAvatarUrl = userProvider.selectedAvatarUrl; // Get the selected avatar URL

    // List of cards to display in the horizontal list view
    final List<Map<String, String>> cardItems = [
      {'title': 'Your Journey', 'description': 'Check your journey and progress.'},
      {'title': 'Mood Tracker', 'description': 'Track your mood effortlessly.'},
      {'title': 'Flappy Bird', 'description': 'Play the Flappy Bird game.'},
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 242), // Set background color
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello ,',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        username, // Dynamically display the username
                        style: const TextStyle(
                          fontSize: 30.0,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 14, 131, 226),
                          fontFamily: 'WelcomeMandala', // Custom font family
                        ),
                      ),
                      const Text(
                        'How was your day?', // Keep the "How was your day?" text
                        style: TextStyle(
                          fontSize: 15.0,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Display the selected avatar on the right side
                  SizedBox(
                    width: 100, // Adjust the size of the avatar
                    height: 100,
                    child: Lottie.network(
                      selectedAvatarUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15), // Add spacing below the username

            // Rounded Container Above the Cards ListView
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0), // Same padding as the cards ListView
              child: Container(
                height: 80, // Adjust the height as needed
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromARGB(255, 75, 56, 48),
                      Color.fromARGB(255, 124, 87, 66),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Left Side: Image
                    Padding(
                      padding: const EdgeInsets.all(12.0), // Padding for the image
                      child: Image.asset(
                        'assets/toys.png', // Path to the image
                        width: 50, // Adjust the width of the image
                        height: 50, // Adjust the height of the image
                        fit: BoxFit.cover, // Fit the image to the container
                      ),
                    ),
                    // Center: Text
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0), // Padding for the text
                        child: Text(
                          'Connect the Story Dices with the App',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Right Side: Circular Button with Go To Icon
                    Padding(
                      padding: const EdgeInsets.all(20.0), // Padding for the button
                      child: CircleAvatar(
                        radius: 20, // Adjust the size of the circle
                        backgroundColor: Colors.white, // Background color of the circle
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_rounded, // Go to icon
                            color: Color.fromARGB(255, 75, 56, 48), // Icon color
                          ),
                          onPressed: () {
                            // Add functionality for the button
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ConnectDicesPage(), // Replace with your page
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25), // Add spacing below the rounded container

            SizedBox(
              height: 250, // Increase the height of the horizontal list view for cards
              child: PageView.builder(
                itemCount: cardItems.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index; // Update the current page index
                  });
                },
                itemBuilder: (context, index) {
                  final card = cardItems[index];

                  // Check if it's the first card (index 0)
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0), // Align with screen edges
                      child: Container(
                        width: 250, // Increase the width of each card
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255), // Card background color
                          borderRadius: BorderRadius.circular(15), // Rounded corners
                        ),
                        child: Stack(
                          children: [
                            // Background Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15), // Clip the image to the rounded corners
                              child: Image.asset(
                                'assets/space.png', // Path to the image
                                fit: BoxFit.cover, // Fit the image to the container
                                width: double.infinity, // Ensure the image takes the full width
                                height: double.infinity, // Ensure the image takes the full height
                              ),
                            ),
                            // Overlay content (title, description, button, and Lottie animation)
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    card['title']!,
                                    style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'WelcomeMandala',
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    card['description']!,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontFamily: 'WelcomeMandala',
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Check Your Journey Button
                                      ElevatedButton(
                                        onPressed: () {
                                          // Add functionality for the button
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const StatsPage(), // Replace with your page
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(255, 41, 28, 9),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        child: const Text(
                                          'Check Your Journey',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                            fontFamily: 'WelcomeMandala',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      // Lottie Animation (Smaller and beside the button)
                                      Lottie.network(
                                        'https://lottie.host/6453337b-94b0-4af4-95db-7daf3ffa02bb/K1TPaS8tbf.json',
                                        width: 80, // Adjust the width of the Lottie animation
                                        height: 80, // Adjust the height of the Lottie animation
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // Check if it's the second card (index 1)
                  if (index == 1) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0), // Align with screen edges
                      child: Container(
                        width: 250, // Increase the width of each card
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 231, 231), // Card background color
                          borderRadius: BorderRadius.circular(15), // Rounded corners
                        ),
                        child: Stack(
                          children: [
                            // Background Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15), // Clip the image to the rounded corners
                              child: Image.asset(
                                'assets/moodtracker.png', // Path to the background image
                                fit: BoxFit.cover, // Fit the image to the container
                                width: double.infinity, // Ensure the image takes the full width
                                height: double.infinity, // Ensure the image takes the full height
                              ),
                            ),
                            // Overlay content (title, description, button, and Lottie animation)
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    card['title']!,
                                    style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'WelcomeMandala',
                                      color: Color.fromARGB(255, 41, 28, 9),
                                    ),
                                  ),
                                  Text(
                                    card['description']!,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Color.fromARGB(255, 41, 28, 9),
                                      fontFamily: 'WelcomeMandala',
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          // Navigate to the MoodTrackerPage
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const MoodTrackerPage(),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(255, 41, 28, 9),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        child: const Text(
                                          'Try it Now',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                            fontFamily: 'WelcomeMandala',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      // Add Lottie animation beside the button
                                      Lottie.network(
                                        'https://lottie.host/a8af5af9-2619-4a2a-a8bf-997633a4a9be/a5FRGc66Wo.json',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // Check if it's the third card (index 2)
                  if (index == 2) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0), // Align with screen edges
                      child: Container(
                        width: 250, // Increase the width of each card
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255), // Card background color
                          borderRadius: BorderRadius.circular(15), // Rounded corners
                        ),
                        child: Stack(
                          children: [
                            // Background Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15), // Clip the image to the rounded corners
                              child: Image.asset(
                                'assets/fbgame.png', // Path to the image
                                fit: BoxFit.cover, // Fit the image to the container
                                width: double.infinity, // Ensure the image takes the full width
                                height: double.infinity, // Ensure the image takes the full height
                              ),
                            ),
                            // Play Icon Overlay
                            Positioned(
                              bottom: 5, // Position the button at the bottom of the card
                              left: 0,
                              right: 0,
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigate to the FlappyBird game
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GameWidget(
                                          game: FlappyBird()..setGameContext(context), // Pass the BuildContext to FlappyBird
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),// Smaller button
                                  ),
                                  child: const Text(
                                    'Play',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'WelcomeMandala',
                                      color: Colors.green,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Container(); // Fallback in case of unexpected index
                },
              ),
            ),
            const SizedBox(height: 20), // Add spacing below the cards
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(cardItems.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? const Color.fromARGB(255, 14, 131, 226) // Selected color
                        : const Color.fromARGB(255, 41, 28, 9), // Unselected color
                  ),
                );
              }),
            ),
            const SizedBox(height: 25), // Add spacing below the dot indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0), // Align with "Hello, Your Name"
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Music Recommendations',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 41, 28, 9),
                    ),
                  ),
                  // Add "View All" text aligned to the right
                  GestureDetector(
                    onTap: () {
                      // Add functionality for "View All"
                      print('View All clicked');
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 151, 140, 125),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10), // Add spacing below the "Music Recommendations" text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0), // Apply consistent padding on both sides
              child: SizedBox(
                height: 110, // Set the height of the horizontal list view for cards
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: musicCardTitles.length, // Use musicCardTitles.length for the number of cards
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: index == 0 ? 0.0 : 5.0, // No margin for the first card
                        right: index == musicCardTitles.length - 1 ? 0.0 : 5.0, // No margin for the last card
                      ),
                      child: Container(
                        width: 250, // Increase the width of each card
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15), // Rounded corners
                        ),
                        child: Stack(
                          children: [
                            // Background Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15), // Clip the image to the rounded corners
                              child: Image.asset(
                                musicCardBackgrounds[index], // Use the specific background image for each card
                                fit: BoxFit.cover, // Fit the image to the container
                                width: double.infinity, // Ensure the image takes the full width
                                height: double.infinity, // Ensure the image takes the full height
                              ),
                            ),
                            // Overlay content (title and play button)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Custom Title for Each Card
                                  Text(
                                    musicCardTitles[index], // Use the custom title for each card
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'MintDayz',
                                      color: Colors.white,
                                    ),
                                  ),
                                  // Play Button
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.play_arrow_rounded,
                                        color: Color.fromARGB(255, 41, 28, 9),
                                      ),
                                      onPressed: () {
                                        // Add functionality for the play button
                                        print('Play ${musicCardTitles[index]} Music');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}