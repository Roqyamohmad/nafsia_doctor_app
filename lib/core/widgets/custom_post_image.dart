import 'package:flutter/material.dart';
import 'custom_cached_network_image.dart';

class CustomPostImage extends StatelessWidget {
  final String imagePath;
  const CustomPostImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CustomCachedNetworkImageWidget(
        imageUrl: imagePath,
        borderRadius: 8,
        width: MediaQuery.sizeOf(context).width * 0.9,
        fit: BoxFit.fill,
        height: MediaQuery.sizeOf(context).height * 0.3,
      ),
    );
  }
}
