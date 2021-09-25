import 'package:flutter/material.dart';

import '../ui/correct_news.dart';
import '../ui/desc_persona.dart';
import '../ui/game_winner.dart';
import '../ui/lobby.dart';
import '../ui/room.dart';
import '../ui/round_winner.dart';
import '../ui/show_news.dart';
import '../ui/splash.dart';
import '../ui/vote_answer.dart';
import '../ui/vote_persona.dart';

class HyHRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case LobbyScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LobbyScreen());
      case RoomScreen.routeName:
        return MaterialPageRoute(settings: settings, builder: (_) => const RoomScreen());
      case VotePersonaScreen.routeName:
        return MaterialPageRoute(builder: (_) => const VotePersonaScreen());
      case DescPersonaScreen.routeName:
        return MaterialPageRoute(builder: (_) => const DescPersonaScreen());
      case ShowNewsScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ShowNewsScreen());
      case VoteAnswerScreen.routeName:
        return MaterialPageRoute(builder: (_) => const VoteAnswerScreen());
      case RoundWinnerScreen.routeName:
        return MaterialPageRoute(builder: (_) => const RoundWinnerScreen());
      case CorrectNewsScreen.routeName:
        return MaterialPageRoute(builder: (_) => const CorrectNewsScreen());
      case GameWinnerScreen.routeName:
        return MaterialPageRoute(builder: (_) => const GameWinnerScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            )
          )
        );
    }
  }
}