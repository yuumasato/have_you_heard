import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/constants/styles.dart';
import 'package:have_you_heard/widgets/app_button.dart';
import 'package:have_you_heard/widgets/game_exit_dialog.dart';
import 'package:have_you_heard/widgets/gray_stripe.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  static const routeName = '/room/:roomID';
  static const route = '/room';

  @override
  _RoomScreenState createState() => _RoomScreenState();
}


class _RoomScreenState extends State<RoomScreen> {

  final GameController gc = Get.find();

  List<double?> loadingValues = [0.015, 0.3, 0.5, 0.7, 1, null];
  List<Color> playerColors = [
    kPlayer_1,
    kPlayer_2,
    kPlayer_3,
    kPlayer_4,
    kPlayer_5,
    kPlayer_6
  ];

  @override
  Widget build(BuildContext context) {
    final roomID = Get.parameters['roomID'];
    var screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;

    return GameExitDialog (
        onElevatedPressed: () => Navigator.of(context).pop(),
        onPlainPressed: () => gc.exitGame(),
        child: Scaffold(
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
                      Obx(() => Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: (gc.game.ownerID.value == gc.myPlayer.id) ? true : false,
                        child: AppButton(
                          color: kPink,
                          width: screenWidth * 0.8,
                          onPressed: (gc.game.nPlayers.value >= 1) ? () {
                            gc.startGame();
                          } : null,
                          child: Text(
                            'startGame'.tr,
                            style: kElevatedButtonTextStyle,
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget buildPlayerButton(int index) {
    final appBarHeight = AppBar().preferredSize.height;
    return Container(
      padding: EdgeInsets.symmetric(vertical: appBarHeight * 0.08),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Stack(alignment: AlignmentDirectional.center, children: [
          LinearProgressIndicator(
            value: loadingValues[0],
            color: playerColors[index],
            minHeight: appBarHeight * 0.66,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: appBarHeight * 0.2),
                  child: Obx(() => Text(gc.game.playerList[index].name))
              ),
              Obx(()  => Visibility(
                child: const Icon(Icons.star_rate_rounded),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: (gc.game.playerList[index].id == gc.game.ownerID.value) ? true : false,
              )),
            ],
          ),
        ]),
      ),
    );
  }
}
