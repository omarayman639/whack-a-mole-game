import 'dart:math';
import 'dart:ui';
import 'package:flame/animation.dart';
//import 'package:vector_math/vector_math.dart';
// import 'package:flame_audio/flame_audio.dart';

import 'package:whack_a_mole/wack_game.dart';
import 'package:flame/sprite.dart';

import '../view.dart';
import 'callout.dart';

class Fly {
  final WackGame game;
  // Rect flyRect;
  bool isDead = false;
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  Random rnd;
  double flyPositionX;
  double flyPositionY;
  Rect flyRect;
  double get speed => game.tileSize * 3;
  Offset targetLocation;
  Animation wingAnimation;
  Callout callout;

  Fly(this.game) {
    setTargetLocation();
    rnd = Random();
    callout = Callout(this);
    flyPositionX =
        rnd.nextDouble() * (this.game.screenSize.width - game.tileSize * 2);
    flyPositionY =
        rnd.nextDouble() * (this.game.screenSize.height - game.tileSize * 2);
    flyRect = Rect.fromLTWH(flyPositionX, flyPositionY, this.game.tileSize * 2,
        this.game.tileSize * 2);
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() *
        (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rnd.nextDouble() *
        (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }

  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(c, flyRect);
      // deadSprite.render(
      //   c,
      //   width: flyRect.width,
      //   height: flyRect.height,
      // );
    } else {
      if (game.currentView == View.playing) {
        callout.render(c);
      }
      wingAnimation.getSprite().renderRect(c, flyRect);
      // flyingSprite[flyingSpriteIndex.toInt()].render(c,
      //     size: Vector2(referenceRect.width, referenceRect.height),
      //     position: Vector2(referenceRect.left, referenceRect.top));
    }
  }

  void update(double t) {
    callout.update(t);
    if (isDead) {
      flyPositionY += game.tileSize * 13 * t;
      if (flyPositionY > game.screenSize.height) {
        isOffScreen = true;
      }
      flyRect = flyRect.translate(0, game.tileSize * 13 * t);
    } else {
      wingAnimation.update(t);
      double stepDistance = speed * t;
      Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget =
            Offset.fromDirection(toTarget.direction, stepDistance);
        flyRect = flyRect.shift(stepToTarget);
      } else {
        flyRect = flyRect.shift(toTarget);
        setTargetLocation();
      }
    }
  }

  void onTapDown() {
    if (!isDead) {
      isDead = true;
      // try {
      //   FlameAudio.play('sfx/haha4.ogg');
      // } catch (e) {
      //   print(e);
      // }

      if (game.currentView == View.playing) {
        game.score += 1;
        if (game.score > (game.storage.getInt('highscore') ?? 0)) {
          game.storage.setInt('highscore', game.score);
          game.highscoreDisplay.updateHighscore();
        }
      }
    }
    game.spawnFly();
  }
}
