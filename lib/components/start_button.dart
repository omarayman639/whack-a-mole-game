import 'dart:ui';
//import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:whack_a_mole/wack_game.dart';

import '../view.dart';

class StartButton {
  final WackGame game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      (game.screenSize.height * .75) - (game.tileSize * 1.5),
      game.tileSize * 6,
      game.tileSize * 3,
    );
    sprite = Sprite('ui/start-button.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
    // sprite.render(
    //   c,
    //   width: rect.width,
    //   height: rect.height,
    // );
  }

  void update(double t) {}

  void onTapDown() {
    print('pressed');
    game.currentView = View.playing;
    game.score = 0;

    game.spawner.start();
  }
}
