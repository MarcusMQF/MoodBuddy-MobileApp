import 'package:flutter/material.dart';
import 'package:moodbuddy_app/story_dice_page.dart';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({super.key});

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  final TextEditingController _contentController = TextEditingController();
  String _selectedMood = '😊'; // Default mood emoji
  TimeOfDay _selectedTime = TimeOfDay.now(); // Default time
  DateTime _selectedDate = DateTime.now(); // Default date

  // Track whether the text field is focused
  bool _isTextFieldFocused = false;

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Function to show the time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 239), // Background color
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent app bar
        elevation: 0, // Remove shadow
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30), // Add margin to the right
            child: ElevatedButton(
              onPressed: () {
                // Add logic to save the note
                Navigator.pop(
                  context,
                  DiaryEntry(
                    mood: _selectedMood,
                    time: _selectedTime.format(context),
                    content: _contentController.text,
                    date: _selectedDate, // Pass the selected date
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 11, 90, 155),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              ),
              child: const SizedBox(
                width: 80, // Set the width to match the example
                height: 40, // Set the height to match the example
                child: Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'WelcomeMandala',
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Choose Mood Section
            const Text(
              'Choose Your Mood',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                // Mood Emojis
                _buildMoodButton('😊'),
                _buildMoodButton('😢'),
                _buildMoodButton('😡'),
                _buildMoodButton('😍'),
                _buildMoodButton('🤩'),
              ],
            ),
            const SizedBox(height: 16),

            // Input Time Section
            const Text(
              'Input Time',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                // Time text on the left
                Text(
                  _selectedTime.format(context),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(), // Spacer to push the button to the right
                Padding(
                  padding: const EdgeInsets.only(right: 12.0), // Add padding to the right
                  child: ElevatedButton(
                    onPressed: () => _selectTime(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 11, 90, 155),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      'Select Time',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Choose Date Section
            const Text(
              'Choose Date',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                // Date text on the left
                Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(), // Spacer to push the button to the right
                Padding(
                  padding: const EdgeInsets.only(right: 12.0), // Add padding to the right
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 11, 90, 155),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      'Select Date',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Add Content Section
            const Text(
              'Story Telling',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Focus(
                onFocusChange: (hasFocus) {
                  setState(() {
                    _isTextFieldFocused = hasFocus;
                  });
                },
                child: Stack(
                  children: [
                    // TextField for input
                    TextField(
                      controller: _contentController,
                      maxLines: null, // Allow multiple lines
                      expands: true, // Expand to fill the available space
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 255, 255), // White background for text fields
                        hintText: _isTextFieldFocused ? '' : 'Add\nContent\nHere',
                        hintStyle: const TextStyle(
                          fontSize: 40,
                          color: Colors.grey,
                        ),
                        hintMaxLines: 3, // Ensure the hint text wraps into 3 lines
                        contentPadding: const EdgeInsets.only(
                          top: 30, // Adjust this value to move the hint text up
                          left: 16,
                          right: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build mood buttons
  Widget _buildMoodButton(String emoji) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedMood = emoji;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _selectedMood == emoji
              ? const Color.fromARGB(255, 11, 90, 155)
              : Colors.grey[300],
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(12),
        ),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}