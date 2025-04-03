import 'package:flutter/material.dart';
import 'package:nafsia_app/core/utils/app_images.dart';

class CustomPostImage extends StatelessWidget {
  const CustomPostImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        Assets.assetsImagesPostTestImage,
        width: MediaQuery.sizeOf(context).width * 0.9,
        fit: BoxFit.fill,
        height: MediaQuery.sizeOf(context).height * 0.3,
      ),
    );
  }
}
