import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:whack_a_mole/components/backyard.dart';
import 'package:whack_a_mole/components/fly.dart';
//import 'package:flame/flame.dart';
import 'dart:math';

import 'package:whack_a_mole/components/house_fly.dart';
import 'package:whack_a_mole/view.dart';
import 'package:whack_a_mole/views/help_view.dart';
import 'package:whack_a_mole/views/home_view.dart';
import 'package:whack_a_mole/views/lost_view.dart';

import 'components/agile_fly.dart';
import 'components/drooler_fly.dart';
import 'components/help-button.dart';
import 'components/highscore_display.dart';
import 'components/hungry_fly.dart';
import 'components/macho_fly.dart';
import 'components/score_display.dart';
import 'components/start_button.dart';
import 'controllers/fly_spawner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WackGame extends Game with TapDetector {
  Size screenSize;
  double tileSize;
  List<Fly> flies;
  Random rnd;
  Backyard backyard;
  View currentView = View.home;
  HomeView homeView;
  LostView lostView;
  StartButton startButton;
  HelpButton helpButton;
  HelpView helpView;
  FlySpawner spawner;
  int score;
  ScoreDisplay scoreDisplay;
  final SharedPreferences storage;
  HighscoreDisplay highscoreDisplay;

  WackGame(this.storage) {
    initialize();
  }

  void initialize() async {
    score = 0;
    resize(await Flame.util.initialDimensions());
    flies = [];
    rnd = Random();
    backyard = Backyard(this);
    homeView = HomeView(this);
    lostView = LostView(this);
    startButton = StartButton(this);
    helpButton = HelpButton(this);
    helpView = HelpView(this);
    spawner = FlySpawner(this);
    scoreDisplay = ScoreDisplay(this);
    highscoreDisplay = HighscoreDisplay(this);
  }

  void render(Canvas canvas) {
    backyard.render(canvas);
    highscoreDisplay.render(canvas);
    if (currentView == View.playing) scoreDisplay.render(canvas);
    flies.forEach((Fly fly) => fly.render(canvas));
    if (currentView == View.home) homeView.render(canvas);
    if (currentView == View.home || currentView == View.lost) {
      startButton.render(canvas);
      helpButton.render(canvas);
    }
    if (currentView == View.help) helpView.render(canvas);
    if (currentView == View.lost) lostView.render(canvas);
  }

  void update(double t) {
    spawner.update(t);
    if (currentView == View.playing) scoreDisplay.update(t);
    flies.forEach((Fly fly) => fly.update(t));
    flies.removeWhere((Fly fly) => fly.isOffScreen);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    super.resize(size);
  }

  void spawnFly() {
    switch (rnd.nextInt(5)) {
      case 0:
        flies.add(HouseFly(this));
        break;
      case 1:
        flies.add(DroolerFly(this));
        break;
      case 2:
        flies.add(AgileFly(this));
        break;
      case 3:
        flies.add(MachoFly(this));
        break;
      case 4:
        flies.add(HungryFly(this));
        break;
    }
  }

  void onTapDown(TapDownDetails d) {
    print('pressed wack_game');
    bool didHitAFly = false;
    bool isHandled = false;
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (currentView == View.home || currentView == View.lost) {
        startButton.onTapDown();
        isHandled = true;
      }
    }
    if (!isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (currentView == View.home || currentView == View.lost) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }

    if (!isHandled) {
      if (currentView == View.help) {
        currentView = View.home;
        isHandled = true;
      }
    }

    if (!isHandled) {
      flies.forEach((Fly fly) {
        if (!fly.isDead && fly.flyRect.contains(d.globalPosition)) {
          print('entered wack ontapdown');
          fly.onTapDown();
          didHitAFly = true;
          isHandled = true;
        }
      });
      if (currentView == View.playing && !didHitAFly) {
        currentView = View.lost;
      }
    }
  }
}
