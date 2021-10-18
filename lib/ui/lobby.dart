import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';

import 'package:have_you_heard/ui/settings.dart';
import 'package:have_you_heard/widgets/app_button.dart';
import 'package:have_you_heard/widgets/gray_stripe.dart';
import 'package:have_you_heard/widgets/icon_app_button.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({Key? key}) : super(key: key);

  static const routeName = '/lobby';
  static const route = '/lobby';

  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
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

    return WillPopScope(
      onWillPop: () async {
        await showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text('Sair do jogo?'),
                  actions: [
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Continuar jogando')),
                    TextButton(
                        onPressed: () =>SystemNavigator.pop(),
                        child: const Text('Fechar'))
                  ],
                ));
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(automaticallyImplyLeading: false, actions: [
          IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                Get.toNamed(SettingsScreen.route);
              }),
        ]),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: Svg("assets/images/full_landscape.svg",
                    size: Size(375, 182)),
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GrayStripe(
                    text: 'Escolha seu modo de jogo, ${gc.myPlayer.name}!'),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: appBarHeight * 0.8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: appBarHeight * 0.75,
                            width: screenWidth * 0.6,
                            child: TextField(
                              controller: myController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                labelText: 'Insira o código da sala',
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                                hintStyle: TextStyle(color: Colors.white),
                                focusColor: Colors.red,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                              ),
                              style: const TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                          AppButton(
                              onPressed: () {
                                gc.roomID = myController.text;
                                gc.joinRoom(gc.roomID);
                              },
                              text: 'entrar'.tr),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: appBarHeight * 0.2),
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            SizedBox(
                              width: 50,
                              child: Divider(
                                color: kGrayScaleMediumDark,
                                thickness: 2,
                              ),
                            ),
                            Text(
                              'ou',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            SizedBox(
                              width: 50,
                              child: Divider(
                                color: kGrayScaleMediumDark,
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconAppButton(
                          onPressed: () {
                            // Requisitar ao servidor criação de nova sala
                            gc.createRoom();
                          },
                          text: 'criarSala'.tr),
                    ],
                  ),
                ),
                Visibility(
                  visible: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: appBarHeight * 0.4),
                        child: const Divider(
                          color: kGrayScaleMediumDark,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                        child: IconAppButton(
                          onPressed: () {},
                          text: 'Voltar para partida',
                          color: kPink,
                          textColor: kGrayScaleLightest,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
