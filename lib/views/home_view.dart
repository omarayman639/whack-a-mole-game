import 'dart:ui';

//import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:whack_a_mole/wack_game.dart';

class HomeView {
  final WackGame game;
  Sprite titleSprite;
  Rect titleRect;

  HomeView(this.game) {
    titleRect = Rect.fromLTWH(
      game.tileSize,
      (game.screenSize.height / 2) - (game.tileSize * 4),
      game.tileSize * 7,
      game.tileSize * 4,
    );
    titleSprite = Sprite('branding/title.png');
  }

  void render(Canvas c) {
    titleSprite.renderRect(c, titleRect);
    // titleSprite.render(
    //   c,
    //   width: titleRect.width,
    //   height: titleRect.height,
    // );
  }

  void update(double t) {}
}
