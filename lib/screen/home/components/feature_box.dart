import 'package:flutter/cupertino.dart';
import 'package:voice_assistant_app/common/font.dart';
import 'package:voice_assistant_app/common/pallete.dart';

class FeatureBox extends StatelessWidget {
  const FeatureBox(
      {super.key,
      required this.color,
      required this.headerText,
      required this.descriptionText});

  final Color color;
  final String headerText;
  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        // padding: const EdgeInsets.only(top: 20.0, left: 15, bottom: 20.0),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ).copyWith(left: 15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: TextStyle(
                  fontFamily: FONT_NAME,
                  color: Pallete.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                descriptionText,
                style: TextStyle(
                  fontFamily: FONT_NAME,
                  color: Pallete.blackColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
