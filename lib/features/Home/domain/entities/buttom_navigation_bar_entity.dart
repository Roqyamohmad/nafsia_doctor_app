import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_images.dart' show Assets;

class ButtonNavigationBarEntity {
  final String activeImage, inActiveImage;
  final String Function(BuildContext)
      name; // Change to function returning a localized string

  ButtonNavigationBarEntity({
    required this.activeImage,
    required this.inActiveImage,
    required this.name,
  });
}

List<ButtonNavigationBarEntity> buttonNavigationBarEntityList = [
  ButtonNavigationBarEntity(
    name: (context) => 'الرئيسية', // Use localized text
    activeImage: Assets.assetsImagesHomeActive,
    inActiveImage: Assets.assetsImagesHomeInactive,
  ),
  ButtonNavigationBarEntity(
    name: (context) => 'المحادثات',
    activeImage: Assets.assetsImagesChatsActive,
    inActiveImage: Assets.assetsImagesChatsInactive,
  ),
  ButtonNavigationBarEntity(
    name: (context) => 'ميعاد',
    activeImage: Assets.assetsImagesCalendarActive,
    inActiveImage: Assets.assetsImagesCalendarInactive,
  ),
  ButtonNavigationBarEntity(
    name: (context) => 'الملف الشخصي',
    activeImage: Assets.assetsImagesUserActive,
    inActiveImage: Assets.assetsImagesUserInactive,
  ),
];
