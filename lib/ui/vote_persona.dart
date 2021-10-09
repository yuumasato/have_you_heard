import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/widgets/game_exit_dialog.dart';

import 'desc_persona.dart';

class VotePersonaScreen extends StatefulWidget {
  const VotePersonaScreen({Key? key}) : super(key: key);

  static const routeName = '/vote-persona';
  static const route = '/vote-persona';

  @override
  _VotePersonaScreenState createState() => _VotePersonaScreenState();
}

class _VotePersonaScreenState extends State<VotePersonaScreen> {
  final GameController gc = Get.find();

  Map<String, String> get allPersona => {
    'Antivax': 'assets/images/Antivax.svg',
    'Bonosaro': 'assets/images/Bonosaro.svg',
    'Eron Must': 'assets/images/EronMust.svg',
    'Lulo': 'assets/images/Lulo.svg',
    'Salvio': 'assets/images/Salvio.svg',
    'Tia do zap': 'assets/images/TiaDoZap.svg',
    'Tump': 'assets/images/Tump.svg',
    'Vegan': 'assets/images/Antivax.svg',
    'Aleatório': 'assets/images/Random.svg'
  };

  Widget buildPersonaTile(String persona) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Icon(Icons.info_outline, size: 20),
          ],
        ),
        Image(
          image: Svg((allPersona[persona])!, size: Size(63, 79)),
        ),
        Container(
          padding: EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                persona,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: kBackgroundDarkGray,
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var appBarHeight = AppBar().preferredSize.height;
    return GameExitDialog (
        onElevatedPressed: () => Navigator.of(context).pop(),
        onPlainPressed: () => gc.exitGame(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kBackgroundDarkestGray,
            automaticallyImplyLeading: false,
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 45,
                  color: kBackgroundDarkGray,
                  alignment: Alignment.center,
                  child: const Text(
                    'Votação de personagens',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.4),
                      children: [
                        for (var persona in allPersona.keys)
                          buildPersonaTile(persona),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.1,
                      right: screenWidth * 0.1,
                      bottom: appBarHeight * 0.5),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offNamed(DescPersonaScreen.route);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kPinkButton,
                    ),
                    child: const Text(
                      'Votar',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
