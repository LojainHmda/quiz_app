import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0, index = 0;
  bool showResult = false;
  List<Map<String, dynamic>> qwithA = [
    {
      "q": "What is your favorite sport??",
      "a": ["FootBall", "valleyBall", "Tennis", "BasketBall"],
      "rightAnswer": "Tennis",
    },
    {
      "q": "What is your favorite color??",
      "a": ["red", "blue", "yellow", "green"],
      "rightAnswer": "green",
    },
    {
      "q": "What is your favorite animal??",
      "a": ["cat", "dog", "horse", "camel"],
      "rightAnswer": "cat",
    }
  ];

  @override
  Widget build(BuildContext context) {
    final qWithIndex = qwithA[index];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!showResult) ...[
                Text(qWithIndex["q"]),
                for (int i = 0; i < qWithIndex["a"].length; i++)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (qWithIndex["a"][i] == qWithIndex["rightAnswer"]) {
                            _counter++;
                          }

                          if (index < qwithA.length - 1) {
                            index++;
                          } else {
                            showResult = true;
                          }
                        });
                      },
                      child: Text(qWithIndex["a"][i]),
                    ),
                  )
              ],
              if (showResult) ...[
                Text("Finally"),
                Text("Your score is $_counter"),
                TextButton(
                  onPressed: () {
                    setState(() {
                      index = 0;
                      showResult = false;
                      _counter = 0;
                    });
                  },
                  child: Text("Reset Quiz"),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
