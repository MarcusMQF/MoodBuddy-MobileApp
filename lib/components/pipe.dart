import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:moodbuddy_app/constants.dart';
import 'package:moodbuddy_app/flappy_bird.dart';

class Pipe extends SpriteComponent with CollisionCallbacks, HasGameRef<FlappyBird> {
  final bool isTopPipe;

  bool scored = false;

  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
    :super(position: position, size: size);

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(isTopPipe ? 'pipe_top.png' : 'pipe_bottom.png');

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.x -= groundScrollingSpeed * dt;

    if(!scored && position.x + size.x < gameRef.bird.position.x){
      scored = true;

      if(isTopPipe){
        gameRef.scoreIncreament();
      }
    }

    if(position.x + size.x <= 0){
      removeFromParent();
    }
  }
}