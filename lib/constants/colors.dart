import 'package:flutter/material.dart';

// Color AppColor{
// const Color kYellowLight = Color(0xFFFFF7EC);
// const Color kYellow = Color(0xFFFAF0DA);
// const Color kYellowDark = Color(0xFFEBBB7F);

// const Color kRedLight = Color(0xFFFCF0F0);
// const Color kRed = Color(0xFFFBE4E6);
// const Color kRedDark = Color(0xFFF08A8E);

// const Color kBlueLight = Color(0xFFEDF4FE);
// const Color kBlue = Color(0xFFE1EDFC);
// const Color kBlueDark = Color(0xFFC0D3F8);

// const Color kGreenLight = Color(0xFFA0D995);
// const Color kGreen = Color(0xFF6CC4A1);
// const Color kGreenDark = Color(0xFF4CACBC);

// const Color kPurpleLight = Color(0xFFE9D5DA);
// const Color kPurple = Color(0xFFA68DAD);
// const Color kPurpleDark = Color(0xFF827397);

// const Color kShopLight = Color(0xFFFCF8E8);
// const Color kShop = Color(0xFFCEE5D0);
// const Color kShopDark = Color(0xFF94B49F);

const purple = Color(0xFF756BFC);
const pink = Color(0xFFF1A39A);
const deepPink = Color(0xFFFA63C6);
const Green = Color(0xFF41CF9F);
const yellow = Color(0xFFEEC38E);
const lightBlue = Color(0xFF42A5F5);
const Blue = Color(0xFF2B60E6);

// }
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
