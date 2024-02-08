import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';

class FavouritePlaceIcon extends StatelessWidget {
  const FavouritePlaceIcon({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              offset: Offset(0,4),
            ),
          ],
        ),
        child:const Center(child:  Icon(Icons.favorite_outline_rounded,color: secondaryColor,))
    );
  }
}