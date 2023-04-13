import 'package:flutter/material.dart';

const Color accentColor = Color(0xFFED278D);
const Color yellowColor = Color(0xFFFFBF18);
const Color green = Color(0xFF00AE9F);
const Color profile = Color(0xFF5E2D77);

const Color primaryColor = Color(0xFFd7dae0);
const Color orange = Color(0xFFF15E31);

const Color samaColor = Color(0xFF1D405C);
const Color saraBorder = Color(0xFF000000);


const Color darkIndigo = Color(0xFF0E1740);
const Color textColor = Color(0xFF0E1740);
const Color textGrayColor = Color(0xFF7A8FA6);
const Color grayColor = Color(0xFFE6E6E6);
const Color textError = Color(0xFFE00000);

const kTextColor = Color(0xFF22292E);

const Color backgroundColor = Color(0xFF21252b);
const Color backgroundDarkColor = Color(0xFF21252b);
const Color cardColor = Color(0xFF2b2d34);

const Color backgroundGradient1 = Color(0xFF202025);
const Color backgroundGradient2 = Color(0xFF393838);
const Color backgroundGradient3 = Color(0xFF202025);

const Color disabledTextColor = Color(0xFFa1a1a1);
const Color disabledColor = Colors.black38;

const Color canvasColor = Colors.transparent;
const Color snackbarBackgroundColor = Colors.black38;
const Color toastBackgroundColor = Colors.black38;
const Color toastTextColor = Colors.white;

const Color darkBlue = Color(0xFF0e1740);
const Color opacityDarkBlue = Color(0x1A0e1740);

const Color errColor = Color(0xFFD92059);
const Color pickIconColor = Color(0xFFff0d93);
const Color opacityPickIconColor = Color(0x1Aff0d93);

const Color greenBlueIconColor = Color(0xFF01AE9F);
const Color opacityGreenBlueIconColor = Color(0x1A01AE9F);

const Color helpIconColor = Color(0xFF5E2D77);
const Color opacityHelpIconColor = Color(0x1A5E2D77);

const Color addressColor = Color(0xFFFFB116);
const Color opacityAddressColor = Color(0x1AFFB116);

class AppColors {
  static const red = Color(0xFFDB3022);
  static const black = Color(0xFF222222);
  static const lightGray = Color(0xFF9B9B9B);
  static const darkGray = Color(0xFF979797);
  static const white = Color(0xFFFFFFFF);
  static const orange = Color(0xFFFFBA49);
  static const background = Color(0xFFE5E5E5);
  static const backgroundLight = Color(0xFFF9F9F9);
  static const transparent = Color(0x00000000);
  static const success = Color(0xFF2AA952);
  static const green = Color(0xFF2AA952);
}

// final Color darkBlue = HexColorExte.fromHex("#0e1740") ;
// final Color opacityDarkBlue = HexColorExte.fromHex("#1A0e1740") ;
final Color darkPink = HexColorExte.fromHex("#ff0d93");
final Color darkyellow = HexColorExte.fromHex("#fcb116");
final Color orangyRed = HexColorExte.fromHex("#ff5d23");
final Color whiteColor = HexColorExte.fromHex("#ffffff");
final Color korangeYellow = HexColorExte.fromHex("#ffac00");
final Color klightGray = HexColorExte.fromHex("#F2F3F5");
final Color productBg = HexColorExte.fromHex("#0A0e1740");
final Color grayBN = HexColorExte.fromHex("#CEBECE");
final Color cartColor = HexColorExte.fromHex("#00AE9F");
final Color dimmedColor = HexColorExte.fromHex("#e4e4e4");
final Color helpColor = HexColorExte.fromHex("#00e1bc");

final Color greyshColor = HexColorExte.fromHex("#b1b1b1");
final Color white_faint = HexColorExte.fromHex("#f8f8f8");
final Color green_Color = HexColorExte.fromHex("#00ae9f");

final Color lipStick = HexColorExte.fromHex("#D92059");
final Color opacityLipStick = HexColorExte.fromHex("#1AD92059");
final Color orangeNav = HexColorExte.fromHex("#F15E31");
final Color inactiveNav = HexColorExte.fromHex("#e4e4e4");
final Color searchBarView = HexColorExte.fromHex("#f7f7f9");
final Color announcmentView = HexColorExte.fromHex("#0AD92059");
final Color arrowNav = HexColorExte.fromHex("#d92059");
final Color unSelectedCategory = HexColorExte.fromHex("#8e8e93");
final Color unSelectedNav = HexColorExte.fromHex("#D3D3D3");

extension HexColorExte on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
