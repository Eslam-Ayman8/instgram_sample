import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgram_sample/data/firebase_service/firebase_auth.dart';
import 'package:instgram_sample/util/dialog.dart';
import 'package:instgram_sample/util/exeption.dart';

import '../util/imagepicker.dart';



class SignUpScreen extends StatefulWidget {
  final VoidCallback show;
  SignUpScreen(this.show,{super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final email = TextEditingController();
  FocusNode email_F = FocusNode();

  final username = TextEditingController();
  FocusNode username_F = FocusNode();

  final bio = TextEditingController();
  FocusNode bio_F = FocusNode();

  final password = TextEditingController();
  FocusNode password_F = FocusNode();

  final passwordConfirme = TextEditingController();
  FocusNode passwordConfirme_F = FocusNode();

  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(width: 96.w, height: 100.h,),
              Center(
                child: Image.asset("images/logo.jpg"),
              ),
              SizedBox(height: 20.h,),
              Center(child:
              InkWell(
                onTap: () async{
                  File _imagefilee = await ImagePickerr().uploadImage('gallery');
                  setState(() {
                    _imageFile = _imagefilee; //?????????????????????????
                  });
                },
                child: CircleAvatar(
                  radius: 36.r,
                  backgroundColor: Colors.grey,

                  child: _imageFile ==null? CircleAvatar(
                    radius: 36.r,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(radius: 32.r,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: AssetImage('images/person.jpg'),),
                  ) : CircleAvatar(
                    radius: 36.r,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(radius: 32.r,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: Image.file(_imageFile!, fit: BoxFit.cover,).image ),
                  )
                ),
              ),
                ),
              SizedBox(height: 50.h,),
              Textfield(email,Icons.mail,'Email',email_F),
              SizedBox(height: 15.h,),
              Textfield(username,Icons.person,'Username',username_F),
              SizedBox(height: 15.h,),
              Textfield(bio,Icons.abc,'BIO',bio_F),
              SizedBox(height: 15.h,),
              Textfield(password,Icons.password,'Password',password_F),
              SizedBox(height: 15.h,),
              Textfield(passwordConfirme,Icons.password,'Password Confirm',passwordConfirme_F),
              SizedBox(height: 10.h,),
              SignUp(),
              SizedBox(height: 10.h,),
              //Have()

            ],
          ),),
        bottomNavigationBar: Have(),
    );
  }

  Widget Have() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Have Account?",
            style: TextStyle(fontSize: 13.sp,
              color:  Colors.grey,
              fontWeight: FontWeight.normal,
            ),
          ),
          GestureDetector(
            onTap: widget.show,
            child: Text("Sign In",
              style: TextStyle(fontSize: 13.sp,
                color:  Colors.blue,
                fontWeight: FontWeight.bold,),
            ),
          ),
        ],
      ),
    );
  }

  Widget SignUp() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        onTap: () async{
          try{
            await Authentication().Signup(email: email.text, password: password.text, passwordConfirme: passwordConfirme.text, username: username.text, bio: bio.text); //profile: File('') is missing
          }on exceptions catch(e){
            dialogBuilder(context, e.massage);
          }
        },
        child: Container(              //FOR LOGIN BUTTON
            alignment: Alignment.center,
            width: double.infinity,
            height: 55.h,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15.r)  ),
            child: Text('Sign Up',
              style: TextStyle(
                fontSize: 23.sp,
                color:  Colors.white,
                fontWeight: FontWeight.bold,),
            )
        ),
      ),
    );
  }

  Widget Forgot() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 15.w),
      child: Text('Forgot your passowrd?',
          style: TextStyle(fontSize: 13.sp,
            color:  Colors.blue,
            fontWeight: FontWeight.bold,
          )
      ),
    );
  }
//Here we have a lot of inputs as widget like email, password each of them has controller icon type and focusNode
  //Starting from the design to the functions
  Widget Textfield(TextEditingController controller, IconData icon, String type, FocusNode focusNode) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),      //symmetric in padding like select specific axis, or select (ALL)
      child: Container(                                  // From here we can make more entries like this start here till end of Container block
        height: 44.h,
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r),
        ),

        child: TextField(
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
          controller: controller,                                                             // controller parameter
          focusNode: focusNode,                                                              //focus node parameter
          decoration: InputDecoration(
            hintText: type,
            prefixIcon: Icon(icon, color: focusNode.hasFocus? Colors.black : Colors.grey,),  //get icon with color condition
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 0.h),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: BorderSide(color: Colors.grey,width:2.w)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: BorderSide(color: Colors.black,width:2.w)
            ),

          ),
        ),
      ),
    );
  }
}
