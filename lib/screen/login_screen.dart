import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgram_sample/data/firebase_service/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback show;
  LoginScreen(this.show,{super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  FocusNode email_F = FocusNode();
  final password = TextEditingController();
  FocusNode password_F = FocusNode();
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
          SizedBox(height: 120.h,),
          Textfield(email,Icons.mail,'Email',email_F),
          SizedBox(height: 15.h,),
          Textfield(password,Icons.password,'Password',password_F),
          SizedBox(height: 10.h,),
          Forgot(),
          SizedBox(height: 10.h,),
          Login(),
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
              Text("Don't Have Account ? ",
                style: TextStyle(fontSize: 13.sp,
                color:  Colors.grey,
                fontWeight: FontWeight.normal,
                  ),
              ),
              GestureDetector(
                onTap: widget.show,
              child: Text("Sign Up",
                style: TextStyle(fontSize: 13.sp,
                  color:  Colors.blue,
                  fontWeight: FontWeight.bold,),
              ),
              ),
            ],
          ),
        );
  }

  Widget Login() {
    return Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w),
          child: InkWell(
            onTap: () async {
            await  Authentication().Login(email: email.text, password: password.text);
            },
            child: Container(              //FOR LOGIN BUTTON
              alignment: Alignment.center,
              width: double.infinity,
              height: 55.h,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.r)  ),
              child: Text('Log In',
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
          child: Text('Forgot your password?',
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
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 0.h), // To adjust the hint word position must be equal to position in y axis of icon
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
