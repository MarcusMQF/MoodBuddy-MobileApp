import 'package:flutter/material.dart';
import 'add_story_page.dart'; // Make sure this file exists and is correctly named

class StoryDicePage extends StatefulWidget {
  const StoryDicePage({super.key});

  @override
  State<StoryDicePage> createState() => _StoryDicePageState();
}

class _StoryDicePageState extends State<StoryDicePage> {
  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  int _selectedMonthIndex = DateTime.now().month - 1; // Default to current month
  final int _selectedYear = 2024; // Set to 2024 as per your requirement
  int _selectedDay = DateTime.now().day; // Default to current day

  // Map to store diary entries by date (day)
  final Map<int, List<DiaryEntry>> _diaryEntries = {};

  void _showMonthPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 300, // Increased height of the bottom sheet
          child: ListView.builder(
            itemCount: _months.length,
            itemBuilder: (context, index) {
              return Center(
                child: ListTile(
                  title: Text(
                    _months[index],
                    textAlign: TextAlign.center, 
                    style: TextStyle(
                      color: index == _selectedMonthIndex
                          ? Colors.blue
                          : Colors.black,
                      fontSize: 30,
                      fontFamily: 'WelcomeMandala',
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedMonthIndex = index;
                      _selectedDay = 1; // Reset to the first day when month changes
                    });
                    Navigator.pop(context);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  int _getNumberOfDaysInMonth(int month, int year) {
    return DateTime(year, month + 1, 0).day;
  }

  void _showParentTips(String mood) {
    String tips = '';
    switch (mood) {
      case '😊':
      case '😍':
      case '🤩':
        tips = 
            '• Encourage the child to incorporate more positive emotions and uplifting themes into their stories.\n'
            '• Suggest collaborative storytelling where the child and parent take turns adding to the narrative.\n'
            '• Recommend outdoor play or physical activities to help the child channel their positive energy.\n'
            '• Praise the child\'s creativity and emotional expression during the storytelling.';
        break;
      case '😢':
        tips = 
            '• Validate the child\'s feelings and let them know it\'s okay to feel sad sometimes.\n'
            '• Suggest incorporating comforting characters, settings, or activities into the story.\n'
            '• Recommend calming sensory activities like squeezing a stress ball or listening to soothing music after the storytelling.\n'
            '• Encourage the child to talk about what\'s making them feel sad, if they\'re comfortable.';
        break;
      case '😡':
        tips = 
            '• Remind the child that it\'s normal to feel angry, but help them find healthy ways to express those emotions.\n'
            '• Guide them to use the dice to create stories where the characters work through their anger constructively.\n'
            '• Suggest taking deep breaths or doing light stretches before continuing the storytelling session.\n'
            '• Offer to help the child retell the story from a calmer perspective.';
        break;
      default:
        tips = 'No tips available for this mood.';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tips for Parents',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: Text(
            tips,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final int numberOfDays =
        _getNumberOfDaysInMonth(_selectedMonthIndex + 1, _selectedYear);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 239),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 248, 239),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.tune, color: Colors.black),
          onPressed: _showMonthPicker,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Story Dice',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'WelcomeMandala',
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _months[_selectedMonthIndex],
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 25,
                fontFamily: 'WelcomeMandala',
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // Days of the week and day numbers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0), // Add horizontal padding
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: numberOfDays,
                itemBuilder: (context, index) {
                  final day = index + 1;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDay = day;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _getDayOfWeek(day), // Day of the week
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: day == _selectedDay
                                  ? Colors.green
                                  : Colors.blue.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                day.toString(), // Day number
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
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
          // Separate line below the day listview with padding
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0), // Add horizontal padding
            child: Divider(
              color: Colors.grey,
              thickness: 1,
              height: 20,
            ),
          ),
          // Month and Year Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0), // Add horizontal and vertical padding
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${_months[_selectedMonthIndex]} 2024',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          // Diary Entries
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0), // Add horizontal padding
              child: _diaryEntries[_selectedDay] != null && _diaryEntries[_selectedDay]!.isNotEmpty
                  ? ListView.separated(
                      itemCount: _diaryEntries[_selectedDay]!.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 10), // Add spacing between entries
                      itemBuilder: (context, index) {
                        return _diaryEntries[_selectedDay]![index];
                      },
                    )
                  : Center(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 90), // Add vertical margin
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Add the image here
                            Image.asset(
                              'assets/beach.png', // Path to your image
                              width: 100, // Adjust the width as needed
                              height: 100, // Adjust the height as needed
                            ),
                            const SizedBox(height: 10), // Add spacing between image and text
                            const Text(
                              'No stories saved for this day',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to AddStoryPage when the button is clicked
          final DiaryEntry? newEntry = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddStoryPage()),
          );

          if (newEntry != null) {
            setState(() {
              // Store the entry based on the date selected in AddStoryPage
              final selectedDay = newEntry.date.day;
              _diaryEntries[selectedDay] ??= [];
              _diaryEntries[selectedDay]!.add(newEntry);
            });

            // Show parent tips based on the mood
            _showParentTips(newEntry.mood);
          }
        },
        backgroundColor: const Color.fromARGB(255, 41, 28, 9),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  String _getDayOfWeek(int day) {
    final daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final firstDayOfMonth = DateTime(_selectedYear, _selectedMonthIndex + 1, 1).weekday;
    final adjustedDay = (day + firstDayOfMonth - 1) % 7;
    return daysOfWeek[adjustedDay];
  }
}

class DiaryEntry extends StatelessWidget {
  final String mood;
  final String time;
  final String content;
  final DateTime date; // Add date to the DiaryEntry

  const DiaryEntry({
    super.key,
    required this.mood,
    required this.time,
    required this.content,
    required this.date,
  });

  // Map emoji to mood name
  String getMoodName(String emoji) {
    switch (emoji) {
      case '😊':
        return 'Happy';
      case '😢':
        return 'Sad';
      case '😡':
        return 'Angry';
      case '😍':
        return 'Lovely';
      case '🤩':
        return 'Excited';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1), // Shadow position
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                mood,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                getMoodName(mood),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}