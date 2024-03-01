import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:log_in/home.dart';
import 'package:log_in/login.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  checkuser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return HomePage(
        title: 'flutter'
      );
    }
    else{
      return MyLogin();
    }
  }
}
