import 'package:flame/animation.dart';
//import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:whack_a_mole/components/fly.dart';

import '../wack_game.dart';

class HungryFly extends Fly {
  double get speed => game.tileSize * 7;
  HungryFly(WackGame game) : super(game) {
    flyingSprite = [
      Sprite('flies/hungry-fly-1.png'),
      Sprite('flies/hungry-fly-2.png')
    ];
    //wingAnimation = SpriteAnimation.spriteList(flyingSprite, stepTime: 0.03);
    wingAnimation = Animation.spriteList(flyingSprite, stepTime: 0.03);
    // flyingSprite.add(Sprite(Flame.images.fromCache('flies/agile-fly-1.png')));
    // flyingSprite.add(Sprite(Flame.images.fromCache('flies/agile-fly-2.png')));
    deadSprite = Sprite('flies/hungry-fly-dead.png');
  }
}
