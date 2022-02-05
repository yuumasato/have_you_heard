import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/widgets/app_button.dart';
import 'package:have_you_heard/widgets/app_text_field.dart';
import 'package:have_you_heard/widgets/gray_stripe.dart';

import 'lobby.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({Key? key}) : super(key: key);

  static const routeName = '/get-user-name';
  static const route = '/get-user-name';

  @override
  _UserNameScreenState createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GameController gc = Get.find();
    final screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Svg("assets/images/full_landscape.svg",
                  size: Size(screenWidth, screenWidth * 0.486)),
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GrayStripe(text: 'chooseYourName'.tr),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.1,
                    right: screenWidth * 0.1,
                    top: appBarHeight * 0.8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: appBarHeight * 0.2),
                      child: Text('nameQuestion'.tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: kGrayScaleLight, fontSize: 18)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: appBarHeight * 0.8,
                          width: screenWidth * 0.56,
                          child: AppTextField(
                            textEditingController: myController,
                            labelText: 'insertYourName'.tr,
                          ),
                        ),
                        SizedBox(
                          height: appBarHeight * 0.8,
                          width: screenWidth * 0.22,
                          child: AppButton(
                              onPressed: () async {
                                String playerName = myController.text;
                                gc.setPlayerName(playerName);
                                gc.setLocale(gc.language);
                                gc.saveUser(playerName);
                                Get.toNamed(LobbyScreen.route);
                              },
                              text: 'enter'.tr),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
