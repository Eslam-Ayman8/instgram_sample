import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgram_sample/widgets/post_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: SizedBox(width: 250.w, height: 50.h,child: Image.asset('images/logo.jpg'),
        
        ),
        leading: Image.asset('images/camera.jpg'),
        actions: [
          const Icon(
            Icons.favorite_border_outlined,
            color: Colors.black,
          ),
          Image.asset('images/send.jpg')
        ],
        backgroundColor: const Color(0xffFAFAFA),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context,index){
                    return PostWidget();
                  },
                childCount: 5,
              ),
          ),
        ],
      )
    );
  }
}