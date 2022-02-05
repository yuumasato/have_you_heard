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
import 'package:have_you_heard/widgets/in_game_app_bar.dart';

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
          appBar: InGameAppBar(
            onLeavePressed: () => ExitGameAlert(context, () => Navigator.of(context).pop(), () => gc.exitGame())
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
                      Obx(() => Opacity(
                          opacity: (gc.room.ownerID.value == gc.myPlayer.id) ? 1.0 : 0.4,
                          child: AppButton(
                            color: kPink,
                            textColor: kGrayScaleLightest,
                            onPressed: (gc.room.ownerID.value == gc.myPlayer.id && gc.room.nUsers.value >= 3) ? () {
                              gc.startGame();
                            } : null,
                            text: 'startGame'.tr,
                            ),
                        ),
                      ),
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
    return Obx(() => TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.015, end: gc.room.userList[index].barValue),
        curve: Curves.easeOutQuint,
        duration: const Duration(seconds: 1),
        builder: (BuildContext context, double barValue, Widget? child) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: appBarHeight * 0.08),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Stack(alignment: AlignmentDirectional.center, children: [
                LinearProgressIndicator(
                  value:barValue,
                  color: playerColors[index],
                  minHeight: appBarHeight * 0.66,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: appBarHeight * 0.2),
                        child: Obx (() => Text(gc.room.userList[index].name))
                    ),
                    Visibility(
                      child: const Icon(Icons.star_rate_rounded),
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: (gc.room.userList[index].id == gc.room.ownerID.value) ? true : false,
                    ),
                  ],
                ),
              ]),
            ),
          );
        }
    ));
  }
}
