import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgram_sample/data/model/usermodel.dart';
import 'package:instgram_sample/util/exeption.dart';
import 'package:uuid/uuid.dart';
import 'package:instgram_sample/data/supabase_service/supabase_storage.dart';

class Firebase_Firestor {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> CreateUser({
    required String email,
    required String username,
    required String bio
    //required String profile,

   }) async {
    print("CREATING USER IN FIRESTORE ____ WAIT email:$email   -username:$username   -bio:$bio ------ ");
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({
        'email': email,
        'username': username,
        'bio': bio,
        'followers': [],
        'following': [],
      });
      print("CREATED USER IN FIRESTORE");
      return true;
    } catch (e) {
      print("Error writing to Firestore: $e");
      return false;
    }

  }

  Future<Usermodel> getUser({String? UID}) async {
    try {
      print("HERE FIND THE PROBLEM123 ");
      final user = await _firebaseFirestore
          .collection('users')
          .doc(UID != null ? UID : _auth.currentUser!.uid)
          .get();
      print("HERE FIND THE PROBLEM567 ");
      final snapuser = user.data()!;
      print("HERE FIND THE PROBLEM11 $snapuser");
      return Usermodel(
          snapuser['bio'],
          snapuser['email'],
          snapuser['followers'],
          snapuser['following'],
        //  snapuser['profile'],
          snapuser['username']);
    } on FirebaseException catch (e) {
      throw exceptions(e.message.toString());
    }
  }

  Future<bool> CreatePost({
    required File postImage,
    required String caption,
    required String location,
  }) async {
    try {
      var uid = Uuid().v4();
      DateTime now = DateTime.now();
      Usermodel user = await getUser();

      final  url = await Supabase_Storage_Method().uploadImageToStorage(uid, postImage);

      await _firebaseFirestore.collection('posts').doc(uid).set({
        'postImage': url,
        'username': user.username,
        //'profileImage': user.profile,
        'caption': caption,
        'location': location,
        'uid': _auth.currentUser!.uid,
        'postId': uid,
        'like': [],
        'time': Timestamp.fromDate(now),
      });

      return true;
    }
    catch (e) {
      print('Error creating post: $e');
      return false;
    }
  }

  Future<bool> CreatReels({
    required String video,
    required String caption,
  }) async {
    var uid = Uuid().v4();
    DateTime data = new DateTime.now();
    Usermodel user = await getUser();
    await _firebaseFirestore.collection('reels').doc(uid).set({
      'reelsvideo': video,
      'username': user.username,
      //'profileImage': user.profile,
      'caption': caption,
      'uid': _auth.currentUser!.uid,
      'postId': uid,
      'like': [],
      'time': data
    });
    return true;
  }

  Future<bool> Comments({
    required String comment,
    required String type,
    required String uidd,
  }) async {
    var uid = Uuid().v4();
    Usermodel user = await getUser();
    await _firebaseFirestore
        .collection(type)
        .doc(uidd)
        .collection('comments')
        .doc(uid)
        .set({
      'comment': comment,
      'username': user.username,
     // 'profileImage': user.profile,
      'CommentUid': uid,
    });
    return true;
  }

  Future<String> like({
    required List like,
    required String type,
    required String uid,
    required String postId,
  }) async {
    String res = 'some error';
    try {
      if (like.contains(uid)) {
        _firebaseFirestore.collection(type).doc(postId).update({
          'like': FieldValue.arrayRemove([uid])
        });
      } else {
        _firebaseFirestore.collection(type).doc(postId).update({
          'like': FieldValue.arrayUnion([uid])
        });
      }
      res = 'seccess';
    } on Exception catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> follow({
    required String uid,
  }) async {
    DocumentSnapshot snap = await _firebaseFirestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();
    List following = (snap.data()! as dynamic)['following'];
    try {
      if (following.contains(uid)) {
        _firebaseFirestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({
          'following': FieldValue.arrayRemove([uid])
        });
        await _firebaseFirestore.collection('users').doc(uid).update({
          'followers': FieldValue.arrayRemove([_auth.currentUser!.uid])
        });
      } else {
        _firebaseFirestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({
          'following': FieldValue.arrayUnion([uid])
        });
        _firebaseFirestore.collection('users').doc(uid).update({
          'followers': FieldValue.arrayUnion([_auth.currentUser!.uid])
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}