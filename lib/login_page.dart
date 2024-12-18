import 'package:flutter/material.dart';
import 'package:moodbuddy_app/home_page.dart'; // Import the home page

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  List<int> enteredDigits = [];
  late AnimationController _animationController;
  bool _isLocked = true;

  void _onNumberPressed(int number) {
    setState(() {
      if (enteredDigits.length < 4) {
        enteredDigits.add(number);
      }
      if (enteredDigits.length == 4) {
        _isLocked = false;
        _animationController.forward().then((_) {
          // Navigate to the home page after the animation completes
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        });
      }
    });
  }

  void _onDeletePressed() {
    setState(() {
      if (enteredDigits.isNotEmpty) {
        enteredDigits.removeLast();
      }
      if (enteredDigits.length < 4) {
        _isLocked = true;
        _animationController.reverse();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 239),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 80),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Icon(
                  _isLocked ? Icons.lock_outline : Icons.lock_open,
                  size: 50,
                  key: ValueKey(_isLocked),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Enter your PIN',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 41, 28, 9),
                  fontFamily: 'NexaHeavy',
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: enteredDigits.length > index
                            ? const Color.fromARGB(255, 41, 28, 9)
                            : Colors.grey,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                padding: const EdgeInsets.all(20),
                mainAxisSpacing: 20, // Spacing between rows
                crossAxisSpacing: 1, // Spacing between columns
                children: List.generate(12, (index) {
                  if (index == 9) {
                    return const SizedBox.shrink(); // Empty space for alignment
                  } else if (index == 10) {
                    return _buildNumberButton(0); // Number 0
                  } else if (index == 11) {
                    return _buildDeleteButton(); // Delete button
                  } else {
                    return _buildNumberButton(index + 1); // Numbers 1-9
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButton(int number) {
    return ElevatedButton(
      onPressed: () => _onNumberPressed(number),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 41, 28, 9),
        shape: const CircleBorder(),
      ),
      child: Text(
        number.toString(),
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return ElevatedButton(
      onPressed: _onDeletePressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 41, 28, 9),
        shape: const CircleBorder(),
      ),
      child: const Icon(
        Icons.backspace,
        color: Colors.white,
      ),
    );
  }
}