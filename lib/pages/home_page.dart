// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:insightify/models/auth_user.dart';
import 'package:insightify/models/survey.dart';
import 'package:insightify/pages/create_form_page.dart';
import 'package:insightify/pages/login_page.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginView(),
        ));
  }

  String? name = FirebaseAuth.instance.currentUser!.displayName;
  @override
  Widget build(BuildContext context) {
    return Consumer<SurveyController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  signOut();
                },
                icon: Icon(Icons.logout)),
          ],
        ),
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
                  // Search box
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: Center(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Find Workspace or typeform",
                            hintStyle: TextStyle(fontSize: 13),
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Workspaces
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            Icon(
                              Icons.person,
                              color: Colors.grey[500],
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'PRIVATE',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[500]),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10)),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add,
                                color: Colors.black87,
                              )),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 350,
                    child: ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'My Workspace',
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                              Text(
                                controller.surveys.length.toString(),
                                style: TextStyle(color: Colors.grey[800]),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          name ?? '',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          'account',
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Responses Collected',
                      style: TextStyle(color: Colors.grey[500], fontSize: 13),
                    ),
                  ),

                  const SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: LinearProgressBar(
                      maxSteps: 10,
                      progressType: LinearProgressBar
                          .progressTypeLinear, // Use Linear progress
                      currentStep: 2,
                      progressColor: Colors.green,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Text(
                          '2',
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                        ),
                        Text(
                          '/',
                          style: TextStyle(color: Colors.black45, fontSize: 15),
                        ),
                        Text(
                          '10',
                          style: TextStyle(color: Colors.black45, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Resets on may 8',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
            // Main content area
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[100]),
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  children: [
                    // Add main content here
                    Text('My Workspace',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 103, 204, 56),
                          ),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateFormPage(),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '+  Create new Form',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Builder(builder: (context) {
                      if (controller.surveys.isNotEmpty) {
                        return GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 0.9),
                          itemCount: controller.surveys.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CreateFormPage(
                                    survey: controller.surveys[index],
                                  ),
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 130,
                                        child: Center(
                                          child: Text(
                                            controller.surveys[index].title,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'No Responses',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.grey[400],
                                                ))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Container(
                          child: Text("Your Surveys will appear here"),
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
