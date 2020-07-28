import 'package:flutter/material.dart';

import 'QuizzManager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizzlerApp(title: 'Quizzler'),
    );
  }
}

class QuizzlerApp extends StatefulWidget {
  QuizzlerApp({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  _QuizzlerAppState createState() => _QuizzlerAppState();
}

class _QuizzlerAppState extends State<QuizzlerApp> {
  List<IconWidget> iconsList = [];

  QuizzManager quizzManager = QuizzManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    quizzManager.getQuestionText(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FlatButton(
                  color: Colors.green,
                  child: Text(
                    'YES',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      checkIfAnswerifCorrect(true);
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FlatButton(
                  color: Colors.red,
                  child: Text(
                    'NO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      checkIfAnswerifCorrect(false);
                    });
                  },
                ),
              ),
            ),
            Row(
              children: iconsList,
            )
          ],
        ),
      ),
    );
  }

  void checkIfAnswerifCorrect(bool answerValidation) {
    if (quizzManager.getAnswerValue() == answerValidation) {
      iconsList.add(IconWidget(
        isCheckWidget: true,
      ));
    } else {
      iconsList.add(IconWidget(
        isCheckWidget: false,
      ));
    }
    quizzManager.nextQuestion();
    if (quizzManager.resetIconProgress()) {
      iconsList.clear();
    }
  }
}

class IconWidget extends StatelessWidget {
  bool isCheckWidget;

  IconWidget({
    this.isCheckWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (this.isCheckWidget) {
      return Icon(
        Icons.check,
        color: Colors.green,
      );
    } else {
      return Icon(
        Icons.cancel,
        color: Colors.red,
      );
    }
  }
}
