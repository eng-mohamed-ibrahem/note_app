import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoveWidget extends StatelessWidget {
  final double size;
  const LoveWidget({super.key, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          FontAwesomeIcons.solidHeart,
          color: const Color.fromRGBO(203, 23, 23, 1),
          size: size,
          shadows: const [
            BoxShadow(
              color: Color.fromRGBO(139, 148, 158, 1),
            ),
            BoxShadow(
              color: Color.fromRGBO(193, 198, 203, 1),
            )
          ],
        ),
      ),
    );
  }
}
