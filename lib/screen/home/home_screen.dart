import 'package:flutter/material.dart';
import 'package:voice_assistant_app/common/font.dart';
import 'package:voice_assistant_app/common/pallete.dart';
import 'package:voice_assistant_app/screen/home/components/assistant_image.dart';
import 'package:voice_assistant_app/screen/home/components/feature_box.dart';

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
                color: Pallete.thirdSuggestionBoxColor,
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
