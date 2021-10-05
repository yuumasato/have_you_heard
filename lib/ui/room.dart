import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/constants/styles.dart';
import 'package:have_you_heard/widgets/app_button.dart';
import 'package:have_you_heard/widgets/gray_stripe.dart';

import 'vote_persona.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  static const routeName = '/room/:roomID';
  static const route = '/room';

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

List<String> allPlayers = [
  'Nickname 1',
  'Nickname 2',
  'Nickname 3',
  'Nickname 4',
  'Nickname 5',
  'Nickname 6',
];
List<double?> loadingValues = [0, 0.3, 0.5, 0.7, 1, null];
List<Color> playerColors = [
  kPlayer_1,
  kPlayer_2,
  kPlayer_3,
  kPlayer_4,
  kPlayer_5,
  kPlayer_6
];

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    final GameController gc = Get.find();
    final roomID = Get.parameters['roomID'];
    var screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GrayStripe(text: "privateRoom".tr),
            Center(
              child: Text(
                '# $roomID',
                style: kRoomNumberStyle,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  bottom: appBarHeight * 0.5,
                  left: screenWidth * 0.1,
                  right: screenWidth * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "waitingPlayers".tr,
                    style: const TextStyle(color: Colors.white),
                  ),
                  for (var index = 0; index < 6; index++)
                    buildPlayerButton(index),
                  SizedBox(height: appBarHeight * 0.67),
                  AppButton(
                    color: kPinkButton,
                    width: screenWidth * 0.8,
                    onPressed: () {
                      Get.offNamed(VotePersonaScreen.route);
                    },
                    child: Text(
                      'startGame'.tr,
                      style: kElevatedButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlayerButton(int i) {
    final appBarHeight = AppBar().preferredSize.height;
    return Container(
      padding: EdgeInsets.symmetric(vertical: appBarHeight * 0.08),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Stack(alignment: AlignmentDirectional.center, children: [
          LinearProgressIndicator(
            value: loadingValues[i],
            color: playerColors[i],
            minHeight: appBarHeight * 0.66,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: appBarHeight * 0.2),
                child: Text(allPlayers[i]),
              ),
              Visibility(
                child: const Icon(Icons.check),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: loadingValues[i] == 1 ? true : false,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
