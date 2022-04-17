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
  static const body14 = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: kGrayScaleLightest, fontFamily: 'Nunito');
  static const body14Bold = TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: kGrayScaleLightest,fontFamily: 'Nunito');
  static const body16 = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kGrayScaleLightest, fontFamily: 'Nunito');
  static const body32 = TextStyle(fontSize: 32, fontWeight: FontWeight.w400, color: kGrayScaleLightest, fontFamily: 'Nunito');
  static const body16Height15 = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kGrayScaleLightest, height: 1.5, fontFamily: 'Nunito');
  static const body16Bold = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kGrayScaleLightest, fontFamily: 'Nunito');
  static const body16Height15Bold = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kGrayScaleLightest, height: 1.5, fontFamily: 'Nunito');
  static const body40Bold = TextStyle(fontSize: 40, fontWeight: FontWeight.w700, color: kGrayScaleLightest, fontFamily: 'Nunito');
  static const heading18Bold = TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kGrayScaleLightest, fontFamily: 'Nunito');
  static const heading24Bold = TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: kGrayScaleLightest, fontFamily: 'Nunito');
  static const heading32Bold = TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: kGrayScaleLightest, fontFamily: 'Nunito');

  //Grayscale Light styles
  static const heading32BoldLightGray = TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: kGrayScaleLight, fontFamily: 'Nunito');

  //Grayscale Medium Light styles
  static const body16MediumLight = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kGrayScaleMediumLight, fontFamily: 'Nunito');

  //Grayscale MediumDark styles
  static const body16BoldMediumDark = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kGrayScaleMediumDark, fontFamily: 'Nunito');

  //Grayscale Darkest styles
  static const body14Darkest = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: kGrayScaleDarkest, fontFamily: 'Nunito');
  static const body14Height15Darkest = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: kGrayScaleDarkest, height: 1.5, fontFamily: 'Nunito');
  static const body16Darkest = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kGrayScaleDarkest, fontFamily: 'Nunito');
  static const body16BoldDarkest = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kGrayScaleDarkest, fontFamily: 'Nunito');
  static const body16Height15BoldDarkest = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kGrayScaleDarkest, height: 1.5, fontFamily: 'Nunito');
  static const heading18BoldDarkest = TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kGrayScaleDarkest, fontFamily: 'Nunito');
  static const heading24BoldDarkest = TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: kGrayScaleDarkest, fontFamily: 'Nunito');
  static const heading24Height15BoldDarkest = TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: kGrayScaleDarkest, height: 1.5, fontFamily: 'Nunito');


  //Yellow styles (BrandColor)
  static const body16BoldYellow = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kYellow, fontFamily: 'Nunito');
  static const heading20BoldYellow = TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: kYellow, fontFamily: 'Nunito');
  static const heading24BoldYellow = TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: kYellow, fontFamily: 'Nunito');
  static const heading32BoldYellow = TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: kYellow, fontFamily: 'Nunito');

  //Orange styles (BrandColor/Danger)
  static const body16BoldOrange = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kOrange, fontFamily: 'Nunito');
}

