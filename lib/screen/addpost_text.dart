import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgram_sample/data/firebase_service/firestor.dart';
import 'package:instgram_sample/data/firebase_service/storage.dart';


import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

//final supabase = Supabase.instance.client;


class AddPostTextScreen extends StatefulWidget {
  File _file;
  AddPostTextScreen(this._file, {super.key});

  @override
  State<AddPostTextScreen> createState() => _AddPostTextScreenState();
}

class _AddPostTextScreenState extends State<AddPostTextScreen> {
  final caption = TextEditingController();
  final location = TextEditingController();
  bool islooding = false;
  // File? _file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'New Post',
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: false,
        actions: [
          Center(
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  islooding = true;
                });
                // String post_url = await StorageMethod()
                //     .uploadImageToStorage('post', widget._file);
                //String post_url = await
                //final bytes = await widget._file.readAsBytes();

                //final avatarFile = widget._file;
                //final userID = supabase.auth.currentUser!.id;
                //final p_id = Uuid().v4();
                //await supabase.storage.from('images').uploadBinary('/$p_id.jpg', bytes);

                await Firebase_Firestor().CreatePost(
                  postImage: widget._file,
                  caption: caption.text,
                  location: location.text,
                );
                setState(() {
                  islooding = false;
                });
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: Text(
                'Share',
                style: TextStyle(color: Colors.blue, fontSize: 15.sp),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: islooding? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ))
              : Padding(
            padding:  EdgeInsets.only(top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Row(children: [
                    Container(
                      width: 65.w,
                      height: 65.h,
                      decoration: BoxDecoration(
                          color:Colors.amber,
                      image: DecorationImage(image: FileImage(widget._file),
                        fit: BoxFit.cover,
                      )),
                    ),
                    SizedBox(width: 10.w,),
                    SizedBox(width: 280.w,
                      height: 60.h,
                      child:  TextField(
                        controller:caption,
                      decoration: const InputDecoration(
                        hintText: 'Write a caption ....',
                        border: InputBorder.none,
                      ),
                    ),
                    ),
                  ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal:10.w),
                  child: SizedBox(width: 280.w,
                    height: 30.h,
                    child:  TextField(
                      controller:location,
                      decoration: const InputDecoration(
                        hintText: 'Add Location',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      )
    );
  }
}
