import 'package:flutter/material.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/router/parser.dart';
import 'package:get/get.dart';

import 'constants/locale_string.dart';

void main() {
  runApp(const Hyh());
}

class Hyh extends StatelessWidget {
  const Hyh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kGrayScaleDarkest,
          colorScheme: const ColorScheme.dark(
            primary: kYellow,
            surface: kGrayScaleDarkest,
          )),
      translations: LocalString(),
      locale: Locale('pt', 'BR'),
      initialRoute: '/splash',
      initialBinding: BindingsBuilder(getHyhBindings),
      getPages: getHyhRoutes(),
    );
  }
}
