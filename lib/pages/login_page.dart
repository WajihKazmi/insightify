import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insightify/firebase_options.dart';
import 'package:insightify/pages/home_page.dart';
import 'package:insightify/pages/registration_page.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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
          toolbarHeight: 230,
          title: Column(
            children: [
              Icon(
                Icons.settings_input_svideo_rounded,
                color: Colors.green[800],
                size: 60,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'WELCOME TO INSIGHTIFY',
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 6,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0,
          //backgroundColor: primary,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.green, Colors.green[50]!])),
          ),
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Stack(alignment: Alignment.center, children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 45, bottom: 50),
                            child: const Text(
                              'SIGN-IN',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          // s
                          Container(
                            margin: const EdgeInsets.only(
                              top: 0,
                              bottom: 20,
                              right: 20,
                              left: 20,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            width: 450,
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
                                hintText: 'E-mail',
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
                          //         color: Colors.white,
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 0,
                              bottom: 35,
                              right: 20,
                              left: 20,
                            ),
                            width: 450,
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
                                icon: const Icon(
                                  Icons.key,
                                  color: Color.fromARGB(255, 103, 204, 56),
                                ),
                                suffixIcon: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                    ),
                                    onPressed: () {
                                      hide();
                                    },
                                    child: const Text(
                                      'show',
                                      maxLines: 1,
                                    )),
                                hintText: 'Password',
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
                                  try {
                                    // ignore: unused_local_variable
                                    final userCredential = await FirebaseAuth
                                        .instance
                                        .signInWithEmailAndPassword(
                                            email: email, password: password);

                                    // ignore: use_build_context_synchronously
                                    if (FirebaseAuth
                                        .instance.currentUser!.emailVerified) {
                                      _firestore
                                          .collection('users')
                                          .doc(userCredential.user!.uid)
                                          .set({
                                        'uid': userCredential.user!.uid,
                                        'email': email,
                                        
                                      }, SetOptions(merge: true));
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(),
                                          ),
                                          (route) => false);
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Error"),
                                              content: const Text(
                                                  'Verify Your Email!'),
                                              actions: [
                                                TextButton(
                                                  child: const Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    }
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
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => RegisterView()),
                                    (route) => false);
                              },
                              child: const Text(
                                "I don't have an account!",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ]);
              default:
                return const Text('Loading...');
            }
          },
        ));
  }
}
// TextFormField(
//                       controller: passwordCtrl,
//                       obscureText: true,
//                       decoration: InputDecoration(
// contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(30)),
//       borderSide: BorderSide(color: AppColor.kTextColor),
//     ),
//                         label: const Text("Password"),
//                         prefixIcon: const Icon(Icons.fingerprint),
//                         suffixIcon: IconButton(icon: const Icon(LineAwesomeIcons.eye_slash), onPressed: () {}),
//                       ),
                     
//        ),