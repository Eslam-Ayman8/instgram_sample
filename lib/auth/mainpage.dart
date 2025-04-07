import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instgram_sample/screen/home.dart';
import 'package:instgram_sample/auth/auth_screen.dart';


class MainPage extends StatelessWidget{
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot) {
          if(snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const AuthPage();
          }
        },
      )
    );
  }
}