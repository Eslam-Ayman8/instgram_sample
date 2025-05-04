import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPostTextScreen extends StatefulWidget {
  File _file;
  AddPostTextScreen(this._file, {super.key});

  @override
  State<AddPostTextScreen> createState() => _AddPostTextScreenState();
}

class _AddPostTextScreenState extends State<AddPostTextScreen> {
  final caption = TextEditingController();
  final location = TextEditingController();
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
            child: Text(
              'Share',
              style: TextStyle(color: Colors.blue, fontSize: 15.sp),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
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
                    ),),
                  ],),
                )
              ],
            ),
          )
      )
    );
  }
}
