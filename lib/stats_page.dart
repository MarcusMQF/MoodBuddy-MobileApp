import 'dart:math';

import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> with SingleTickerProviderStateMixin {
  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  int _selectedMonthIndex = DateTime.now().month - 1; // Default to current month
  final int _selectedYear = 2024; // Set to 2024 as per your requirement

  late AnimationController _animationController;
  late Animation<double> _animation;

  double _currentProgress = 4 / 10; // Default progress
  String _currentText = 'Today'; // Default text

  void _changeProgress(double newProgress, String newText) {
    setState(() {
      _currentProgress = newProgress;
      _currentText = newText;
      _animation = Tween<double>(begin: 0, end: newProgress).animate(_animationController)
        ..addListener(() {
          setState(() {}); // Trigger a rebuild to update the progress bar
        });
      _animationController.forward(from: 0); // Restart the animation
    });
  }

  void _changeMonth(int delta) {
    setState(() {
      _selectedMonthIndex = (_selectedMonthIndex + delta) % _months.length;
    });
  }

  int _getNumberOfDaysInMonth(int month, int year) {
    return DateTime(year, month + 1, 0).day;
  }

  String _getDayOfWeek(int day, int month, int year) {
    final daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final firstDayOfMonth = DateTime(year, month, 1).weekday;
    final adjustedDay = (day + firstDayOfMonth - 1) % 7;
    return daysOfWeek[adjustedDay];
  }

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Duration of the animation
    );

    // Create the animation from 0 to the current progress value
    _animation = Tween<double>(begin: 0, end: _currentProgress).animate(_animationController)
      ..addListener(() {
        setState(() {}); // Trigger a rebuild to update the progress bar
      });

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int numberOfDays = _getNumberOfDaysInMonth(_selectedMonthIndex + 1, _selectedYear);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 239),
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make the app bar transparent
        elevation: 0, // Remove the shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Back arrow
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: const Text(
          'Your Journey',
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            letterSpacing: 1.5,
            fontFamily: 'WelcomeMandala',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Center the title
      ),
      body: SingleChildScrollView( // Make the page scrollable
        padding: const EdgeInsets.all(16.0), // Padding for the entire body
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
                  onPressed: () {
                    _changeProgress(7 / 10, 'Yesterday');
                  },
                ),
                const SizedBox(width: 10),
                Text(
                  _currentText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
                  onPressed: () {
                    _changeProgress(4 / 10, 'Today');
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(child: _buildCircularProgressBar()), // Center the progress bar
            const SizedBox(height: 20),
            Text(
              '${(_currentProgress * 10).toInt()}/10', // Display the progress value below the circular bar
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Stories Created', // Display "Steps" below the progress value
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            _buildWhiteRoundedContainer(numberOfDays), // Add the white rounded container
            const SizedBox(height: 16), // Add space between the rounded container and the square containers
            _buildRoundedSquareContainers(), // Add 4 rounded square containers
            const SizedBox(height: 20), // Add space between the bottom of the screen and the bottom of the containers
          ],
        ),
      ),
    );
  }

  Widget _buildCircularProgressBar() {
    // ignore: unused_local_variable
    const double maxValue = 10; // Maximum value for the progress bar

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 130,
          height: 130,
          child: CustomPaint(
            painter: RoundedCircularProgressPainter(
              progress: _animation.value, // Use the animated value
              backgroundColor: Colors.grey[300]!,
              progressColor: const Color.fromARGB(255, 11, 90, 155),
              strokeWidth: 12,
            ),
          ),
        ),
        const Icon(
          Icons.menu_book_rounded, // Open book icon
          size: 50,
          color: Color.fromARGB(255, 11, 90, 155),
        ),
      ],
    );
  }

  Widget _buildWhiteRoundedContainer(int numberOfDays) {
    return Container(
      width: double.infinity, // Full width of the screen
      height: 370, // Decrease the height to fit the layout better
      padding: const EdgeInsets.symmetric(horizontal: 10), // Add padding on both sides
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: BorderRadius.circular(20), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Subtle shadow
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Mood Chart', // Add "Mood Chart" text
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10), // Reduce space between "Mood Chart" and ListView
          _buildMoodIndicatorRow(), // Add mood indicator row
          const SizedBox(height: 10), // Add space between mood indicators and ListView
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0), // Add padding on the left side
              child: _buildHorizontalListView(numberOfDays), // Horizontal list view for days
            ),
          ),
          const SizedBox(height: 10), // Reduce space below the ListView
          _buildMonthNavigation(), // Month navigation with arrows at the bottom
        ],
      ),
    );
  }

  Widget _buildMoodIndicatorRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildMoodIndicator(Colors.pink, 'Lovely'),
        const SizedBox(width: 10),
        _buildMoodIndicator(Colors.red, 'Angry'),
        const SizedBox(width: 10),
        _buildMoodIndicator(Colors.orange, 'Excited'),
        const SizedBox(width: 10),
        _buildMoodIndicator(Colors.blue, 'Sad'),
        const SizedBox(width: 10),
        _buildMoodIndicator(Colors.green, 'Happy'),
      ],
    );
  }

  Widget _buildMoodIndicator(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildMonthNavigation() {
    final maxMonthWidth = _calculateMaxMonthWidth();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0), // Add padding between month navigation and container bottom
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black, size: 20),
            onPressed: () => _changeMonth(-1), // Previous month
          ),
          Container(
            width: maxMonthWidth,
            height: 38,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 11, 90, 155),
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.center,
            child: Text(
              _months[_selectedMonthIndex],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black, size: 20),
            onPressed: () => _changeMonth(1), // Next month
          ),
        ],
      ),
    );
  }

  double _calculateMaxMonthWidth() {
    const textStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    double maxWidth = 0.0;

    for (final month in _months) {
      textPainter.text = TextSpan(text: month, style: textStyle);
      textPainter.layout();
      if (textPainter.width > maxWidth) {
        maxWidth = textPainter.width;
      }
    }

    return maxWidth + 20; // Add some padding
  }

  Widget _buildHorizontalListView(int numberOfDays) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: numberOfDays,
      itemBuilder: (context, index) {
        final day = index + 1;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0), // Add padding between grey bars
          child: _buildDayItem(day),
        );
      },
    );
  }

  Widget _buildDayItem(int day) {
    // Only show percentage bars for December
    if (_selectedMonthIndex != 11) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 150,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 230, 230, 230), // Light grey background
              borderRadius: BorderRadius.circular(5), // Rounded corners
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getDayOfWeek(day, _selectedMonthIndex + 1, _selectedYear), // Day of the week
            style: const TextStyle(
              fontSize: 16, // Increase font size
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            day.toString(), // Display the date (e.g., "13")
            style: const TextStyle(
              fontSize: 16, // Increase font size
              color: Colors.grey,
            ),
          ),
        ],
      );
    }

    // For December, show percentage bars
    final Map<int, Map<String, dynamic>> dayData = {
      1: {'percentage': 70, 'color': Colors.green},
      2: {'percentage': 30, 'color': Colors.blue},
      3: {'percentage': 50, 'color': Colors.red},
      5: {'percentage': 40, 'color': Colors.orange},
      6: {'percentage': 100, 'color': Colors.pink},
    };

    final data = dayData[day];
    final percentage = data?['percentage'] ?? 0;
    final color = data?['color'] ?? Colors.grey;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: 30, // Keep the width of the grey bar the same
              height: 150, // Increase the height of the grey bar
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 230, 230, 230), // Light grey background
                borderRadius: BorderRadius.circular(5), // Rounded corners
              ),
            ),
            Container(
              width: 30,
              height: (150 * percentage / 100),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.5),
                    color,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _getDayOfWeek(day, _selectedMonthIndex + 1, _selectedYear), // Day of the week
          style: const TextStyle(
            fontSize: 16, // Increase font size
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          day.toString(), // Display the date (e.g., "13")
          style: const TextStyle(
            fontSize: 16, // Increase font size
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildRoundedSquareContainers() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align containers with space between
          children: [
            _buildRoundedSquareContainer(
              'Emotion Dice', // First row text
              4, // Number of rolls
              'Rolls', // Second row text
              'Today', // Third row text
            ),
            _buildRoundedSquareContainer(
              'Character Dice', // First row text
              2, // Number of rolls
              'Rolls', // Second row text
              'Today', // Third row text
            ),
          ],
        ),
        const SizedBox(height: 16), // Add space between rows
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align containers with space between
          children: [
            _buildRoundedSquareContainer(
              'Setting Dice', // First row text
              2, // Number of rolls
              'Rolls', // Second row text
              'Today', // Third row text
            ),
            _buildRoundedSquareContainer(
              'Action Dice', // First row text
              2, // Number of rolls
              'Rolls', // Second row text
              'Today', // Third row text
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRoundedSquareContainer(
    String firstRowText,
    int rolls,
    String rollsText,
    String thirdRowText,
  ) {
    return Container(
      width: (MediaQuery.of(context).size.width - 50) / 2, // Adjusted width to make containers closer
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            firstRowText,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                rolls.toString(),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                rollsText,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 136, 136, 136),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            thirdRowText,
            style: const TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 136, 136, 136),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedCircularProgressPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;

  RoundedCircularProgressPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    // Draw the background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Rounded ends

    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw the progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Rounded ends

    const startAngle = -pi / 2; // Start from the top
    final sweepAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}