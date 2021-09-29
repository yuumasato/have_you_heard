import 'package:flutter/material.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/router/parser.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'constants/locale_string.dart';
import 'game_state.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => HyhState()),
      ChangeNotifierProvider(create: (context) => GameState()),
    ],
    child: const Hyh(),
  ));
}

class Hyh extends StatelessWidget {
  const Hyh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kBackgroundDarkestGray,
        ),
        translations: LocalString(),
        locale: Locale('pt', 'BR'),
        onGenerateRoute: HyHRouter.generateRoute,
        initialRoute: '/splash');
  }
}
