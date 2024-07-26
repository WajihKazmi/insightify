import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:insightify/firebase_options.dart';
import 'package:insightify/pages/confirmation_page.dart';
import 'package:insightify/pages/login_page.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _username;
  late final TextEditingController _confirmPassword;
  bool error = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _username = TextEditingController();
    _confirmPassword = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void hide() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  var isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 33, 41),
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.green, Colors.green[50]!])),
        ),
        // leading: IconButton(
        //   constraints: const BoxConstraints(),
        //   onPressed: () {
        //     Navigator.of(context)
        //         .pushNamedAndRemoveUntil(loginroute, (route) => false);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios_rounded,
        //     size: 20,
        //   ),
        //   color: Colors.black,
        // ),
        leadingWidth: 40,
        toolbarHeight: 150,
        title: const SizedBox(
          child: Text(
            'Create an account',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              letterSpacing: 2.5,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 25,
                        )
                        // Container(
                        //   padding: const EdgeInsets.only(top: 20, bottom: 20),
                        //   child: const Text(
                        //     'REGISTER',
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 25,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        ,

                        // Container(
                        //   padding: const EdgeInsets.only(
                        //       right: 301, top: 30, bottom: 5),
                        //   child: const Text(
                        //     'Username',
                        //     style: TextStyle(
                        //         fontSize: 14, fontWeight: FontWeight.w500),
                        //   ),
                        // ),
                        Container(
                          width: 450,
                          margin: const EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                            right: 20,
                            left: 20,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _username,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 103, 204, 56),
                              ),
                              contentPadding: EdgeInsets.only(right: 45),
                              hintText: 'Username',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.only(
                        //       right: 320, top: 20, bottom: 5),
                        //   child: const Text(
                        //     'E-mail',
                        //     style: TextStyle(
                        //         fontSize: 14, fontWeight: FontWeight.w500),
                        //   ),
                        // ),
                        Container(
                          width: 450,
                          margin: const EdgeInsets.only(
                            top: 0,
                            bottom: 20,
                            right: 20,
                            left: 20,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _email,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.email_rounded,
                                color: Color.fromARGB(255, 103, 204, 56),
                              ),
                              contentPadding: EdgeInsets.only(right: 45),
                              hintText: 'abc123@xyz.com',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.only(
                        //       right: 300, top: 5, bottom: 5),
                        //   child: const Text(
                        //     'Password',
                        //     style: TextStyle(
                        //         fontSize: 14, fontWeight: FontWeight.w500),
                        //   ),
                        // ),
                        Container(
                          width: 450,
                          margin: const EdgeInsets.only(
                            top: 0,
                            bottom: 20,
                            right: 20,
                            left: 20,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _password,
                            obscureText: isHidden,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              errorText:
                                  error ? 'Passwords do not match!' : null,
                              icon: const Icon(
                                Icons.key,
                                color: Color.fromARGB(255, 103, 204, 56),
                              ),
                              suffixIcon: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Color.fromARGB(255, 103, 204, 56),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'show',
                                    maxLines: 1,
                                  )),
                              hintText: 'Password',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.only(
                        //       right: 240, top: 5, bottom: 5),
                        //   child: const Text(
                        //     'Confirm Password',
                        //     style: TextStyle(
                        //         fontSize: 14, fontWeight: FontWeight.w500),
                        //   ),
                        // ),
                        Container(
                          width: 450,
                          margin: const EdgeInsets.only(
                            top: 0,
                            bottom: 30,
                            right: 20,
                            left: 20,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _confirmPassword,
                            obscureText: isHidden,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              errorText:
                                  error ? 'Passwords do not match!' : null,
                              icon: const Icon(
                                Icons.key,
                                color: Color.fromARGB(255, 103, 204, 56),
                              ),
                              suffixIcon: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Color.fromARGB(255, 103, 204, 56),
                                  ),
                                  onPressed: () {
                                    hide();
                                  },
                                  child: const Text(
                                    'show',
                                    maxLines: 1,
                                  )),
                              hintText: 'Confirm Password',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          width: 150,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    Color.fromARGB(255, 103, 204, 56),
                              ),
                              onPressed: () async {
                                final email = _email.text;
                                final password = _password.text;
                                if (_confirmPassword.text == _password.text) {
                                  if (_confirmPassword.text.isNotEmpty ||
                                      _password.text.isNotEmpty ||
                                      _email.text.isNotEmpty ||
                                      _username.text.isNotEmpty) {
                                    try {
                                      // ignore: unused_local_variable
                                      final userCredential = await FirebaseAuth
                                          .instance
                                          .createUserWithEmailAndPassword(
                                              email: email, password: password);
                                        
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ConfirmationView(
                                              displayName: _username.text,
                                            ),
                                          ),
                                          (route) => false);
                                    } on FirebaseAuthException catch (e) {
                                      return showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Error"),
                                              content: Text(e.code),
                                              actions: [
                                                TextButton(
                                                  child: const Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    }
                                  } else {
                                    return showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Error"),
                                            content:
                                                const Text('A field is empty'),
                                            actions: [
                                              TextButton(
                                                child: const Text("Ok"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  }
                                } else {
                                  setState(() {
                                    _confirmPassword.clear();
                                    _password.clear();
                                    error = !error;
                                  });
                                }
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              "Already Registered?",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              default:
                return const Text('Leading...');
            }
          }),
    );
  }
}
