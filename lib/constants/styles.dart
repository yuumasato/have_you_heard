import 'package:flutter/material.dart';

import 'colors.dart';

const kRoomNumberStyle = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kElevatedButtonTextStyle =
    TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

const kSettingsTextW700 = TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

const kSettingsTextW400 = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w400, color: kGrayScaleLightest,);

class HyhTextStyle {

  //Grayscale Lightest styles
  static const body14 = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: kGrayScaleLightest);
  static const body14Bold = TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: kGrayScaleLightest);
  static const body16 = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kGrayScaleLightest);
  static const body16Bold = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kGrayScaleLightest);
  static const heading18 = TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kGrayScaleLightest);
  static const heading32 = TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: kGrayScaleLightest);

  //Grayscale Light styles
  static const heading32Light = TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: kGrayScaleLight);

  //Grayscale MediumDark styles
  static const body16BoldMediumDark = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kGrayScaleMediumDark);

  //Grayscale Darkest styles
  static const body14Darkest = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: kGrayScaleDarkest);
  static const body16Darkest = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kGrayScaleDarkest);
  static const body16BoldDarkest = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kGrayScaleDarkest);
  static const heading18Darkest = TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kGrayScaleDarkest);

  //Yellow styles (BrandColor)
  static const body16BoldYellow = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kYellow);
  static const heading20Yellow = TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: kYellow);
  static const heading24Yellow = TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: kYellow);
  static const heading32Yellow = TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: kYellow);

  //Orange styles (BrandColor/Danger)
  static const body16BoldOrange = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kOrange);
}

