import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/constants/styles.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/controller/setting_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const routeName = '/settings';
  static const route = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool hasFocus = false;

  @override
  Widget build(BuildContext context) {
    final GameController gc = Get.find();

    final myController = TextEditingController();
    if(hasFocus==false){
      myController.text = gc.myPlayer.name;
    }

    @override
    void initState() {
      super.initState();
    }

    @override
    void dispose() {
      myController.dispose();
      super.dispose();
    }

    final appBar = AppBar(
      backgroundColor: kGrayScaleDarkest,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        'settings'.tr,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close_rounded))
      ],
    );

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 1),
              Container(
                height: 36,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'name'.tr,
                      style: kSettingsTextW700
                    ),
                    Expanded(
                      child: Focus(
                        onFocusChange: (focus){
                          hasFocus = focus;
                          if(hasFocus==true){
                            myController.clear();
                          } else {
                            myController.text=gc.myPlayer.name;
                          }},
                        child: TextField(
                          style: kSettingsTextW400,
                          textAlign: TextAlign.right,
                          controller: myController,
                          cursorColor: kGrayScaleLightest,
                          textInputAction: TextInputAction.done,
                          onTap: (){
                            myController.clear();
                          },
                          onSubmitted: (playerName) async {
                            gc.setPlayerName(playerName);
                            gc.saveUser(playerName);
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 12),
                            border: InputBorder.none,
                            hintStyle: kSettingsTextW400
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
                color: kGrayScaleDark,
              ),
              Container(
                height: 36,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('sound'.tr, style: kSettingsTextW700),
                    GestureDetector(
                      onTap: (){}, //TODO: implement onTap
                      child: SvgPicture.asset('assets/images/sound.svg'),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
                color: kGrayScaleDark,
              ),
              Container(
                height: 36,
                padding: EdgeInsets.symmetric(
                    vertical: 0.0, horizontal: screenWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'country'.tr,
                      style: kSettingsTextW700,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await setGameLanguage(gc, 'es');
                          },
                          child: SvgPicture.asset(
                            'assets/images/flagArgentina.svg',
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await setGameLanguage(gc, 'pt');
                          },
                          child: SvgPicture.asset(
                            'assets/images/flagBrazil.svg',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
                color: kGrayScaleDark,
              ),
              Container(
                height: 36,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(
                    vertical: 0.0, horizontal: screenWidth * 0.05),
                child: GestureDetector(
                  onTap: (){}, //TODO: implement onTap
                  child: Text(
                    'rules'.tr,
                    style: kSettingsTextW700,
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
                color: kGrayScaleDark,
              ),
              Container(
                height: 36,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(
                    vertical: 0.0, horizontal: screenWidth * 0.05),
                child: GestureDetector(
                  onTap: (){}, //TODO: implement onTap
                  child: Text(
                    'exitGame'.tr,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.red),
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
                color: kGrayScaleDark,
              ),
              //TODO: Remove ElevatedButton after tests
              ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('username');
                    await prefs.remove('locale');
                    const snackBar =
                        SnackBar(content: Text('Configurações excluídas'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text('Limpar configurações')),
              const Spacer(flex: 4)
            ],
          ),
        ),
      ),
    );
  }
}
