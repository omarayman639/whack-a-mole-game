import 'dart:ui';
////import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:whack_a_mole/wack_game.dart';

class Backyard {
  final WackGame game;
  Sprite bgSprite;
  Rect bgRect;

  Backyard(this.game) {
    initialize();
  }

  void initialize() {
    bgSprite = Sprite('bg/backyard.png');
  }

  void render(Canvas c) {
    if (bgSprite != null) {
      bgSprite.render(
        c,
        width: game.screenSize.width,
        height: game.screenSize.height,
      );
    }
  }

  void update(double t) {}
}
