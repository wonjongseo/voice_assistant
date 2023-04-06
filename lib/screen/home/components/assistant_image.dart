import 'package:flutter/cupertino.dart';
import 'package:voice_assistant_app/common/pallete.dart';

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
