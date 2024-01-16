import 'package:flutter/material.dart';
import 'package:recap_qizzler/pages/alert_dialog.dart';
import 'package:recap_qizzler/pages/quiz_brain.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // list and int: score keepers
  List<Widget> scoreKeeper = [];
  int scoreSheet = 0;

  // class: questions and answers
  QuizBrain quizBrain = QuizBrain();

  // widget: check icon
  Widget checkIcon() {
    return Icon(
      Icons.check_circle_outline,
      color: Colors.green[900],
    );
  }

  // widget: wrong icon
  Widget wrongIcon() {
    return Icon(
      Icons.cancel_outlined,
      color: Colors.red[900],
    );
  }

  // methood: check user answer
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getAnswer();
    setState(
      () {
        if (correctAnswer == userPickedAnswer) {
          scoreKeeper.add(checkIcon());
          scoreSheet++;
        } else {
          scoreKeeper.add(wrongIcon());
        }
        quizBrain.nextQuestion();
      },
    );
  }

  // method: showing dialog box and restart the game
  void restartQuiz() {
    if (scoreKeeper.length == quizBrain.totalQuestions()) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogBox(
              quizResult: 'Congratulations! You got $scoreSheet points!',
              onPressed: () {
                setState(() {
                  scoreSheet = 0;
                  Navigator.of(context).pop();
                  scoreKeeper.clear();
                });
              },
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // score board
              const SizedBox(
                height: 12,
              ),
              Text(
                'Your Score: $scoreSheet',
                textAlign: TextAlign.center,
              ),

              // Questions
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      quizBrain.getQuestionText(),
                      style: const TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              // Elevated button "True"
              Padding(
                padding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 60.0),
                child: ElevatedButton(
                  onPressed: () {
                    checkAnswer(true);
                    restartQuiz();
                  },
                  child: Text(
                    'True',
                    style: TextStyle(color: Colors.green[900]),
                  ),
                ),
              ),

              // Elevated button "False"
              Padding(
                padding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 60.0),
                child: ElevatedButton(
                  onPressed: () {
                    checkAnswer(false);
                    restartQuiz();
                  },
                  child: Text(
                    'False',
                    style: TextStyle(color: Colors.red[900]),
                  ),
                ),
              ),

              // Clear score
              Padding(
                padding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 60.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DialogBox(
                              quizResult: 'Not confident enough?',
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context).pop();
                                  scoreSheet = 0;
                                  scoreKeeper.clear();
                                  quizBrain.restartQuestion();
                                });
                              },
                            );
                          });
                    });
                  },
                  child: const Text(
                    'Restart',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),

              // This is the score keeper space
              SizedBox(
                height: 25.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: scoreKeeper,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
