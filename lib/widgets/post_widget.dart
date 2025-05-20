import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgram_sample/data/firebase_service/firestor.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../util/image_cached.dart';

class PostWidget extends StatelessWidget {
  final snapshot;
  final supabase = Supabase.instance.client;

  PostWidget(this.snapshot,{super.key});


  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Container(
          width:375.w,
          height: 54.h,
          color: Colors.white,
          child: Center(
            child: ListTile(
              leading: ClipOval(
                child: SizedBox(
                    width: 35.w,
                    height: 35.h,
                    child: Image.asset('images/person.jpg')//PLACE WITH WHEN INIT PROFILE IMAGE --> CachedImage(snapshot['profileImage']),
                ),
              ),
              title: Text(
                snapshot['username'],
                style: TextStyle(fontSize: 13.sp),),
              subtitle: Text(
                snapshot['location'],
                style: TextStyle(fontSize: 11.sp),),
              trailing: const Icon(Icons.more_horiz),
            ),
          ),
        ),
        Container(
            width: 375.h,
            height: 375.h,


            child: CachedImage(snapshot['postImage']//snapshot['postImage']
            )
        ),
        Container(
          width: 375.w,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(width: 14.h,),
              Row(
                children: [
                  SizedBox(width: 14.w,),
                  Icon(Icons.favorite_outline_rounded,
                    size: 25.w,
                  ),
                  SizedBox(width: 17.w,),
                  Image.asset(
                    'images/comment.jpg',
                    height: 28.h,),
                  SizedBox(width: 17.w,),
                  Image.asset(
                    'images/send.jpg',
                    height: 28.h,),
                  const Spacer(),
                  SizedBox(width: 17.w,),
                  Padding(
                    padding:  EdgeInsets.only(right: 15.w),
                    child: Image.asset(
                      'images/save.jpg',
                      height: 28.h,),
                  )

                ],
              ),
              Padding(
                padding:  EdgeInsets.only(
                    left: 19.w,
                    top: 13.5.h,
                    bottom: 5.h),
                child: Text(
                  snapshot['like'].length.toString(),
                  style: TextStyle(fontSize: 13.sp,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  children: [
                    Text(
                      'username ' + '',
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      snapshot['caption'],
                      style: TextStyle(
                        fontSize: 13.sp,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 15.w,
                    top: 20.h,
                    bottom: 8.h
                ),
                child: Text(
                  formatDate(
                  snapshot['time'].toDate(), [yyyy, '-', mm, '-', dd]),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey
                ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
