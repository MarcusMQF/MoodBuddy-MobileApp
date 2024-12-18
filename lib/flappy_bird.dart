import 'dart:async';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:moodbuddy_app/components/background.dart';
import 'package:moodbuddy_app/components/bird.dart';
import 'package:moodbuddy_app/components/ground.dart';
import 'package:moodbuddy_app/components/pipe_manager.dart';
import 'package:moodbuddy_app/components/pipe.dart';
import 'package:moodbuddy_app/components/score.dart';
import 'package:moodbuddy_app/constants.dart';

class FlappyBird extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;

  BuildContext? _gameContext; // Store the BuildContext

  @override
  FutureOr<void> onLoad() async {
    // Load background
    background = Background(size);
    add(background);

    // Load bird
    bird = Bird();
    add(bird);

    // Load ground
    ground = Ground();
    add(ground);

    // Load pipe manager
    pipeManager = PipeManager();
    add(pipeManager);

    // Load score text
    scoreText = ScoreText();
    add(scoreText);
  }

  @override
  void onTap() {
    if (!isGameOver) {
      bird.flap();
    }
  }

  int score = 0;

  void scoreIncreament() {
    score += 1;
  }

  bool isGameOver = false;

  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    showGameOverDialog();
  }

  void resetGame() {
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    score = 0;
    isGameOver = false;
    children.whereType<Pipe>().forEach((pipe) => pipe.removeFromParent());
    resumeEngine();
  }

  void showGameOverDialog() {
    if (_gameContext != null) {
      showDialog(
        context: _gameContext!,
        builder: (context) => AlertDialog(
          title: const Text("Game Over"),
          content: Text("High Score: $score"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                resetGame(); // Restart the game
              },
              child: const Text("Restart"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(_gameContext!); // Go back to the home page
              },
              child: const Text("Back"),
            ),
          ],
        ),
      );
    }
  }

  // Method to set the BuildContext
  void setGameContext(BuildContext context) {
    _gameContext = context;
  }
}