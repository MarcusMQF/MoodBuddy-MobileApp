import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:moodbuddy_app/flappy_bird.dart';

class ScoreText extends TextComponent with HasGameRef<FlappyBird> {
  ScoreText() : super(
    text: '0',
    textRenderer: TextPaint(
      style: const TextStyle(
        fontFamily: 'GamePlay',
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 50,
      )
    )
  );

  @override
  FutureOr<void> onLoad() {
    position = Vector2(
      (gameRef.size.x - size.x) / 2,
      gameRef.size.y - size.y - 50
    );
  }

  @override
  void update(double dt) {
    final newText = gameRef.score.toString();
    if (text != newText){
      text = newText;
    }
  }
}