import 'dart:ui';
//import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:whack_a_mole/wack_game.dart';

import '../view.dart';

class HelpButton {
  final WackGame game;
  Rect rect;
  Sprite sprite;

  HelpButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * .25,
      game.screenSize.height - (game.tileSize * 1.25),
      game.tileSize,
      game.tileSize,
    );
    sprite = Sprite('ui/icon-help.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
    // sprite.render(
    //   c,
    //   width: rect.width,
    //   height: rect.height,
    // );
  }

  void onTapDown() {
    game.currentView = View.help;
  }
}
