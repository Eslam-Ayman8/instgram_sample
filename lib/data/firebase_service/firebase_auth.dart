import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:instgram_sample/data/firebase_service/firebase.dart';
import 'package:instgram_sample/data/firebase_service/storage.dart';
import 'package:instgram_sample/util/exeption.dart';

class Authentication{
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> Login({
    required String email,
    required String password

}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
    }on FirebaseException catch(e){
      throw exceptions(e.message.toString());
    }
  }
  Future<void> Signup({
    required String email,
    required String password,
    required String passwordConfirme,
    required String username,
    required String bio,
    required File profile,
})async {
    String URL;
    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty &&
          bio.isNotEmpty) {
        if (password == passwordConfirme) {
          await _auth.createUserWithEmailAndPassword(
              email: email.trim(),
            password: password.trim(),
          );
          //upload profile image on storage

          if (profile != File('')){
            URL = await StorageMethod().uploadImageToStorage('Profile', profile);
          }else{
            URL = '';
          }

          // get information with firestore

          await Firebase_Firestor().CreateUser(email: email
              , username: username
              , bio: bio
              , profile:
              URL==''
                  ?'a'
                  :URL

          );
        }


        else {
          throw exceptions('The password must match the confirmed password');
        }
      }
      else {
      throw exceptions('enter all the fields');
    }
  }on FirebaseException catch(e){
      throw exceptions(e.message.toString());
    }
  }
}