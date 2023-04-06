import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:voice_assistant_app/common/font.dart';
import 'package:voice_assistant_app/common/pallete.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Allen'),
        centerTitle: true,
        leading: const Icon(Icons.menu),
      ),
      body: Column(
        children: [
          const AssistantImage(),
          //chat bubble
          Container(
            margin: const EdgeInsets.only(left: 40, right: 40, top: 30),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Pallete.borderColor),
              borderRadius: BorderRadius.circular(20).copyWith(
                topLeft: Radius.zero,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Good Morning, What task can I do for you ?',
                style: TextStyle(
                  color: Pallete.mainFontColor,
                  fontSize: 24,
                  fontFamily: FONT_NAME,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 10, left: 22),
            alignment: Alignment.centerLeft,
            child: Text(
              'Here are a few features',
              style: TextStyle(
                fontFamily: FONT_NAME,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: const [
              FeatureBox(
                color: Pallete.firstSuggestionBoxColor,
                headerText: 'Chat GPT',
                descriptionText:
                    'A smarter way to stay organized and informed with ChatGPT',
              ),
              FeatureBox(
                color: Pallete.secondSuggestionBoxColor,
                headerText: 'Dall-E',
                descriptionText:
                    'Get inspired and stay creative with your personal assistant powered by Dall-E',
              ),
              FeatureBox(
                color: Pallete.firstSuggestionBoxColor,
                headerText: 'Smart Voice Assistant',
                descriptionText:
                    'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
              )
            ],
          )
        ],
      ),
    );
  }
}

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

class AssistantImage extends StatelessWidget {
  const AssistantImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: 120,
            width: 120,
            margin: const EdgeInsets.only(top: 4),
            decoration: const BoxDecoration(
                color: Pallete.assistantCircleColor, shape: BoxShape.circle),
          ),
        ),
        Container(
          height: 123,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/virtualAssistant.png'),
            ),
          ),
        )
      ],
    );
  }
}
