import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/styles.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/ui/waiting_screen.dart';
import 'package:have_you_heard/widgets/app_button.dart';
import 'package:have_you_heard/widgets/game_exit_dialog.dart';
import 'package:have_you_heard/widgets/gray_stripe.dart';
import 'package:have_you_heard/widgets/in_game_app_bar.dart';

class VotePersonaScreen extends StatefulWidget {
  const VotePersonaScreen({Key? key}) : super(key: key);

  static const routeName = '/vote-persona';
  static const route = '/vote-persona';

  @override
  _VotePersonaScreenState createState() => _VotePersonaScreenState();
}

class _VotePersonaScreenState extends State<VotePersonaScreen> {
  final GameController gc = Get.find();

  String _persona = "not_set";
  Map<String, String> get allPersona => {
    'Antivacina': 'assets/images/Antivax.svg',
    'Bonosaro': 'assets/images/Bonosaro.svg',
    'Eron Must': 'assets/images/EronMust.svg',
    'Lulo': 'assets/images/Lulo.svg',
    'Salvio': 'assets/images/Salvio.svg',
    'Tia do Zap': 'assets/images/TiaDoZap.svg',
    'Tump': 'assets/images/Tump.svg',
    'Vegana': 'assets/images/Vegan.svg',
    'Aleatório': 'assets/images/Random.svg'
  };

  double colorPersonaTile(String persona) {
    if (_persona == 'not_set' || _persona == persona) {
      return 1.0;
    } else {
      return 0.40;
    }
  }

  Widget buildPersonaTile(String persona) {
    final height = MediaQuery.of(context).size.height;
    final scaleFactor = height/677;

    return Opacity (
      opacity: colorPersonaTile(persona),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.info_outline, size: 20 * scaleFactor, color: kGrayScaleMedium),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _persona = persona;
              });
            },
            child: Column(children: [
              Image(
                height: 78 * scaleFactor,
                fit: BoxFit.contain,
                image: Svg((allPersona[persona])!, size: const Size(63, 79)),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      persona,
                      textScaleFactor: scaleFactor,
                      style: HyhTextStyle.body14Bold,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: kGrayScaleMediumDark,
                ),
              ),
            ]),
          ),
        ]),
      ),
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
          appBar: InGameAppBar(
              onLeavePressed: () => ExitGameAlert(context, () => Navigator.of(context).pop(), () => gc.exitGame()),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GrayStripe(text: 'characterVote'.tr),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(left: 30, right: 30, top:30),
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
                  child: AppButton(
                    onPressed: () {
                      gc.votePersona(_persona);
                      var parameters = <String, String>{"titleFlag": "false", "bannerText": "Esperando votos"};
                      Get.offNamed(WaitingScreen.route, parameters: parameters);
                    },
                    color: kPink,
                    textColor: kGrayScaleLightest,
                   text: 'vote'.tr,
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
