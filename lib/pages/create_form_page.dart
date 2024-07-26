import 'package:flutter/material.dart';
import 'package:insightify/models/survey.dart';
import 'package:insightify/pages/home_page.dart';
import 'package:provider/provider.dart';

class CreateFormPage extends StatefulWidget {
  CreateFormPage({Key? key, this.survey}) : super(key: key);

  @override
  State<CreateFormPage> createState() => _CreateFormPageState();

  Survey? survey;
}

class _CreateFormPageState extends State<CreateFormPage> {
  late Survey _survey;
  late int selectedIndex;
  late TextEditingController questionController;
  late TextEditingController surveyTitleController;
  Map<int, List<TextEditingController>> choiceControllersMap = {};

  @override
  void initState() {
    if (widget.survey != null) {
      _survey = widget.survey!;
    } else {
      _survey = Survey(title: 'untitled');
    }
    selectedIndex = 0;
    questionController = TextEditingController();
    surveyTitleController = TextEditingController();
    if (_survey.title != "untitled") {
      surveyTitleController.text = _survey.title;
    }

    // Initialize choice controllers and question controller with data from widget.survey
    for (int i = 0; i < _survey.questions.length; i++) {
      List<TextEditingController> choiceControllers = [];
      for (String choice in _survey.questions[i].choices) {
        choiceControllers.add(TextEditingController(text: choice));
      }
      choiceControllersMap[i] = choiceControllers;
    }

    super.initState();
  }

  @override
  void dispose() {
    questionController.dispose();
    for (var entry in choiceControllersMap.entries) {
      for (var controller in entry.value) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SurveyController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: Row(
            children: [
              // Drawer
              Container(
                width: 300, // Adjust width as needed
                decoration: BoxDecoration(
                  color: Colors.white, // Customize background color
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 2),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: surveyTitleController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Survey Title",
                            hintStyle: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Content',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Question question =
                                    Question(content: 'untitled');
                                _survey.addQuestion(question);
                                setState(() {
                                  selectedIndex = _survey.questions.length - 1;
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.black87,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 450,
                      child: ListView.builder(
                        itemCount: _survey.questions.length,
                        itemBuilder: (context, index) {
                          Question question = _survey.questions[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              decoration: BoxDecoration(
                                  color: selectedIndex == index
                                      ? Colors.grey[200]
                                      : Colors.white),
                              child: Row(
                                children: [
                                  Container(
                                    width: 70,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(240, 214, 92, 153),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          (index + 1).toString(),
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    question.content,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 103, 204, 56),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {
                            _survey.deleteAllQuestions();
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: const Text(
                              'Delete All',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 103, 204, 56),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {
                            _survey.title = surveyTitleController.text;
                            controller.surveys.add(_survey);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: const Text(
                              'Save Form',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              // Main content area
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 30),
                    child: Builder(
                      builder: (context) {
                        if (_survey.questions.isNotEmpty) {
                          Question? selectedQuestion =
                              _survey.getQuestion(selectedIndex);
                          questionController.text = selectedQuestion.content;
                          if (selectedQuestion.content == "untitled") {
                            questionController.text = "";
                          }
                          // Initialize choice controllers for the current question
                          choiceControllersMap.putIfAbsent(
                              selectedIndex, () => []);
                          List<TextEditingController> choiceControllers =
                              choiceControllersMap[selectedIndex]!;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListView(
                              children: [
                                Text(
                                  (selectedIndex + 1).toString() + '.',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 103, 204, 56),
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: questionController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter prompt",
                                  ),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black87),
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    for (var i = 0;
                                        i < choiceControllers.length;
                                        i++)
                                      TextField(
                                        controller: choiceControllers[i],
                                        decoration: InputDecoration(
                                          labelText:
                                              'Multiple Choice Option ${i + 1}',
                                          labelStyle:
                                              const TextStyle(fontSize: 10),
                                          contentPadding:
                                              const EdgeInsets.all(4),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    TextButton(
                                      onPressed: () {
                                        final newController =
                                            TextEditingController();
                                        choiceControllers.add(newController);
                                        selectedQuestion.content =
                                            questionController.text;
                                        setState(() {}); // Trigger rebuild
                                      },
                                      child: const Text(
                                        'Add Choice',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 103, 204, 56),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (selectedQuestion.content != "") {
                                      selectedQuestion.content =
                                          questionController.text;
                                      List<String> choices = [];
                                      for (var controller
                                          in choiceControllers) {
                                        choices.add(controller.text);
                                      }
                                      selectedQuestion.choices = choices;
                                      _survey.updateQuestion(
                                          selectedIndex, selectedQuestion);

                                      setState(() {});
                                    }
                                  },
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
