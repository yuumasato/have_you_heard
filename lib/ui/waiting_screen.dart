import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:get/get.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/controller/game_controller.dart';
import 'package:have_you_heard/widgets/game_exit_dialog.dart';
import 'package:have_you_heard/widgets/gray_stripe.dart';
import 'package:have_you_heard/widgets/in_game_app_bar.dart';


class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  static const routeName = '/waiting-screen';
  static const route = '/waiting-screen';

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1, 0.0),
    end: const Offset(-1, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));
  late final Animation<Offset> _carEntrance = Tween<Offset>(
    begin: const Offset(-1, 0.0),
    end: const Offset(4.2, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // Multiplication factor to match the landscape's width to screen width
    final double svgFactor = screenWidth/375;
    final GameController gc = Get.find();
    final String titleFlag = Get.parameters['titleFlag'] ?? 'false';
    final bannerText = Get.parameters['bannerText'] ?? 'No banner';

    return GameExitDialog(
      onElevatedPressed: () => Navigator.of(context).pop(),
      onPlainPressed: () => gc.exitGame(),
      child: Scaffold(
        appBar: InGameAppBar(
            title:  titleFlag == 'true' ? (
                'Rodada ${gc.game.roundIndex + 1}/3') : "",
            textColor: kYellow,
            fontWeight: FontWeight.w700,
            onLeavePressed: () => ExitGameAlert(context, () => Navigator.of(context).pop(), () => gc.exitGame())
        ),
        body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    GrayStripe(text: bannerText),
                  ],
                ),
                Stack(
                    children: [
                      SizedBox(
                        height: 182*svgFactor*2,
                        child: SlideTransition(
                            position: _offsetAnimation,
                            child: OverflowBox(
                              maxWidth: 375*svgFactor*2*3,
                              child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: svg_provider.Svg("assets/images/full_landscape.svg",
                                            size: Size(375*svgFactor*2, 182*svgFactor*2)),
                                        fit: BoxFit.none,
                                        repeat: ImageRepeat.repeatX),
                                  )
                              ),
                            ) //OverflowBox parenthesis
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: SlideTransition(
                          position: _carEntrance,
                          child: Container(
                              height: 82,
                              width: 120,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: svg_provider.Svg("assets/images/car_sideview.svg",
                                        size: Size(628, 417)),
                                    fit: BoxFit.fitWidth),
                              )
                          ),
                        ),
                      ),
                    ]),
              ]),
        ),
      ),
    );
  }
}
