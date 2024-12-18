import 'package:flutter/material.dart';
import 'stats_page.dart'; // Import the StatsPage file

class MoodTrackerPage extends StatefulWidget {
  const MoodTrackerPage({super.key});

  @override
  State<MoodTrackerPage> createState() => _MoodTrackerPageState();
}

class _MoodTrackerPageState extends State<MoodTrackerPage>
    with SingleTickerProviderStateMixin {
  bool _isDailySelected = true; // Track whether "Daily" or "Week" is selected

  void _toggleButtonText() {
    setState(() {
      _isDailySelected = !_isDailySelected; // Toggle between "Daily" and "Week"
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 239),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: ElevatedButton(
              onPressed: _toggleButtonText,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 11, 90, 155),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: SizedBox(
                  key: ValueKey<bool>(_isDailySelected),
                  width: 80,
                  child: Center(
                    child: Text(
                      _isDailySelected ? 'Daily' : 'Week',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        letterSpacing: 1.5,
                        fontFamily: 'WelcomeMandala',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Mood Tracker',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'BrightAlmond',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'Start your journey towards self-awareness\nby tracking your mood effortlessly.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            _buildMoodImages(),
            const SizedBox(height: 32),
            _buildGradientButton(context), // Pass the context to the button
          ],
        ),
      ),
    );
  }

  Widget _buildMoodImages() {
    List<Map<String, String>> moodData = [
      {'image': 'assets/fear.png', 'text': 'Fear'},
      {'image': 'assets/sadness.png', 'text': 'Sadness'},
      {'image': 'assets/disgust.png', 'text': 'Disgust'},
      {'image': 'assets/anger.png', 'text': 'Anger'},
      {'image': 'assets/happiness.png', 'text': 'Happiness'},
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: moodData.sublist(0, 2).map((data) {
            return _buildMoodImageWithText(data['image']!, data['text']!);
          }).toList(),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: moodData.sublist(2, 4).map((data) {
            return _buildMoodImageWithText(data['image']!, data['text']!);
          }).toList(),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: moodData.sublist(4, 5).map((data) {
            return _buildMoodImageWithText(data['image']!, data['text']!);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMoodImageWithText(String imagePath, String text) {
    return GestureDetector(
      onTap: () {
        // Show the container with stars and text when the image is tapped
        _showStarsAndText(context, text);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 150,
            height: 150,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Color.fromARGB(255, 41, 28, 9),
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontFamily: 'WelcomeMandala',
            ),
          ),
        ],
      ),
    );
  }

  void _showStarsAndText(BuildContext context, String mood) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Stars sliding in animation
              _buildStarsChopInAnimation(),
              const SizedBox(height: 16),
              // Text below the stars
              Text(
                'Well done!\nYou are feeling $mood today',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 23,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'WelcomeMandala',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStarsChopInAnimation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStarChopIn(0), // First star
        const SizedBox(width: 10),
        _buildStarChopIn(200), // Second star with 200ms delay
        const SizedBox(width: 10),
        _buildStarChopIn(400), // Third star with 400ms delay
      ],
    );
  }

  Widget _buildStarChopIn(int delay) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: value, // Scale the star in
            child: const Text(
              '⭐',
              style: TextStyle(fontSize: 30),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGradientButton(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 255, 124, 10),
                Color.fromARGB(255, 253, 203, 156),
              ],
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: ElevatedButton(
            onPressed: () {
              // Navigate to StatsPage when the button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StatsPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 40),
                Expanded(
                  child: Text(
                    'Check your Mood Changes',
                    style: TextStyle(
                      color: Color.fromARGB(255, 41, 28, 9),
                      fontSize: 25,
                      fontFamily: 'WelcomeMandala',
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Color.fromARGB(255, 41, 28, 9),
                  size: 25,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 16,
          child: _buildWhiteCircleWithStar(),
        ),
      ],
    );
  }

  Widget _buildWhiteCircleWithStar() {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          '⭐',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}