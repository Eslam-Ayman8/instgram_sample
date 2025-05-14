import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instgram_sample/screen/home.dart';
import 'package:instgram_sample/auth/auth_screen.dart';
import 'package:instgram_sample/widgets/navigation.dart';


class MainPage extends StatelessWidget{
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot) {
          print("THE SNAPSHOT DATA STATUS : $snapshot.hasData");
          if(snapshot.hasData) {
            return const Navigations_Screen();
          } else {
            return const AuthPage();
          }
        },
      )
    );
  }
}