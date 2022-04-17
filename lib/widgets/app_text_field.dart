import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:have_you_heard/constants/colors.dart';

import '../constants/styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.textEditingController,
    required this.labelText,
    this.autofocus = true,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String labelText;
  final bool autofocus;
  final TextInputType keyboardType ;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus,
      controller: textEditingController,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      cursorColor: kGrayScaleLightest,
      decoration: InputDecoration(
        filled: true,
        fillColor: kGrayScaleDarkest,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kTextFieldBorderColor, width: 2.0),
        ),
        labelText: labelText,
        labelStyle: HyhTextStyle.body16MediumLight,
        hintStyle: HyhTextStyle.body16MediumLight,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kTextFieldBorderColor, width: 2.0),
        ),
      ),
      style: HyhTextStyle.body16MediumLight
    );
  }
}