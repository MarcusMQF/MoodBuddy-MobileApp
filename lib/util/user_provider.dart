import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final TextEditingController _usernameController = TextEditingController(text: 'Your Name');
  String _selectedAvatarUrl = 'https://lottie.host/53ab36c2-ea65-4159-ad05-51ecee62b79c/3TuoLD4q4d.json'; // Default avatar

  TextEditingController get usernameController => _usernameController;

  String get selectedAvatarUrl => _selectedAvatarUrl;

  void updateUsername(String newUsername) {
    _usernameController.text = newUsername;
    notifyListeners();
  }

  void updateSelectedAvatar(String avatarUrl) {
    _selectedAvatarUrl = avatarUrl;
    notifyListeners();
  }
}