import 'package:flame/animation.dart';
//import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:whack_a_mole/components/fly.dart';

import '../wack_game.dart';

class MachoFly extends Fly {
  double get speed => game.tileSize * 4;
  MachoFly(WackGame game) : super(game) {
    flyingSprite = [
      Sprite('flies/macho-fly-1.png'),
      Sprite('flies/macho-fly-2.png')
    ];
    //wingAnimation = SpriteAnimation.spriteList(flyingSprite, stepTime: 0.03);
    wingAnimation = Animation.spriteList(flyingSprite, stepTime: 0.03);
    // flyingSprite.add(Sprite(Flame.images.fromCache('flies/agile-fly-1.png')));
    // flyingSprite.add(Sprite(Flame.images.fromCache('flies/agile-fly-2.png')));
    deadSprite = Sprite('flies/macho-fly-dead.png');
  }
}
