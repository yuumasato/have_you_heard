import 'package:get/get.dart';
import 'package:have_you_heard/controller/game_controller.dart';

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

List<GetPage> getHyhRoutes() {
  return [
    GetPage(name: SplashScreen.routeName,      page: () => const SplashScreen(),      ),
    GetPage(name: LobbyScreen.routeName,       page: () => const LobbyScreen(),       ),
    GetPage(name: RoomScreen.routeName,        page: () => const RoomScreen(),        ),
    GetPage(name: VotePersonaScreen.routeName, page: () => const VotePersonaScreen(), ),
    GetPage(name: DescPersonaScreen.routeName, page: () => const DescPersonaScreen(), ),
    GetPage(name: ShowNewsScreen.routeName,    page: () => const ShowNewsScreen(),    ),
    GetPage(name: VoteAnswerScreen.routeName,  page: () => const VoteAnswerScreen(),  ),
    GetPage(name: RoundWinnerScreen.routeName, page: () => const RoundWinnerScreen(), ),
    GetPage(name: CorrectNewsScreen.routeName, page: () => const CorrectNewsScreen(), ),
    GetPage(name: GameWinnerScreen.routeName,  page: () => const GameWinnerScreen(),  ),
  ];
}

void getHyhBindings () {
      Get.put<GameController>(GameController(), permanent: true);
}