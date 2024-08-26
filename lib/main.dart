import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Center(
            child: Text(
              'Quizzler App',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Center(
            child: QuizApp(),
          ),
        ),
      ),
    ),
  );
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Widget> scoreKeeper = [];

  List<bool> answers = [false, true, true, false, true, false];

  int questionNumber = 0;

  bool gameOver = false;

  List<String> questions = [
    'The human body has four lungs.',
    'Seeds grow into plants.',
    'Is grass green?',
    'Ice is hot.',
    'The sky is blue.',
    'Elephants can fly.'
  ];

  void checkUserAnswers(bool btnType) {
    bool questionAnswer = answers[questionNumber];

    setState(() {
      if (btnType == questionAnswer) {
        scoreKeeper.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreKeeper.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }

      questionNumber++;

      if (questionNumber >= questions.length) {
        gameOver = true;
      }
    });
  }

  Expanded answerBtns(Color btnColor, String btnText, bool btnType) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextButton(
          style: TextButton.styleFrom(backgroundColor: btnColor),
          child: Text(
            btnText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            checkUserAnswers(btnType);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              gameOver ? 'Game Over' : questions[questionNumber],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
        gameOver
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    setState(() {
                      scoreKeeper.clear();
                      questionNumber = 0;
                      gameOver = false;
                    });
                  },
                  child: const Text(
                    'Start over',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              )
            : Row(
                children: [
                  answerBtns(Colors.green, 'True', true),
                  answerBtns(Colors.red, 'False', false),
                ],
              ),
        const SizedBox(
          height: 40.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: scoreKeeper,
        ),
      ],
    );
  }
}
