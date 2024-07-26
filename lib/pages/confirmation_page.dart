import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insightify/pages/home_page.dart';
import 'package:insightify/pages/login_page.dart';

class ConfirmationView extends StatefulWidget {
  final String displayName;

  const ConfirmationView({
    super.key,
    required this.displayName,
  });

  @override
  State<ConfirmationView> createState() => _ConfirmationViewState();
}

class _ConfirmationViewState extends State<ConfirmationView> {
  bool isEmailVerified = false;
  Timer? timer;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? downloadUrl;
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendEmailVerification();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'email': FirebaseAuth.instance.currentUser!.email,
        'username': widget.displayName,
      }, SetOptions(merge: true));
      timer?.cancel();
    }
  }

  Future sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(e.toString()),
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
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const HomePage()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.green, Colors.green[50]!]))),
              leading: IconButton(
                constraints: const BoxConstraints(),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginView()),
                      (route) => false);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 20,
                ),
                color: Colors.white,
              ),
              leadingWidth: 40,
              toolbarHeight: kToolbarHeight,
              title: const SizedBox(
                child: Text(
                  'Verify Email',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 3,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            body: Container(
              alignment: Alignment.center,
              child: const Text(
                'The verification email has been sent!\nVerify through the link in the Email!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}
