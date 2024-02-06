import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0, index = 0;
  bool showResult = false;
  int? choosenindex;
  List<Map<String, dynamic>> qwithA = [
    {
      "q": "What is your favorite sport??",
      "a": {
        "FootBall": Icons.sports_football,
        "ValleyBall": Icons.sports_volleyball,
        "Tennis": Icons.sports_tennis,
        "BasketBall": Icons.sports_basketball
      },
      "rightAnswer": "Tennis",
    },
    {
      "q": "What is your favorite color??",
      "a": {
        'Red': Icons.ac_unit_rounded,
        'Blue': Icons.ac_unit,
        'Yellow': Icons.warning,
        'Green': Icons.check_circle
      },
      "rightAnswer": "Green",
    },
    {
      "q": "What is your favorite animal??",
      "a": {
        'Cat': Icons.check_circle,
        'Dog': Icons.ac_unit,
        'Horse': Icons.check_circle,
        'Camel': Icons.ac_unit,
      },
      "rightAnswer": "Cat",
    }
  ];

  @override
  Widget build(BuildContext context) {
    final qWithIndex = qwithA[index];
    final Map<String, dynamic> answers = qWithIndex["a"];
    List<String> keys = answers.keys.toList();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              if (!showResult) ...[
                Text(
                  qWithIndex["q"],
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  "Answer and get points",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Container(
                  height: size.height * 0.05,
                  width: 80,
                  child: Row(
                    children: [
                      Text(
                        "Step ${index + 1}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' of ${qwithA.length}',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                LinearProgressIndicator(
                  color: Colors.green,
                  value: 0.33 * (1 + index),
                ),
                for (int i = 0; i < qWithIndex["a"].length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          choosenindex = i;
                          if (keys[i] == qWithIndex["rightAnswer"]) {
                            _counter++;
                          }
                        });
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color:
                              i != choosenindex ? Colors.white : Colors.green,
                          border: Border.all(
                            color: Color.fromARGB(255, 221, 215, 215),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Icon(answers[keys[i]]),
                              ),
                              Text(keys[i]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
              if (showResult) ...[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Quiz Result",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Your Score: $_counter",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            index = 0;
                            showResult = false;
                            _counter = 0;
                          });
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        child: Text(
                          "Try Again",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Spacer(),
              if (!showResult) ...[
                Container(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (choosenindex != null) {
                          if (index < qwithA.length - 1) {
                            index++;
                          } else {
                            showResult = true;
                          }
                          choosenindex = null;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please choose an option'),
                            ),
                          );
                        }
                      });
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
