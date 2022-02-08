import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/router/parser.dart';
import 'package:get/get.dart';

import 'constants/locale_string.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //it's needed to set preferredOrientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    runApp(const Hyh());
  });
}

class Hyh extends StatelessWidget {
  const Hyh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark().copyWith(
          textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Nunito',),
          scaffoldBackgroundColor: kGrayScaleDarkest,
          colorScheme: const ColorScheme.dark(
            primary: kYellow,
            surface: kGrayScaleDarkest,
            background : kGrayScaleDark,
            onPrimary : kGrayScaleDarkest,
            onSurface : kGrayScaleLightest,
          )),
      translations: LocalString(),
      locale: Locale('pt', 'BR'),
      initialRoute: '/splash',
      initialBinding: BindingsBuilder(getHyhBindings),
      getPages: getHyhRoutes(),
    );
  }
}
