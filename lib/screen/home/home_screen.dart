import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_assistant_app/common/font.dart';
import 'package:voice_assistant_app/common/pallete.dart';
import 'package:voice_assistant_app/open_ai_service.dart';
import 'package:voice_assistant_app/screen/home/components/assistant_image.dart';
import 'package:voice_assistant_app/screen/home/components/feature_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final speechToText = SpeechToText();
  final textToSpeech = FlutterTts();
  final OpenAIService openAIService = OpenAIService();
  String lastWords = '';
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    // await textToSpeech.setSharedInstance(true);
    setState(() {});
  }

  Future<void> systemSpeak(String content) async {
    await textToSpeech.speak(content);
  }

  Future<void> initSpeechToText() async {
    print('initSpeechToText');
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    print('startListening');
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    print('stopListening');
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    print('onSpeechResult');
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> onMicPress() async {
    if (await speechToText.hasPermission && speechToText.isNotListening) {
      await startListening();
    } else if (speechToText.isListening) {
      final speech = await openAIService.isArtPromptApi(lastWords);
      await stopListening();
    } else {
      await initSpeechToText();
    }
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    textToSpeech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BounceInDown(child: const Text('Allen')),
        centerTitle: true,
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AssistantImage(),
            //chat bubble
            FadeInRightBig(
              child: Visibility(
                visible: generatedImageUrl == null,
                child: Container(
                  margin: const EdgeInsets.only(left: 40, right: 40, top: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Pallete.borderColor),
                    borderRadius: BorderRadius.circular(20).copyWith(
                      topLeft: Radius.zero,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      generatedContent == null
                          ? 'Good Morning, What task can I do for you ?'
                          : generatedContent!,
                      style: TextStyle(
                        color: Pallete.mainFontColor,
                        fontSize: generatedContent == null ? 25 : 18,
                        fontFamily: FONT_NAME,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (generatedImageUrl != null)
              Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(generatedImageUrl!)),
              ),
            SlideInLeft(
              child: Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Container(
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
              ),
            ),
            Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: Column(
                children: [
                  SlideInLeft(
                    delay: Duration(microseconds: start),
                    child: const FeatureBox(
                      color: Pallete.firstSuggestionBoxColor,
                      headerText: 'Chat GPT',
                      descriptionText:
                          'A smarter way to stay organized and informed with ChatGPT',
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(microseconds: start + delay),
                    child: const FeatureBox(
                      color: Pallete.secondSuggestionBoxColor,
                      headerText: 'Dall-E',
                      descriptionText:
                          'Get inspired and stay creative with your personal assistant powered by Dall-E',
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(microseconds: start + delay * 2),
                    child: const FeatureBox(
                      color: Pallete.thirdSuggestionBoxColor,
                      headerText: 'Smart Voice Assistant',
                      descriptionText:
                          'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: ZoomIn(
        delay: Duration(microseconds: start + delay * 3),
        child: FloatingActionButton(
          backgroundColor: Pallete.firstSuggestionBoxColor,
          onPressed: () async {
            final speech = await openAIService
                .isArtPromptApi('Please create a unicorn image for me ');

            // final speech = await openAIService
            //     .isArtPromptApi('explan Quantum Computing to me');
            print('speech: ${speech}');
            if (speech.contains('http')) {
              generatedImageUrl = speech;
              generatedContent = null;
              setState(() {});
            } else {
              generatedContent = speech;
              generatedImageUrl = null;
              setState(() {});
              // await systemSpeak(speech);
            }

            // onMicPress();
          },
          child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
        ),
      ),
    );
  }
}
// 
