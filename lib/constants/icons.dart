import 'package:flutter/material.dart';
import 'package:rush/constants/colors.dart';

const personIcon = 0xe491;
const workIcon = 0xe11c;
const animeIcon = 0xe40f;
const sportsIcon = 0xe4dc;
const travelIcon = 0xe071;
const shopIcon = 0xe59c;

List<Icon> getIcons() {
  return const [
    Icon(IconData(personIcon, fontFamily: "MaterialIcons"), color: purple),
    Icon(IconData(workIcon, fontFamily: "MaterialIcons"), color: pink),
    Icon(IconData(animeIcon, fontFamily: "MaterialIcons"), color: Green),
    Icon(
      IconData(sportsIcon, fontFamily: "MaterialIcons"),
      color: yellow,
    ),
    Icon(
      IconData(travelIcon, fontFamily: "MaterialIcons"),
      color: deepPink,
    ),
    Icon(
      IconData(shopIcon, fontFamily: "MaterialIcons"),
      color: Blue,
    ),
  ];
}
