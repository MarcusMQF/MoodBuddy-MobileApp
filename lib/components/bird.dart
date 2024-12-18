import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:moodbuddy_app/components/ground.dart';
import 'package:moodbuddy_app/components/pipe.dart';
import 'package:moodbuddy_app/constants.dart';
import 'package:moodbuddy_app/flappy_bird.dart';

class Bird extends SpriteComponent with CollisionCallbacks {

  Bird() : super(position: Vector2(birdStartX, birdStartY), size: Vector2(birdWidth, birdHeight));

  double velocity = 0.0;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('bird.png');

    add(RectangleHitbox());
  }

  void flap() {
    velocity = jumpStrength;
  }

  @override
  void update(double dt) {
    //apply gravity
    velocity += gravity * dt;
    position.y += velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if(other is Ground){
      (parent as FlappyBird).gameOver();
    }

    if(other is Pipe){
      (parent as FlappyBird).gameOver();
    }
  }
}